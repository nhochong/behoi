<?php

class Experience_Widget_ExperiencesSearchController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        //Data preload
        $viewer = Engine_Api::_()->user()->getViewer();
        $params = array();

        //Get search form
        $this->view->form = $form = new Experience_Form_Search();

        //Get search action type
        if (Engine_Api::_()->core()->hasSubject('user')) {
            $user = Engine_Api::_()->core()->getSubject('user');
            $form->removeElement('show');
            $form->setAction($this->view->url(array(), 'default') . "experiences/" . $user->getIdentity());
        } else if (Engine_Api::_()->core()->hasSubject('experience')) {
            $experience = Engine_Api::_()->core()->getSubject('experience');
            $user = $experience->getOwner();
            $form->setAction($this->view->url(array(), 'default') . "experiences/" . $user->getIdentity());
            $form->removeElement('show');
        } else {
            $form->setAction($this->view->url(array(), 'default') . "experiences/listing");
        }

        $form->removeElement('mode');
        if (!$viewer->getIdentity()) {
            $form->removeElement('show');
        }
        $request = Zend_Controller_Front::getInstance()->getRequest();
        $params = $request->getParams();
        $form->populate($params);

    }
}