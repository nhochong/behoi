<?php

class Question_AdminManageController extends Question_controllers_AdminController {

    public function indexAction() {
        $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
                ->getNavigation('question_admin_main', array(), 'question_admin_main_manage');

        $this->view->form = $form = new Question_Form_Search();
        $form->removeElement('show');

        $form->isValid($this->getRequest()->getPost());
        $values = $form->getValues();
        $this->view->assign($values);

        $this->view->paginator = $paginator = Engine_Api::_()->question()->getQuestionPaginator($values);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->question_page;
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage($items_per_page);
    }

    public function deleteAction() {
        // In smoothbox
        $this->_helper->layout->setLayout('admin-simple');
        $this->view->delete_title = 'Delete Question?';
        $this->view->delete_description = 'Are you sure that you want to delete this question? It will not be recoverable after being deleted.';
        $id = $this->_getParam('id');
        $this->view->question_id = $id;
        // Check post
        if ($this->getRequest()->isPost()) {
            $db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();

            try {
                $question = Engine_Api::_()->getItem('question', $id);
                $question->delete();

                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }

            $this->_forward('success', 'utility', 'core', array(
                'smoothboxClose' => 10,
                'parentRefresh' => 10,
                'messages' => array('')
            ));
        }

        // Output
        $this->renderScript('etc/delete.tpl');
    }

    public function cancelAction() {
        // In smoothbox
        $this->_helper->layout->setLayout('admin-simple');
        $this->view->delete_title = 'Cancel Question?';
        $this->view->button = 'Ok';
        $this->view->delete_description = 'Are you sure that you want to cancel this question? It will not be recoverable after being canceled.';
        $id = $this->_getParam('id');
        $this->view->question_id = $id;
        // Check post
        if ($this->getRequest()->isPost()) {
            $db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();

            try {
                $question = Engine_Api::_()->getItem('question', $id);
                $question->status = 'canceled';
                $question->save();

                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }

            $this->_forward('success', 'utility', 'core', array(
                'smoothboxClose' => 10,
                'parentRefresh' => 10,
                'messages' => array('')
            ));
        }

        // Output
        $this->renderScript('etc/delete.tpl');
    }

}