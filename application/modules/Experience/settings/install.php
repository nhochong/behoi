<?php
class Experience_Installer extends Engine_Package_Installer_Module {
	public function onEnable() {
		parent::onEnable();
		$db = $this->getDb();
		$db->query("UPDATE `engine4_core_modules` SET `enabled`=0 WHERE  `name`='experience';");

	}

	public function onDisable() {
		parent::onDisable();
		$db = $this->getDb();
		$db->query("UPDATE `engine4_core_modules` SET `enabled`=1 WHERE  `name`='experience';");
	}

	function onInstall() {

		parent::onInstall();

		$this -> _addExperienceProfile();
		$this -> _addExperienceBrowsePage();
		$this -> _addExperienceListingPage();
		$this -> _addExperienceListPage();
		$this -> _addExperienceViewPage();
		$this -> _addExperienceCreatePage();
		$this -> _addExperienceManagePage();
		$this -> _alterExperiencesTable();
		$this -> _mergeDataLinks();
		// Query for safe
		try
		{
			$db = $this -> getDb();
			$db -> query("ALTER TABLE `engine4_experience_experiences` ADD `become_count` INT( 11 ) NOT NULL DEFAULT '0' AFTER `comment_count`");
		}
		catch(Exception $e)
		{

		}
	}

	/**
	 * Merge data from table `engine4_experienceimporter_links` from old Experience Importer Blugin
	 */
	 protected function _mergeDataLinks() {
		if ($this->_hasModule('blogimporter'))
        {
            $db = $this -> getDb();
			$select = new Zend_Db_Select($db);
			$select -> from('engine4_experienceimporter_links');
			$rows = $select -> query()->fetchAll();
            if (count($rows) > 0)
            {
                foreach ($rows as $row)
                {
                    $db -> insert('engine4_experience_links',
                            array('user_id' => $row['user_id'],
                                'link_url' => $row['link_url'],
                                'last_run' => $row['last_run'],
                                'cronjob_enabled' => $row['cronjob_enabled'],
                                ));
                }
            }
        }
	}

	protected function _hasModule($name)
	{
		$db = $this-> getDb();
		$select = new Zend_Db_Select($db);
		$select->from('engine4_core_modules')->where('name = ?',$name);
		$row = $select ->query()->fetch();
		if($row)
		{
			return true;
		}
		return false;
	}
	protected function _alterExperiencesTable() {
		$db = $this -> getDb();
		try {
			$db -> query('ALTER TABLE `engine4_experience_experiences` ADD `pub_date` VARCHAR( 100 ) NULL AFTER `modified_date`;');
			$db -> query("ALTER TABLE `engine4_experience_experiences` ADD COLUMN `link_detail` varchar(300) default NULL AFTER `pub_date`;");
		} catch(Exception $e) {
		}
	}

	/*----- Experience Profile Widget -----*/
	protected function _addExperienceProfile() {
		$db = $this -> getDb();
		$select = new Zend_Db_Select($db);

		/*----- User Profile Page -----*/
		$select -> from('engine4_core_pages') -> where('name = ?', 'user_profile_index') -> limit(1);
		$page_id = $select -> query() -> fetchObject() -> page_id;

		//Check and remove SE profile experiences widget
		$select = new Zend_Db_Select($db);
		$select -> from('engine4_core_content') -> where('page_id = ?', $page_id) -> where('type = ?', 'widget') -> where('name = ?', 'experience.profile-experiences');
		$info = $select -> query() -> fetch();

		if (!empty($info)) {
			$db -> query("DELETE FROM `engine4_core_content` where `engine4_core_content`.`page_id` =" . $page_id . " and `engine4_core_content`.`name` = 'experience.profile-experiences'");
		}

		// Add profile experiences widget
		// Check if it's already been placed
		$select = new Zend_Db_Select($db);
		$select -> from('engine4_core_content') -> where('page_id = ?', $page_id) -> where('type = ?', 'widget') -> where('name = ?', 'experience.profile-experiences');
		$info = $select -> query() -> fetch();

		if (empty($info)) {
			// Get container_id (will always be there)
			$select = new Zend_Db_Select($db);
			$select -> from('engine4_core_content') -> where('page_id = ?', $page_id) -> where('type = ?', 'container') -> limit(1);
			$container_id = $select -> query() -> fetchObject() -> content_id;

			// Get middle_id (will always be there)
			$select = new Zend_Db_Select($db);
			$select -> from('engine4_core_content') -> where('parent_content_id = ?', $container_id) -> where('type = ?', 'container') -> where('name = ?', 'middle') -> limit(1);
			$middle_id = $select -> query() -> fetchObject() -> content_id;

			// Get tab_id (tab container) may not always be there
			$select -> reset('where') -> where('type = ?', 'widget') -> where('name = ?', 'core.container-tabs') -> where('page_id = ?', $page_id) -> limit(1);
			$tab_id = $select -> query() -> fetchObject();
			if ($tab_id && @$tab_id -> content_id) {
				$tab_id = $tab_id -> content_id;
			} else {
				$tab_id = null;
			}

			// Add profile experiences widget
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.profile-experiences', 'parent_content_id' => ($tab_id ? $tab_id : $middle_id), 'order' => 6, 'params' => '{"title":"Experiences","titleCount":true,"mode_grid":1,"mode_list":1,"view_mode":"list"}', ));
		}
	}

	/*------ Experience Browse Page -----*/
	protected function _addExperienceBrowsePage() {
		$db = $this -> getDb();
		$page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'experience_index_index') -> limit(1) -> query() -> fetchColumn();
		
		if($page_id)
		{
			// Check left column
			$select = new Zend_Db_Select($db);
			$select -> from('engine4_core_content') 
				-> where('page_id = ?', $page_id) 
				-> where('type = ?', 'container') 
				-> where('name = ?', 'left');
			$info = $select -> query() -> fetch();
			if(empty($info))
			{
				// Clear this page
				$db -> query("DELETE FROM `engine4_core_pages` where `engine4_core_pages`.`page_id` =" . $page_id);
				$page_id = 0;
			}
		}
		
		// Add page if it does not exist
		if (!$page_id) 
		{
			$db -> insert('engine4_core_pages', array('name' => 'experience_index_index', 'displayname' => 'Experience - Browse Page', 'title' => 'Experiences Browse Page', 'description' => 'This is Experiences Browse Page.', ));
			$page_id = $db -> lastInsertId('engine4_core_pages');

			// Add containers
			// Top container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'top', 'parent_content_id' => null, 'order' => 1, 'params' => '', ));
			$top_id = $db -> lastInsertId('engine4_core_content');

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'middle', 'parent_content_id' => $top_id, 'order' => 1, 'params' => '', ));
			$middle_id = $db -> lastInsertId('engine4_core_content');

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-menu', 'parent_content_id' => $middle_id, 'order' => 1, 'params' => '', ));

			// Main container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'main', 'parent_content_id' => null, 'order' => 2, 'params' => '', ));
			$container_id = $db -> lastInsertId('engine4_core_content');

			// Main-Right container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'right', 'parent_content_id' => $container_id, 'order' => 2, 'params' => '', ));
			$right_id = $db -> lastInsertId('engine4_core_content');
			
			// Main-Left container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'left', 'parent_content_id' => $container_id, 'order' => 1, 'params' => '', ));
			$left_id = $db -> lastInsertId('engine4_core_content');

			// Main-Middle containter
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'middle', 'parent_content_id' => $container_id, 'order' => 3, 'params' => '', ));
			$middle_id = $db -> lastInsertId('engine4_core_content');

			// Main-Middle Widgets

			// Featured Experiences
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.featured-experiences', 'parent_content_id' => $middle_id, 'order' => 1, 'params' => '{"title":"Featured Experiences"}', ));

			// New Experiences & Top Experiences Tab
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'core.container-tabs', 'parent_content_id' => $middle_id, 'order' => 2, 'params' => '{"max":"6","title":"","name":"core.container-tabs"}', ));
			$tab1_id = $db -> lastInsertId('engine4_core_content');

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.new-experiences', 'parent_content_id' => $tab1_id, 'order' => 3, 'params' => '{"title":"New Experiences","mode_grid":1,"mode_list":1,"view_mode":"list"}', ));

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.top-experiences', 'parent_content_id' => $tab1_id, 'order' => 4, 'params' => '{"title":"Top Experiences","mode_grid":1,"mode_list":1,"view_mode":"list"}', ));

			// Most Viewed Experiences & Most Commented Experiences Tab
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'core.container-tabs', 'parent_content_id' => $middle_id, 'order' => 5, 'params' => '{"max":"6"}', ));
			$tab2_id = $db -> lastInsertId('engine4_core_content');

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.most-viewed-experiences', 'parent_content_id' => $tab2_id, 'order' => 6, 'params' => '{"title":"Most Viewed Experiences","mode_grid":1,"mode_list":1,"view_mode":"list"}', ));

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.most-commented-experiences', 'parent_content_id' => $tab2_id, 'order' => 7, 'params' => '{"title":"Most Commented Experiences","mode_grid":1,"mode_list":1,"view_mode":"list"}', ));

			// Main-Left Widgets
			// Top Bloggers
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.top-bloggers', 'parent_content_id' => $left_id, 'order' => 1, 'params' => '{"title":"Top Bloggers"}', ));
			
			// Experience Categories
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experience-categories', 'parent_content_id' => $left_id, 'order' => 2, 'params' => '{"title":"Categories"}', ));

			//Experience Statistics
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-statistic', 'parent_content_id' => $left_id, 'order' => 3, 'params' => '{"title":"Statistic"}', ));
			
			// Main-Right Widgets
			
			// Experience Search
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-search', 'parent_content_id' => $right_id, 'order' => 1, 'params' => '{"title":"Experiences Search"}', ));

			// View By Date Experiences
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.view-by-date-experiences', 'parent_content_id' => $right_id, 'order' => 2, 'params' => '{"title":"View By Date"}', ));

			// Experience Tags
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-tags', 'parent_content_id' => $right_id, 'order' => 3, 'params' => '{"title":"Tags", "max":"20"}', ));
		}
	}

	/*------ Experience Browse Page -----*/
	protected function _addExperienceListingPage() {
		$db = $this -> getDb();
		$select = new Zend_Db_Select($db);
		$select -> from('engine4_core_pages') -> where('name = ?', 'experience_index_listing') -> limit(1);
		$info = $select -> query() -> fetch();

		// Add page if it does not exist
		if (empty($info)) {
			$db -> insert('engine4_core_pages', array('name' => 'experience_index_listing', 'displayname' => 'Experience - Listing Page', 'title' => 'Experience Listing page', 'description' => 'This is experience listing page.', ));
			$page_id = $db -> lastInsertId('engine4_core_pages');

			// containers

			// Top container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'top', 'parent_content_id' => null, 'order' => 1, 'params' => '', ));
			$top_id = $db -> lastInsertId('engine4_core_content');

			//Insert Main container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'main', 'parent_content_id' => null, 'order' => 2, 'params' => '', ));

			// Top menu
			$container_id = $db -> lastInsertId('engine4_core_content');
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'middle', 'parent_content_id' => $top_id, 'order' => 1, 'params' => '', ));
			$middle_id = $db -> lastInsertId('engine4_core_content');

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-menu', 'parent_content_id' => $middle_id, 'order' => 1, 'params' => '', ));

			// Main - Right container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'right', 'parent_content_id' => $container_id, 'order' => 1, 'params' => '', ));
			$right_id = $db -> lastInsertId('engine4_core_content');

			// Main - Middle container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'middle', 'parent_content_id' => $container_id, 'order' => 2, 'params' => '', ));
			$middle_id = $db -> lastInsertId('engine4_core_content');

			// Middle column
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-listing', 'parent_content_id' => $middle_id, 'order' => 1, 'params' => '{"mode_grid":1,"mode_list":1,"view_mode":"list"}', ));

			// Right column
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-search', 'parent_content_id' => $right_id, 'order' => 1, 'params' => '{"title":"Search Experiences"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experience-categories', 'parent_content_id' => $right_id, 'order' => 2, 'params' => '{"title":"Categories"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.view-by-date-experiences', 'parent_content_id' => $right_id, 'order' => 3, 'params' => '{"title":"View By Date"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-tags', 'parent_content_id' => $right_id, 'order' => 4, 'params' => '{"title":"Tags"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-statistic', 'parent_content_id' => $right_id, 'order' => 5, 'params' => '{"title":"Statistics"}', ));
		}
	}

	/*------ User Experience List Page -----*/
	protected function _addExperienceListPage() {
		$db = $this -> getDb();

		// profile page
		$page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'experience_index_list') -> limit(1) -> query() -> fetchColumn();

		// insert if it doesn't exist yet
		if (!$page_id) {
			// Insert page
			$db -> insert('engine4_core_pages', array('name' => 'experience_index_list', 'displayname' => 'Experience - List Page', 'title' => 'Experience List', 'description' => 'This page will lists a member\'s experience entries.', 'provides' => 'subject=user', ));
			$page_id = $db -> lastInsertId();

			//Insert top container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'top', 'parent_content_id' => null, 'order' => 1, 'params' => '', ));
			$top_id = $db -> lastInsertId();

			// Insert main container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'main', 'parent_content_id' => null, 'order' => 2, 'params' => '', ));
			$main_id = $db -> lastInsertId();

			// Top menu
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $top_id, 'order' => 1, ));
			$top_middle_id = $db -> lastInsertId();

			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.experiences-menu', 'page_id' => $page_id, 'parent_content_id' => $top_middle_id, 'order' => 1, ));

			/*--- Insert right container ---*/
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'right', 'page_id' => $page_id, 'parent_content_id' => $main_id, 'order' => 1, 'params' => '', ));
			$right_id = $db -> lastInsertId();

			/*--- Insert middle container ---*/
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $main_id, 'order' => 2, 'params' => '', ));
			$middle_id = $db -> lastInsertId();

			// Right column
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.owner-photo', 'page_id' => $page_id, 'parent_content_id' => $right_id, 'order' => 1, ));
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.experiences-side-menu', 'page_id' => $page_id, 'parent_content_id' => $right_id, 'order' => 2, ));

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-search', 'parent_content_id' => $right_id, 'order' => 3, 'params' => '{"title":"Search Experiences"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experience-categories', 'parent_content_id' => $right_id, 'order' => 4, 'params' => '{"title":"Categories"}', ));

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-tags', 'parent_content_id' => $right_id, 'order' => 5, 'params' => '{"title":"User\'s Tags"}', ));

			// Insert middle column
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-listing', 'parent_content_id' => $middle_id, 'order' => 1, 'params' => '{"mode_grid":1,"mode_list":1,"view_mode":"list"}', ));
		}
	}

	/*------ Specific Experience View Page -----*/
	protected function _addExperienceViewPage() {
		$db = $this -> getDb();

		// profile page
		$page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'experience_index_view') -> limit(1) -> query() -> fetchColumn();

		// insert if it doesn't exist yet
		if (!$page_id) 
		{
			// Insert page
			$db -> insert('engine4_core_pages', array('name' => 'experience_index_view', 'displayname' => 'Experience - View Page', 'title' => 'Experience View', 'description' => 'This page displays a experience entry.', 'provides' => 'subject=experience', ));
			$page_id = $db -> lastInsertId();

			//Insert top container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'top', 'parent_content_id' => null, 'order' => 1, 'params' => '', ));
			$top_id = $db -> lastInsertId();

			// Insert main container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'main', 'parent_content_id' => null, 'order' => 2, 'params' => '', ));
			$main_id = $db -> lastInsertId();

			// Top menu
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $top_id, 'order' => 1, 'params' => '', ));
			$top_middle_id = $db -> lastInsertId();

			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.experiences-menu', 'page_id' => $page_id, 'parent_content_id' => $top_middle_id, 'order' => 1, ));

			// Insert right
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'right', 'page_id' => $page_id, 'parent_content_id' => $main_id, 'order' => 1, 'params' => '', ));
			$right_id = $db -> lastInsertId();

			// Insert middle
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $main_id, 'order' => 2, ));
			$middle_id = $db -> lastInsertId();

			// Insert right column
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.owner-photo', 'page_id' => $page_id, 'parent_content_id' => $right_id, 'order' => 1, ));
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.experiences-side-menu', 'page_id' => $page_id, 'parent_content_id' => $right_id, 'order' => 2, ));

			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-search', 'parent_content_id' => $right_id, 'order' => 3, 'params' => '{"title":"Search Experiences"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experience-categories', 'parent_content_id' => $right_id, 'order' => 4, 'params' => '{"title":"Categories"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.experiences-tags', 'parent_content_id' => $right_id, 'order' => 5, 'params' => '{"title":"User\'s Tags"}', ));
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.detail-other-experiences', 'parent_content_id' => $right_id, 'order' => 6, 'params' => '{"title":"Other Experiences"}', ));

			// Insert middle column
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'core.content', 'page_id' => $page_id, 'parent_content_id' => $middle_id, 'order' => 1, ));
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.detail-related-experiences', 'page_id' => $page_id, 'parent_content_id' => $middle_id, 'order' => 2, 'params' => '{"title":"Related Experiences"}',));
			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'core.comments', 'page_id' => $page_id, 'parent_content_id' => $middle_id, 'order' => 3, ));
		}
		else
		{
			// Get Right + Middle
			$right_id = $db -> select() -> from('engine4_core_content', 'content_id') -> where('name = ?', 'right') -> where('type = ?', 'container') -> where('page_id = ?', $page_id) -> limit(1) -> query() -> fetchColumn();
			$main_id = $db -> select() -> from('engine4_core_content', 'content_id') -> where('name = ?', 'main') -> where('type = ?', 'container') -> where('page_id = ?', $page_id) -> limit(1) -> query() -> fetchColumn();
			$middle_id = $db -> select() -> from('engine4_core_content', 'content_id') -> where('name = ?', 'middle') -> where('type = ?', 'container') -> where('parent_content_id = ?', $main_id) -> where('page_id = ?', $page_id) -> limit(1) -> query() -> fetchColumn();
			if($right_id)
			{
				// check exists
				if(!$db -> select() -> from('engine4_core_content', 'content_id') -> where('name = ?', 'experience.detail-other-experiences') -> where('type = ?', 'widget') -> where('page_id = ?', $page_id) -> limit(1) -> query() -> fetchColumn())
					$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'widget', 'name' => 'experience.detail-other-experiences', 'parent_content_id' => $right_id, 'order' => 99, 'params' => '{"title":"Other Experiences"}', ));
			}
			if($middle_id)
			{
				// check exists
				if(!$db -> select() -> from('engine4_core_content', 'content_id') -> where('name = ?', 'experience.detail-related-experiences') -> where('type = ?', 'widget') -> where('page_id = ?', $page_id) -> limit(1) -> query() -> fetchColumn())
					$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.detail-related-experiences', 'page_id' => $page_id, 'parent_content_id' => $middle_id, 'order' => 99, 'params' => '{"title":"Related Experiences"}',));
			}
			
		}
	}

	/*------ Specific Experience Create Page -----*/
	protected function _addExperienceCreatePage() {
		$db = $this -> getDb();
		// profile page
		$page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'experience_index_create') -> limit(1) -> query() -> fetchColumn();

		// insert if it doesn't exist yet
		if (!$page_id) {
			// Insert page
			$db -> insert('engine4_core_pages', array('name' => 'experience_index_create', 'displayname' => 'Experience - Create Page', 'title' => 'Experience Create Page', 'description' => 'This page allows user to create a new experience.', 'provides' => 'subject=experience', ));
			$page_id = $db -> lastInsertId();

			//Insert top container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'top', 'parent_content_id' => null, 'order' => 1, 'params' => '', ));
			$top_id = $db -> lastInsertId();

			// Insert main container
			$db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'main', 'parent_content_id' => null, 'order' => 2, 'params' => '', ));
			$main_id = $db -> lastInsertId();

			// Top menu widget
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $top_id, 'order' => 1, 'params' => '', ));
			$top_middle_id = $db -> lastInsertId();

			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.experiences-menu', 'page_id' => $page_id, 'parent_content_id' => $top_middle_id, 'order' => 1, ));

			// Content widget
			$db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $main_id, 'order' => 1, 'params' => '', ));
			$content_middle_id = $db -> lastInsertId();

			$db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'core.content', 'page_id' => $page_id, 'parent_content_id' => $content_middle_id, 'order' => 1, ));

		}
	}

	/*------ Specific Experience Create Page -----*/
	protected function _addExperienceManagePage() {
	    $db = $this -> getDb();
	    // profile page
	    $page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'experience_index_manage') -> limit(1) -> query() -> fetchColumn();

	    // insert if it doesn't exist yet
	    if (!$page_id) {
	        // Insert page
	        $db -> insert('engine4_core_pages', array('name' => 'experience_index_manage', 'displayname' => 'Experience - Manage Page', 'title' => 'Experience Manage Page', 'description' => 'This page lists a user\'s experience entries.', 'provides' => 'subject=experience', ));
	        $page_id = $db -> lastInsertId();

	        //Insert top container
	        $db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'top', 'parent_content_id' => null, 'order' => 1, 'params' => '', ));
	        $top_id = $db -> lastInsertId();

	        // Insert main container
	        $db -> insert('engine4_core_content', array('page_id' => $page_id, 'type' => 'container', 'name' => 'main', 'parent_content_id' => null, 'order' => 2, 'params' => '', ));
	        $main_id = $db -> lastInsertId();

	        // Top menu widget
	        $db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $top_id, 'order' => 1, 'params' => '', ));
	        $top_middle_id = $db -> lastInsertId();

	        $db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'experience.experiences-menu', 'page_id' => $page_id, 'parent_content_id' => $top_middle_id, 'order' => 1, ));

	        // Content widget
	        $db -> insert('engine4_core_content', array('type' => 'container', 'name' => 'middle', 'page_id' => $page_id, 'parent_content_id' => $main_id, 'order' => 1, 'params' => '', ));
	        $content_middle_id = $db -> lastInsertId();

	        $db -> insert('engine4_core_content', array('type' => 'widget', 'name' => 'core.content', 'page_id' => $page_id, 'parent_content_id' => $content_middle_id, 'order' => 1, ));

	    }
	}

}
?>