<?php
class Experience_AdminManageController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    // Get navigation bar
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_admin_main', array(), 'experience_admin_main_manage');

    $this->view->form = $form = new Experience_Form_Admin_Search;
    $form->isValid($this->_getAllParams());
    $params = $form->getValues();
    if(empty($params['orderby'])) $params['orderby'] = 'experience_id';
    if(empty($params['direction'])) $params['direction'] = 'DESC';
    $this->view->formValues = $params;

    //  Filter type of search
    switch ($params['filter']){
      case '0': $params['featured']    = 1;
               break;
      case '1': $params['featured']    = 0;
               break;
      case '2': $params['is_approved'] = 1;
               break;
      case '3': $params['is_approved'] = 0;
               break;
    }
    $this->view->moderation = Engine_Api::_()->getApi('settings','core')->getSetting('experience.moderation',0);

    // Get Experience Paginator
    $this->view->paginator = Engine_Api::_()->experience()->getExperiencesPaginator($params);
    
    $items_per_page = Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.page',10);
    $this->view->paginator->setItemCountPerPage($items_per_page);
    if(isset($params['page'])) $this->view->paginator->setCurrentPageNumber($params['page']);
  }

  /*----- Delete Experience Function-----*/
  public function deleteAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->experience_id=$id;
    
    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      //Process delete action
      try
      {
        $experience = Engine_Api::_()->getItem('experience', $id);
        // delete the experience entry into the database
        $experience->delete();
        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      // Refresh parent page
      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-manage/delete.tpl');
  }

  /*----- Delete Selected Experiences Function -----*/
  public function deleteSelectedAction()
  {
    $this->view->ids = $ids = $this->_getParam('ids', null);
    $confirm = $this->_getParam('confirm', false);
    $this->view->count = count(explode(",", $ids));
      
    // Check post
    if( $this->getRequest()->isPost() && $confirm == true )
    {
      //Process delete
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();
      try{
          $ids_array = explode(",", $ids);
          foreach( $ids_array as $id ){
            $experience = Engine_Api::_()->getItem('experience', $id);
            if( $experience ) $experience->delete();
          }
          $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

     $this->_helper->redirector->gotoRoute(array('action' => 'index'));
      }
  }

  /*----- Set Featured Experience Function -----*/
  public function featureAction()
  {
      //Get params
      $experience_id = $this->_getParam('experience_id'); 
      $featured = $this->_getParam('good');

      //Get experience need to set featured
      $table = Engine_Api::_()->getItemTable('experience');
      $select = $table->select()->where("experience_id = ?",$experience_id); 
      $experience = $table->fetchRow($select);

      //Set featured/unfeatured
      if($experience){
      $experience->is_featured =  $featured;
      $experience->save();
      }
  }

  /*----- Set Approve Experience Function -----*/
  public function approveAction(){
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->experience_id=$id;

    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

    // Change the experience approved field in the database
      try
      {
        $experience = Engine_Api::_()->getItem('experience', $id);

        //Check if got object
        if($experience){
              $experience->is_approved = 1;

              //Add activity if the experience is approved at the first time
              if(!$experience->add_activity && !$experience->draft){
                     $owner = $experience->getParent();
                     $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($owner, $experience, 'experience_new');

                     // Make sure action exists before attaching the experience to the activity
                     if( $action ) {
                          Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($action, $experience);
                        }

                      // Send notifications for subscribers
                      Engine_Api::_()->getDbtable('subscriptions', 'experience')
                          ->sendNotifications($experience);

                      $experience->add_activity = 1;
              }
              $experience->save();
              $db->commit();
        }
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

    $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 10,
        'parentRefresh'=> 10,
        'messages' => array('')
    ));
   }
 }

   /*----- Set Unapprove Experience Function -----*/
  public function unapproveAction(){
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->experience_id=$id;

    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

    // Change the experience approved field in the database
      try{
          $experience = Engine_Api::_()->getItem('experience', $id);
          if($experience){
            $experience->is_approved = 0;
            $experience->save();
            $db->commit();
          }
      }
      catch( Exception $e ){
            $db->rollBack();
            throw $e;
      }

    $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 10,
        'parentRefresh'=> 10,
        'messages' => array('')
    ));
   }
 }

   /*----- Aprrove Selected Experiences Function -----*/
  public function approveSelectedAction()
  {
    $this->view->ids = $ids = $this->_getParam('ids', null);
    $confirm = $this->_getParam('confirm', false);
    $this->view->count = count(explode(",", $ids));

    // Save values
    if( $this->getRequest()->isPost() && $confirm == true )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try{
          $ids_array = explode(",", $ids);
          foreach( $ids_array as $id ){
                $experience = Engine_Api::_()->getItem('experience', $id);
                if( $experience ) {
                      $experience->is_approved = 1;

                      //Add activity if the experience is approved at the first time
                      if(!$experience->add_activity && !$experience->draft){
                         $owner = $experience->getParent();
                         $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($owner, $experience, 'experience_new');

                      // Make sure action exists before attaching the experience to the activity
                      if( $action ) {
                         Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($action, $experience);
                      }

                      // Send notifications for subscribers
                      Engine_Api::_()->getDbtable('subscriptions', 'experience')->sendNotifications($experience);

                      $experience->add_activity = 1;
                      }
                $experience->save();
                }
          }
      $db->commit();
      }
      catch( Exception $e ){
        $db->rollBack();
        throw $e;
      }

      // Redirect to admin manage index page

      $this->_helper->redirector->gotoRoute(array('action' => 'index'));
    }
  }

   /*----- Unapprove Selected Experiences Function -----*/
  public function unapproveSelectedAction()
  {
    $this->view->ids = $ids = $this->_getParam('ids', null);
    $confirm = $this->_getParam('confirm', false);
    $this->view->count = count(explode(",", $ids));

    // Save values
    if( $this->getRequest()->isPost() && $confirm == true )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try{
          $ids_array = explode(",", $ids);
          foreach( $ids_array as $id ){
                $experience = Engine_Api::_()->getItem('experience', $id);
                if( $experience ) {
                  $experience->is_approved = 0;
                  $experience->save();
                }
          }
      $db->commit();
      }
      catch( Exception $e ){
        $db->rollBack();
        throw $e;
      }
      //Redirect to admin manage index page
      $this->_helper->redirector->gotoRoute(array('action' => 'index'));
    }
  }
  
  /*--- Manage URLs ---*/
  public function urlsAction()
  {
      // Get navigation bar
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('experience_admin_main', array(), 'experience_admin_main_manageurl');

    $this->view->form = $form = new Experience_Form_Admin_SearchURL;
    $form->isValid($this->_getAllParams());
    $params = $form->getValues();
    if(empty($params['orderby'])) $params['orderby'] = 'link_id';
    if(empty($params['direction'])) $params['direction'] = 'DESC';
    $this->view->formValues = $params;

    // Get Link Paginator
    $this->view->paginator = Engine_Api::_ ()->getDbTable ( 'links', 'experience' ) -> getLinksPaginator($params);
    if(isset($params['page'])) $this->view->paginator->setCurrentPageNumber($params['page']);
  }
    /*----- Delete Link Function-----*/
  public function deleteLinkAction()
  {
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->link_id=$id;
    
    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();
      //Process delete action
      try
      {
        $link = Engine_Api::_ ()->experience()-> getLink($id);
        // delete the link into the database
        $link->delete();
        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      // Refresh parent page
      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => 10,
          'parentRefresh'=> 10,
          'messages' => array('')
      ));
    }

    // Output
    $this->renderScript('admin-manage/delete-link.tpl');
  }

  /*----- Delete Selected Links Function -----*/
  public function deleteLinkSelectedAction()
  {
    $this->view->ids = $ids = $this->_getParam('ids', null);
    $confirm = $this->_getParam('confirm', false);
    $this->view->count = count(explode(",", $ids));
      
    // Check post
    if( $this->getRequest()->isPost() && $confirm == true )
    {
      //Process delete
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();
      try{
          $ids_array = explode(",", $ids);
          foreach( $ids_array as $id ){
            $link = Engine_Api::_ ()->experience()-> getLink($id);
            if( $link ) $link->delete();
          }
          $db->commit();
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

     $this->_helper->redirector->gotoRoute(array('action' => 'urls'));
      }
  }

  /*----- Set enable link Function -----*/
  public function enableCronAction(){
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->link_id = $id;

    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

    // Change the link enable field in the database
      try
      {
        $link = Engine_Api::_ ()->experience()-> getLink($id);
        //Check if got object
        if($link)
        {
              $link -> cronjob_enabled = 1;
              $link->save();
              $db->commit();
        }
      }
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

    $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 10,
        'parentRefresh'=> 10,
        'messages' => array('')
    ));
   }
 }

   /*----- Set Disable Link Function -----*/
  public function disableCronAction(){
    // In smoothbox
    $this->_helper->layout->setLayout('admin-simple');
    $id = $this->_getParam('id');
    $this->view->link_id=$id;

    // Check post
    if( $this->getRequest()->isPost() )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try{
          $link = Engine_Api::_ ()->experience()-> getLink($id);
          if($link){
            $link->cronjob_enabled = 0;
            $link -> save();
            $db->commit();
          }
      }
      catch( Exception $e ){
            $db->rollBack();
            throw $e;
      }

    $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => 10,
        'parentRefresh'=> 10,
        'messages' => array('')
    ));
   }
 }

   /*----- Enable Selected Links Function -----*/
  public function enableLinkSelectedAction()
  {
    $this->view->ids = $ids = $this->_getParam('ids', null);
    $confirm = $this->_getParam('confirm', false);
    $this->view->count = count(explode(",", $ids));

    // Save values
    if( $this->getRequest()->isPost() && $confirm == true )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try{
          $ids_array = explode(",", $ids);
          foreach( $ids_array as $id ){
                $link = Engine_Api::_ ()->experience()-> getLink($id);
                if( $link ) 
                {
                    $link->cronjob_enabled = 1;
                    $link->save();
                }
          }
      $db->commit();
      }
      catch( Exception $e ){
        $db->rollBack();
        throw $e;
      }

      $this->_helper->redirector->gotoRoute(array('action' => 'urls'));
    }
  }

   /*----- Disable Selected Links Function -----*/
  public function disableLinkSelectedAction()
  {
    $this->view->ids = $ids = $this->_getParam('ids', null);
    $confirm = $this->_getParam('confirm', false);
    $this->view->count = count(explode(",", $ids));

    // Save values
    if( $this->getRequest()->isPost() && $confirm == true )
    {
      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try{
          $ids_array = explode(",", $ids);
          foreach( $ids_array as $id )
          {
                $link = Engine_Api::_ ()->experience()-> getLink($id);
                if( $link ) 
                {
                    $link->cronjob_enabled = 0;
                    $link->save();
                }
          }
      $db->commit();
      }
      catch( Exception $e ){
        $db->rollBack();
        throw $e;
      }
      $this->_helper->redirector->gotoRoute(array('action' => 'urls'));
    }
  }
	
	public function updatePrivacyAction(){
		$experiences = Engine_Api::_()->getItemTable('experience')->fetchAll();
		foreach($experiences as $experience){
			// Authorization set up
			$auth = Engine_Api::_() -> authorization() -> context;
			$roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'everyone');

			$values = array();
			$values['auth_view'] = 'everyone';
			$values['auth_comment'] = 'everyone';

			$viewMax = array_search($values['auth_view'], $roles);
			$commentMax = array_search($values['auth_comment'], $roles);

			foreach ($roles as $i => $role) {
				$auth -> setAllowed($experience, $role, 'view', ($i <= $viewMax));
				$auth -> setAllowed($experience, $role, 'comment', ($i <= $commentMax));
			}
			
		}
		die('Finished');
	}
}