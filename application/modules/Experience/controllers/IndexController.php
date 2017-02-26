<?php
class Experience_IndexController extends Core_Controller_Action_Standard {
	/* ------ Init Contidition & Needed Resource Function ----- */
	public function init() {
		// Only show to user if view permisssion authorized
		if (!$this -> _helper -> requireAuth() -> setAuthParams('experience', null, 'view') -> isValid())
			return;
	}

	/* ------ Experience Home Page Function ----- */
	public function indexAction() {
		// Landing page mode
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}

	/* ----- General Experience Listing Function ----- */
	public function listingAction() {
		$category = Engine_Api::_()->getItem('experience_category', $this->_getParam('category'));
		if( $category ){
			Engine_Api::_()->core()->setSubject($category);
		}
		// Search Params

		// Do the show thingy
			// Get an array of friend ids
			// Get stuff
			// unset($values['show']);

		// Get experience paginator

		// Render
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}

	/* ------ A User Experiences List Function ----- */
	public function listAction() {
		// Preload info
		$category = Engine_Api::_()->getItem('experience_category', $this->_getParam('category'));
		if( $category ){
			Engine_Api::_()->core()->setSubject($category);
		}

		// Search Params


		// Get paginator
		// Render
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}

	/* ----- Experience Creation Function ----- */
	public function createAction() {
		// Check authoraiztion permisstion
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		if (!$this -> _helper -> requireAuth() -> setAuthParams('experience', null, 'create') -> isValid())
			return;

		// Render
		$this -> _helper -> content -> setEnabled();

		$viewer = Engine_Api::_() -> user() -> getViewer();

		// Checking maximum experience allowed
		$this -> view -> maximum_experiences = $maximum_experiences = Engine_Api::_() -> getItemTable('experience') -> checkMaxExperiences();
		$experience_number = Engine_Api::_() -> getItemTable('experience') -> getCountExperience($viewer);
		if ($maximum_experiences == 0 || $experience_number < $maximum_experiences) {
			$this -> view -> maximum_reach = false;
		} else {
			$this -> view -> maximum_reach = true;
		}

		// Get navigation
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('experience_main');

		// Prepare form
		$this -> view -> form = $form = new Experience_Form_Create();

		// Post request checking
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost())) {
			return;
		}

		// Process
		$table = Engine_Api::_() -> getDbTable('experiences', 'experience');
		$db = $table -> getAdapter();
		$db -> beginTransaction();
		try {
			// Create experience
			$values = array_merge($form -> getValues(), array('owner_type' => $viewer -> getType(), 'owner_id' => $viewer -> getIdentity()));

			// Moderation mode
			$experience_moderation = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('experience.moderation', 0);
			if ($experience_moderation) 
			{
				$values['is_approved'] = 0;
			} 
			else 
			{
				$values['is_approved'] = 1;
			}
			$experience = $table -> createRow();
			$experience -> setFromArray($values);
			$experience -> save();

			// Authorization set up
			$auth = Engine_Api::_() -> authorization() -> context;
			$roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'everyone');

			if (empty($values['auth_view'])) {
				$values['auth_view'] = 'everyone';
			}

			if (empty($values['auth_comment'])) {
				$values['auth_comment'] = 'everyone';
			}

			$viewMax = array_search($values['auth_view'], $roles);
			$commentMax = array_search($values['auth_comment'], $roles);

			foreach ($roles as $i => $role) {
				$auth -> setAllowed($experience, $role, 'view', ($i <= $viewMax));
				$auth -> setAllowed($experience, $role, 'comment', ($i <= $commentMax));
			}

			// Add tags
			$tags = preg_split('/[,]+/', $values['tags']);
			$experience -> tags() -> addTagMaps($viewer, $tags);
			
			// Set photo
	      	if( !empty($values['photo']) ) {
		        $experience->setPhoto($form->photo);
	      	}

			// Add activity only if experience is published
			if ($values['draft'] == 0 && $values['is_approved'] == 1) 
			{
				$action = Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($viewer, $experience, 'experience_new');

				// Make sure action exists before attaching the experience to the
				// activity
				if ($action) {
					Engine_Api::_() -> getDbtable('actions', 'activity') -> attachActivity($action, $experience);
				}
				
				// Send notifications for subscribers
				Engine_Api::_() -> getDbtable('subscriptions', 'experience') -> sendNotifications($experience);

				$experience -> add_activity = 1;
				$experience -> save();
			}
			// Send notify admin
			if($experience_moderation && $values['draft'] == 0)
			{
				$users_table = Engine_Api::_()->getDbtable('users', 'user');
			  	$users_select = $users_table->select()
		  	    	->where('level_id = ?', 1)
			    	->where('enabled >= ?', 1)
					->limit(1);
			  	$super_admin = $users_table->fetchRow($users_select);
				if(!$super_admin -> isSelf($viewer))
				{
					$mailAdminType = 'notify_admin_experience_moderation';
					$mailAdminParams = array(
						'host' => $_SERVER['HTTP_HOST'],
						'date' => date("F j, Y, g:i a"),
						'recipient_title' => $super_admin->displayname,
						'sender_title' => $viewer->displayname,
						'object_title' => $experience -> getTitle(),
						'object_link' => $experience->getHref(),
					);
					Engine_Api::_()->getApi('mail', 'core')->sendSystem(
				         $super_admin,
				         $mailAdminType,
				         $mailAdminParams
			      	);
				}
			}
			
			// Commit
			$db -> commit();
		} catch ( Exception $e ) {
			$db -> rollBack();
			throw $e;
		}

		return $this -> _helper -> redirector -> gotoRoute(array('action' => 'manage'));
	}

	/* ----- User Experiences Manage Page Function ----- */
	public function manageAction() {
		// Check authoraiztion permisstion
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		// Render
		$this -> _helper -> content -> setEnabled();

		// Get quick navigation
		$this -> view -> quickNavigation = $quickNavigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('experience_quick');

		// Prepare data
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$this -> view -> form = $form = new Experience_Form_Search();
		$this -> view -> canCreate = $this -> _helper -> requireAuth() -> setAuthParams('experience', null, 'create') -> checkRequire();
		$form -> removeElement('show');

		// Process form
		if( $form -> isValid($this -> _getAllParams())) {
			$values = $form -> getValues();
		} else {
			$values = array();
		}
		$this -> view -> formValues = array_filter($values);
		$values['user_id'] = $viewer -> getIdentity();
		$mode = $values['mode'];

		if (isset($mode)) {
			if ($mode == '0') {
				$values['draft'] = 1;
			} else if ($mode == '1') {
				$values['draft'] = 0;
				$values['is_approved'] = 0;
			} else if ($mode == '2') {
				$values['draft'] = 0;
				$values['is_approved'] = 1;
			}
		}
		// Get experience paginator
		$this -> view -> paginator = $paginator = Engine_Api::_() -> experience() -> getExperiencesPaginator($values);
		$items_per_page = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('experience.page', 10);
		$paginator -> setItemCountPerPage($items_per_page);
		$this -> view -> paginator = $paginator -> setCurrentPageNumber($values['page']);
	}

	/* ----- Experience Edit Function ----- */
	public function editAction() {
		// User checking
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();

		// Get chosen experience to edit
		$experience = Engine_Api::_() -> getItem('experience', $this -> _getParam('experience_id'));
		if (!Engine_Api::_() -> core() -> hasSubject('experience')) {
			Engine_Api::_() -> core() -> setSubject($experience);
		}
		if (!$this -> _helper -> requireSubject() -> isValid())
			return;
		if (!$this -> _helper -> requireAuth() -> setAuthParams($experience, $viewer, 'edit') -> isValid())
			return;

		// Get navigation
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('experience_main');

		// Prepare form
		$this -> view -> form = $form = new Experience_Form_Edit();

		// Populate form
		$form -> populate($experience -> toArray());

		$tagStr = '';
		foreach ($experience->tags ()->getTagMaps () as $tagMap) {
			$tag = $tagMap -> getTag();
			if (!isset($tag -> text))
				continue;
			if ('' !== $tagStr)
				$tagStr .= ', ';
			$tagStr .= $tag -> text;
		}
		$form -> populate(array('tags' => $tagStr));
		$this -> view -> tagNamePrepared = $tagStr;

		$auth = Engine_Api::_() -> authorization() -> context;
		$roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');

		foreach ($roles as $role) {
			if ($form -> auth_view) {
				if ($auth -> isAllowed($experience, $role, 'view')) {
					$form -> auth_view -> setValue($role);
				}
			}

			if ($form -> auth_comment) {
				if ($auth -> isAllowed($experience, $role, 'comment')) {
					$form -> auth_comment -> setValue($role);
				}
			}
		}

		// hide status change if it has been already published
		if ($experience -> draft == "0") {
			$form -> removeElement('draft');
		}

		// Check post/form
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		if (!$form -> isValid($this -> getRequest() -> getPost())) {
			return;
		}

		// Process
		$db = Engine_Db_Table::getDefaultAdapter();
		$db -> beginTransaction();

		try {
			$values = $form -> getValues();

			$experience -> setFromArray($values);
			$experience -> modified_date = date('Y-m-d H:i:s');
			$experience -> save();

			// Authorization
			if (empty($values['auth_view'])) {
				$values['auth_view'] = 'everyone';
			}

			if (empty($values['auth_comment'])) {
				$values['auth_comment'] = 'everyone';
			}

			$viewMax = array_search($values['auth_view'], $roles);
			$commentMax = array_search($values['auth_comment'], $roles);

			foreach ($roles as $i => $role) {
				$auth -> setAllowed($experience, $role, 'view', ($i <= $viewMax));
				$auth -> setAllowed($experience, $role, 'comment', ($i <= $commentMax));
			}

			// Handle tags
			$tags = preg_split('/[,]+/', $values['tags']);
			$experience -> tags() -> setTagMaps($viewer, $tags);
			
			// Set photo
	      	if( !empty($values['photo']) ) {
		        $experience->setPhoto($form->photo);
	      	}

			// Insert new activity if experience is just getting published and
			// approved
			if (!$experience -> add_activity && !$experience -> draft && $experience -> is_approved) {
				$action = Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($viewer, $experience, 'experience_new');
				// make sure action exists before attaching the experience to the
				// activity
				if ($action) {
					Engine_Api::_() -> getDbtable('actions', 'activity') -> attachActivity($action, $experience);
				}

				$experience -> add_activity = 1;
				$experience -> save();
			}
			
			// Send notify admin
			if(isset($values['draft']) &&  $values['draft'] == 0 && !$experience -> is_approved)
			{
				$users_table = Engine_Api::_()->getDbtable('users', 'user');
			  	$users_select = $users_table->select()
		  	    	->where('level_id = ?', 1)
			    	->where('enabled >= ?', 1)
					->limit(1);
			  	$super_admin = $users_table->fetchRow($users_select);
				if(!$super_admin -> isSelf($viewer))
				{
					$mailAdminType = 'notify_admin_experience_moderation';
					$mailAdminParams = array(
						'host' => $_SERVER['HTTP_HOST'],
						'date' => date("F j, Y, g:i a"),
						'recipient_title' => $super_admin->displayname,
						'sender_title' => $viewer->displayname,
						'object_title' => $experience -> getTitle(),
						'object_link' => $experience->getHref(),
					);
					Engine_Api::_()->getApi('mail', 'core')->sendSystem(
				         $super_admin,
				         $mailAdminType,
				         $mailAdminParams
			      	);
				}
			}

			// Rebuild privacy
			$actionTable = Engine_Api::_() -> getDbtable('actions', 'activity');
			foreach ($actionTable->getActionsByObject ( $experience ) as $action) {
				$actionTable -> resetActivityBindings($action);
			}

			// Send notifications for subscribers
			Engine_Api::_() -> getDbtable('subscriptions', 'experience') -> sendNotifications($experience);

			$db -> commit();
		} catch ( Exception $e ) {
			$db -> rollBack();
			throw $e;
		}

		return $this -> _helper -> redirector -> gotoRoute(array('action' => 'manage'));
	}

	/* ----- Experience Delete Action ----- */
	public function deleteAction() {
		// User checking
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();

		$experience = Engine_Api::_() -> getItem('experience', $this -> getRequest() -> getParam('experience_id'));
		if (!$this -> _helper -> requireAuth() -> setAuthParams($experience, null, 'delete') -> isValid())
			return;

		// In smoothbox
		$this -> _helper -> layout -> setLayout('default-simple');

		$this -> view -> form = $form = new Experience_Form_Delete();

		if (!$experience) {
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _("Experience entry doesn't exist or not authorized to delete.");
			return;
		}

		if (!$this -> getRequest() -> isPost()) {
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _('Invalid request method.');
			return;
		}

		$db = $experience -> getTable() -> getAdapter();
		$db -> beginTransaction();

		try {
			$experience -> delete();

			$db -> commit();
		} catch ( Exception $e ) {
			$db -> rollBack();
			throw $e;
		}

		$this -> view -> status = true;
		$this -> view -> message = Zend_Registry::get('Zend_Translate') -> _('Your experience entry has been deleted.');
		return $this -> _forward('success', 'utility', 'core', array('parentRedirect' => Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array('action' => 'manage'), 'experience_general', true), 'messages' => Array($this -> view -> message)));
	}

	public function styleAction() {
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		if (!$this -> _helper -> requireAuth() -> setAuthParams('experience', null, 'style') -> isValid())
			return;

		// In smoothbox
		$this -> _helper -> layout -> setLayout('default-simple');

		// Require user
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		$user = Engine_Api::_() -> user() -> getViewer();

		// Make form
		$this -> view -> form = $form = new Experience_Form_Style();

		// Get current row
		$table = Engine_Api::_() -> getDbtable('styles', 'core');
		$select = $table -> select() -> where('type = ?', 'user_experience') -> // @todo this is not a real type
		where('id = ?', $user -> getIdentity()) -> limit(1);

		$row = $table -> fetchRow($select);

		// Check post
		if (!$this -> getRequest() -> isPost()) {
			$form -> populate(array('style' => (null === $row ? '' : $row -> style)));
			return;
		}

		if (!$form -> isValid($this -> getRequest() -> getPost())) {
			return;
		}

		// Cool! Process
		$style = $form -> getValue('style');

		// Save
		if (null == $row) {
			$row = $table -> createRow();
			$row -> type = 'user_experience';
			// @todo this is not a real type
			$row -> id = $user -> getIdentity();
		}

		$row -> style = $style;
		$row -> save();

		$this -> view -> draft = true;
		$this -> view -> message = Zend_Registry::get('Zend_Translate') -> _("Your changes have been saved.");
		$this -> _forward('success', 'utility', 'core', array('smoothboxClose' => true, 'parentRefresh' => false, 'messages' => array($this -> view -> message)));
	}

	public function viewAction() {
		// Check permission
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$experience = Engine_Api::_() -> getItem('experience', $this -> _getParam('experience_id'));
		if ($experience) {
			Engine_Api::_() -> core() -> setSubject($experience);
		}

		if (!$this -> _helper -> requireSubject() -> isValid()) {
			return;
		}
		// if (!$this -> _helper -> requireAuth() -> setAuthParams($experience, $viewer, 'view') -> isValid()) {
			// return;
		// }
		if (!$experience || !$experience -> getIdentity() || ($experience -> draft && !$experience -> isOwner($viewer)) || (!$experience -> is_approved && !$experience -> isOwner($viewer) && !$viewer -> isAdmin())) {
			return $this -> _helper -> requireSubject -> forward();
		}

		// Prepare data
		$experienceTable = Engine_Api::_() -> getItemTable('experience');

		$this -> view -> experience = $experience;
		$this -> view -> owner = $owner = $experience -> getOwner();
		$this -> view -> viewer = $viewer;

		if (!$experience -> isOwner($viewer)) {
			$experienceTable -> update(array('view_count' => new Zend_Db_Expr('view_count + 1')), array('experience_id = ?' => $experience -> getIdentity()));
		}

		// Get tags
		$this -> view -> blogTags = $experience -> tags() -> getTagMaps();

		// Get category
		if (!empty($experience -> category_id)) {
			$this -> view -> category = Engine_Api::_() -> getItemTable('experience_category') -> find($experience -> category_id) -> current();
		}

		// Get styles
		$table = Engine_Api::_() -> getDbtable('styles', 'core');
		$style = $table -> select() -> from($table, 'style') -> where('type = ?', 'user_experience') -> where('id = ?', $owner -> getIdentity()) -> limit(1);

		$row = $table -> fetchRow($style);
		if (!empty($row)) {
			$this -> view -> headStyle() -> appendStyle($row -> style);
		}
		if ($experience -> link_detail) {
			$view = Zend_Registry::get('Zend_View');
			$view -> headLink(array('rel' => 'canonical', 'href' => $experience -> link_detail), 'PREPEND');
		}

		// Render
		$this -> _helper -> content
			-> setEnabled();
	}

	public function becomeAction() {
		// Disable layout
		$this -> _helper -> layout -> disableLayout();
		// Don't use view
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		// Check permission
		if (!$this -> _helper -> requireUser() -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$experience = Engine_Api::_() -> getItem('experience', $this -> _getParam('experience_id'));
		if (!$this -> _helper -> requireAuth() -> setAuthParams($experience, $viewer, 'view') -> isValid())
			return;
		// Process
		$table = Engine_Api::_() -> getDbtable('becomes', 'experience');
		$db = $table -> getAdapter();
		$db -> beginTransaction();
		try {
			// Create become_member
			$become = $table -> createRow();
			$become -> experience_id = $experience -> experience_id;
			$become -> user_id = $viewer -> getIdentity();
			$become -> save();

			$experience -> become_count = $experience -> become_count + 1;
			$experience -> save();
			// Commit
			$db -> commit();
		} catch ( Exception $e ) {
			$db -> rollBack();
			throw $e;
		}
	}

	public function uploadPhotoAction() {
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$this -> _helper -> layout -> disableLayout();

		if (!Engine_Api::_() -> authorization() -> isAllowed('album', $viewer, 'create')) {
			return false;
		}

		if (!$this -> _helper -> requireAuth() -> setAuthParams('album', null, 'create') -> isValid())
			return;

		if (!$this -> _helper -> requireUser() -> checkRequire()) {
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _('Max file size limit exceeded (probably).');
			return;
		}

		if (!$this -> getRequest() -> isPost()) {
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _('Invalid request method');
			return;
		}
		if (!isset($_FILES['userfile']) || !is_uploaded_file($_FILES['userfile']['tmp_name'])) {
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _('Invalid Upload');
			return;
		}
		$albumPhoto_Table = NULL;
		$album_Table = NULL;
		if(Engine_Api::_() -> hasModuleBootstrap('advalbum'))
		{
			$albumPhoto_Table = Engine_Api::_() -> getDbtable('photos', 'advalbum');
			$album_Table = Engine_Api::_() -> getDbtable('albums', 'advalbum');
		}
		else {
			$albumPhoto_Table = Engine_Api::_() -> getDbtable('photos', 'album');
			$album_Table = Engine_Api::_() -> getDbtable('albums', 'album');
		}

		$db = $albumPhoto_Table -> getAdapter();
		$db -> beginTransaction();

		try {
			$viewer = Engine_Api::_() -> user() -> getViewer();

			$photo = $albumPhoto_Table -> createRow();
			$photo -> setFromArray(array('owner_type' => 'user', 'owner_id' => $viewer -> getIdentity()));
			$photo -> save();
			Engine_Api::_() -> experience() -> setPhoto($photo, $_FILES['userfile']);

			$this -> view -> status = true;
			$this -> view -> name = $_FILES['userfile']['name'];
			$this -> view -> photo_id = $photo -> photo_id;
			$this -> view -> photo_url = $photo -> getPhotoUrl();

			$album = Engine_Api::_() -> experience() -> getSpecialAlbum($viewer, 'experience');

			$photo -> album_id = $album -> album_id;
			$photo -> save();

			if (!$album -> photo_id) {
				$album -> photo_id = $photo -> getIdentity();
				$album -> save();
			}

			$auth = Engine_Api::_() -> authorization() -> context;
			$auth -> setAllowed($photo, 'everyone', 'view', true);
			$auth -> setAllowed($photo, 'everyone', 'comment', true);
			$auth -> setAllowed($album, 'everyone', 'view', true);
			$auth -> setAllowed($album, 'everyone', 'comment', true);
			$db -> commit();

		} catch( Album_Model_Exception $e ) {
			$db -> rollBack();
			$this -> view -> status = false;
			$this -> view -> error = $this -> view -> translate($e -> getMessage());
			throw $e;
			return;

		} catch( Exception $e ) {
			$db -> rollBack();
			$this -> view -> status = false;
			$this -> view -> error = Zend_Registry::get('Zend_Translate') -> _('An error occurred.');
			throw $e;
			return;
		}
	}

	public function rssAction() {
		// Disable layout
		$this -> _helper -> layout -> disableLayout();

		$viewer = Engine_Api::_() -> user() -> getViewer();
		// Must be able to view experiences
		if (!Engine_Api::_() -> authorization() -> isAllowed('experience', $viewer, 'view')) {
			return;
		}
		$cat = $this -> _getParam('category');
		$experience_id = $this -> _getParam('rss_id');
		$owner_id = $this -> _getParam('owner');
		//
		$this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('experience_main');
		if ($cat && $experience_id <= 0) {
			// Get navigation
			$params = array();
			if ($cat > 0) {
				$params['category'] = $cat;
				if ($owner_id) {
					$params['user_id'] = $owner_id;
					//
				}
				$categories = Engine_Api::_() -> getItemTable('experience_category') -> getCategories();
				foreach ($categories as $category) {
					if ($category -> category_id == $cat) {
						$pro_type_name = $category -> category_name;
					}
				}
			} else
				$pro_type_name = "All Experiences";
		} else {
			$pro_type_name = 'Experience';
			$params['experienceRss'] = $experience_id;
		}
		$table = Engine_Api::_() -> getItemTable('experience');
		$experiences = $table -> fetchAll(Experience_Api_Core::getExperiencesSelect($params));
		$this -> view -> experiences = $experiences;
		$this -> view -> pro_type_name = str_replace('&', '-', $pro_type_name);
		$this -> getResponse() -> setHeader('Content-type', 'text/xml');
	}

}
