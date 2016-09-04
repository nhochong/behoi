<?php

Engine_Loader::autoload('application_modules_Question_controllers_IndexController');

class Question_WallController extends Question_IndexController {

    public function init() {
        $this->_helper->layout->disableLayout(true);
        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'create')->checkRequire() or !Engine_Api::_()->question()->is_valid_rating_setting('question_min_points_ask')) {
            $this->view->error = 'You can not create a question.';
            $this->renderScript('etc/error.tpl');
        }
    }

    public function getformAction() {
        $this->view->form = $form = new Question_Form_Create();
        $form->setTitle('')
                ->setDescription('')
                ->removeElement('file');
        if (Engine_Api::_()->core()->hasSubject()) {
            $form->removeElement('category_id');
            $form->removeElement('auth_answer');
            $form->removeElement('auth_view');
        }
        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
            $question = $this->_addQuestion($form);
            $ownerUser = $question->getOwnerUser();
            if (Engine_Api::_()->core()->hasSubject()) {
                $subject = Engine_Api::_()->core()->getSubject();
                if (!($subject instanceof Question_Model_Question)) {
                    $question->resource_type = $subject->getType();
                    $question->resource_id = $subject->getIdentity();
                    $question->save();
                    $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($ownerUser, $subject, 'ge_question_new');
                }
            } else {
                $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($ownerUser, $question, 'question_new');
            }
            if ($action != null) {
                Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($action, $question);
            }

            $this->renderScript('wall/_success.tpl');
        }
    }

}

?>
