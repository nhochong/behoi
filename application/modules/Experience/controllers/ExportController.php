<?php
class Experience_ExportController extends Core_Controller_Action_Standard
{
    public function indexAction()
    {
        // Checking authorization
        if (! $this->_helper->requireUser ()->isValid ())
            return;
        // Get navigation
        $check_experience = Engine_Api::_ ()->experience()->getExperienceModule ();
        if (! $check_experience) {
            $this->view->navigation = $navigation = Engine_Api::_ ()->getApi ( 'menus', 'core' )->getNavigation ( 'experience_main' );
        } else {
            $this->view->navigation = $navigation = Engine_Api::_ ()->getApi ( 'menus', 'core' )->getNavigation ( 'experience_main' );
        }
        $viewer = Engine_Api::_()->user()->getViewer();
        $params = $this->getAllParams();
        $params['user_id'] = $viewer -> getIdentity();
        // Get Experience Paginator
        $this->view->paginator = Engine_Api::_()->experience()->getExperiencesPaginator($params);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.page',10);
        $this->view->paginator->setItemCountPerPage($items_per_page);
        if(isset($params['page'])) $this->view->paginator->setCurrentPageNumber($params['page']);
    }
    public function exportAction()
    {
        $this -> _helper -> layout -> disableLayout();
        $this -> _helper -> viewRenderer -> setNoRender(true);
        $exportTo = $this->_getParam('exportTo', null);
        $ids = $this->_getParam('ids', null);
        $ids_array = explode(",", $ids);
        array_shift($ids_array);
        if(count($ids_array)>0)
        {
            $content = $this->getContent($ids_array, $exportTo);
            $this->exportXML($content, $exportTo);
        }
    }

    public function getContent($ids_array = array(),$exportTo)
    {
        $experiences = array();
        foreach( $ids_array as $id ){
            $experiences[] = Engine_Api::_()->getItem('experience', $id);
        }
        $view = Zend_Registry::get("Zend_View");
        $view->experiences = $experiences;
        if ($exportTo == "tumblr")
        {
            $content = $view -> render('_tumblr.tpl');
        }
        else if ($exportTo == "blogger")
        {
            $content = $view -> render('_blogger.tpl');
        }
        else if ($exportTo = "wordpress")
        {
            $content = $view -> render('_wordpress.tpl');
        }

        return $content;
    }
    public function exportXML($content,$exportTo)
    {
        $filename = "";
        if($exportTo == 'wordpress')
        {
            $filename = 'wordpress.' . date('Y-m-d', time()) . '.xml';
        }
        else if($exportTo == 'blogger')
        {
            $filename = 'blogger.' . date('Y-m-d', time()) . '.xml';
        }
        else if($exportTo == 'tumblr')
        {
            $filename = 'tumblr.' . date('Y-m-d', time()) . '.xml';
        }
            header("Content-Disposition: attachment; filename=" . urlencode(basename($filename)), true);
            header("Content-Transfer-Encoding: Binary", true);
            header("Content-Type: application/force-download", true);
            header("Content-Type: application/octet-stream", true);
            header("Content-Type: application/download", true);
            header("Content-Description: File Transfer", true);
            header("Content-Length: " .strlen($content), true);
            echo $content;

        }
}