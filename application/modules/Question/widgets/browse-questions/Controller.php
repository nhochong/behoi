<?php

class Question_Widget_BrowseQuestionsController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->form = $form = Question_Form_Search::getInstance();
        $this->view->can_create = Engine_Api::_()->question()->can_create_question();
        $this->view->categories = $categories = Engine_Api::_()->question()->getCategories();
        $values = array();
		
		$params = Zend_Controller_Front::getInstance()->getRequest()->getParams();

        if ($form->isValid($params)) {
            // Process form
            $this->view->formValues = $values = $form->getValues();

            // Do the show thingy
            if (@$values['show'] == 2) {

                $table = Engine_Api::_()->getItemTable('user');
                $select = $viewer->membership()->getMembersSelect('user_id');
                $friends = $table->fetchAll($select);
                // Get stuff
                $ids = array();
                foreach ($friends as $friend) {
                    $ids[] = $friend->user_id;
                }
                //unset($values['show']);
                $values['users'] = $ids;
                $values['anonymous'] = 0;
            } elseif (@$values['show'] == 3) {
                $values['anonymous'] = 1;
            }
        }
        if ($user_q_id = ($params['user_id'] ? $params['user_id'] : null)) {
            $values['user_id'] = $user_q_id;
            $owner = Engine_Api::_()->getItem('user', $user_q_id);
            Engine_Api::_()->core()->setSubject($owner);
            if (!$owner->isOwner($viewer)) {
                $values['anonymous'] = 0;
            }
        }
        if ($params['category']) {
            $category = $categories->getRowMatching('url', $params['category']);
            if (!empty($category)) {
                $values['category'] = $category->getIdentity();
                $form->populate(array('category' => $category->url));
            }
        }
        $this->view->assign($values);
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getQuestionPaginator($values);
        $paginator->setCurrentPageNumber($params['page']);
        $paginator->setItemCountPerPage(Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 20));
        $this->view->moderation = Zend_Controller_Action_HelperBroker::getStaticHelper('RequireAuth')->setAuthParams('question', null, 'moderation')->setNoForward()->isValid();
    }
}
