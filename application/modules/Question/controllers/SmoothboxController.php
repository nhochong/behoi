<?php

class Question_SmoothboxController extends Core_Controller_Action_Standard {

    public function  init() {
        parent::init();
        $this->_helper->layout->setLayout('default-simple');
    }

    public function whoVotedAction() {
        $item_id = $this->_getParam('id');
        $vote_type = $this->_getParam('vote_type');
        $this->view->type = $itemtype = $this->_getParam('type');
        $this->view->item = $item = Engine_Api::_()->getItem($itemtype, $item_id);
        $type_table = ($itemtype == 'answer') ? 'votes' : 'qvotes' ;
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getVotePaginator(array('type' => $type_table,
                                                                                                  'vote_type' => $vote_type,
                                                                                                  'id' => $item_id));
        $paginator->setCurrentPageNumber( $this->_getParam('page'));
        $paginator->setItemCountPerPage(10);
        $navigation = $this->view->navigation = new Zend_Navigation();
        $navigation->addPage(array('label' =>  Zend_Registry::get('Zend_Translate')->_('Likes'),
                                   'route' => 'who_voted',
                                   'active' => ($vote_type == 'vote_for'),
                                   'params' => array('id' => $item_id,
                                                     'type' => $itemtype,
                                                     'vote_type' => 'vote_for')
                                  )
                           );
        $navigation->addPage(array('label' =>  Zend_Registry::get('Zend_Translate')->_('Dislikes'),
                                   'route' => 'who_voted',
                                   'active' => ($vote_type == 'vote_against'),
                                   'params' => array('id' => $item_id,
                                                     'type' => $itemtype,
                                                     'vote_type' => 'vote_against')
                                   )
                            );

    }

    public function deleteqAction() {
        // In smoothbox
        $this->view->delete_title = 'Delete Question?';
        $this->view->delete_description = 'Are you sure that you want to delete this question? It will not be recoverable after being deleted.';
        $id = (int)$this->_getParam('id');
        $this->view->question_id=$id;
        // Check post
        if( $this->getRequest()->isPost())
        {
          $db = Engine_Db_Table::getDefaultAdapter();
          $db->beginTransaction();
          $question = Engine_Api::_()->getItem('question', $id);
          if ($question == null) {
              return $this->_forward('requiresubject', 'error', 'core');
          }
          try
          {            
            if (!$question->User_can($this->view->viewer(), 'del'))
                throw new Engine_Exception('You can\'t to delete this question.');
            $question->delete();

            $db->commit();
          }

          catch( Exception $e )
          {
            $db->rollBack();
            throw $e;
          }

          $this->_forward('success', 'utility', 'core', array(
              'smoothboxClose' => true,
              'parentRedirect'=> $this->view->url(array('action' => 'index', 'controller' => 'index', 'module' => 'question'), 'default', true),
              'messages' => array(Zend_Registry::get('Zend_Translate')->_("Question was successfully deleted."))
          ));
        }
        else {
            // Output
            $this->renderScript('etc/delete.tpl');
        }
   }

   public function deleteAction() {
        // In smoothbox
        $this->view->delete_title = 'Delete Answer?';
        $this->view->delete_description = 'Are you sure want to delete this answer? It will not be recoverable after being deleted.';
        $id = $this->_getParam('id');
        $this->view->answer_id=$id;
        // Check post
        if( $this->getRequest()->isPost()) {
          $answer = Engine_Api::_()->getItem('answer', $id);
          $question = Engine_Api::_()->getItem('question', $answer->question_id);
          if( !Engine_Api::_()->core()->hasSubject('question') and $question instanceof Core_Model_Item_Abstract) {
              Engine_Api::_()->core()->setSubject($question);
          }
          if (!Engine_Api::_()->question()->can_delete_answer($answer)) {
              $this->view->error = 'You do not have rights to delete this answer.';
              $this->renderScript('etc/error.tpl');
              return;
          }
          $db = Engine_Db_Table::getDefaultAdapter();
          $db->beginTransaction();

          try
          {

            $answer->delete();
            $db->commit();
            Engine_Api::_()->getApi('settings', 'core')->setSetting('need_qarating_update', 1);
          }

          catch( Exception $e )
          {
            $db->rollBack();
            throw $e;
          }

          return $this->_forward('success', 'utility', 'core', array('smoothboxClose' => true,
                                                                     'parentRefresh'=> true,
                                                                     'messages' => array(Zend_Registry::get('Zend_Translate')->_("Answer was successfully deleted."))
                                                                    ));
        }

        // Output
        $this->renderScript('etc/delete.tpl');
  }

  public function reopenAction() {
    if( !$this->_helper->requireUser()->isValid() ) return;

    // In smoothbox
    $this->view->delete_title = 'Reopen Question?';
    $this->view->button = 'Ok';
    $this->view->delete_description = "Are you sure that you want to reopen this question?";
    $id = $this->_getParam('id');
    $this->view->question_id=$id;
    // Check post
    if( $this->getRequest()->isPost())
    {

      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        $question = Engine_Api::_()->getItem('question', $id);
        if (!$question->User_can($this->view->viewer(), 'reopen'))
            throw new Engine_Exception('You can\'t to reopen this question.');
        $question->status = 'open';
        $question->best_answer_id = NULL;
        $question->save();

        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh'=> true,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_("Question was successfully reopened."))
      ));
    }
    else {
        // Output
        $this->renderScript('etc/delete.tpl');
    }
  }

  public function cancelAction() {
    if( !$this->_helper->requireUser()->isValid() ) return;

    if( !Engine_Api::_()->question()->can_create_question()) $this->_helper->requireAuth->forward();
    // In smoothbox
    $this->view->delete_title = 'Cancel Question?';
    $this->view->button = 'Ok';
    $this->view->delete_description = "Are you sure that you want to cancel this question?";
    $id = $this->_getParam('id');
    $this->view->question_id=$id;
    // Check post
    if( $this->getRequest()->isPost())
    {

      $db = Engine_Db_Table::getDefaultAdapter();
      $db->beginTransaction();

      try
      {
        $question = Engine_Api::_()->getItem('question', $id);
        if (!$question->User_can($this->view->viewer(), 'cancel'))
            throw new Engine_Exception('You can\'t to cancel this question.');
        $question->status = 'canceled';
        $question->save();

        $db->commit();
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

      $this->_forward('success', 'utility', 'core', array(
          'smoothboxClose' => true,
          'parentRefresh'=> true,
          'messages' => array(Zend_Registry::get('Zend_Translate')->_("Question was successfully canceled."))
      ));
    }
    else {
        // Output
        $this->renderScript('etc/delete.tpl');
    }
  }

  public function editAnswerAction() {
      if( !$this->_helper->requireUser()->isValid() ) return;
      if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->isValid()) return;
      $id = (int)$this->_getParam('id');
      if (empty ($id)) {
          return $this->_forward('requiresubject', 'error', 'core');
      }
      $answer = Engine_Api::_()->getItem('answer', $id);
      if ($answer == null) {
          return $this->_forward('requiresubject', 'error', 'core');
      }

      $this->view->form = $form = new Question_Form_CreateAnswer();
      $this->view->form->populate($answer->toArray())
                       ->add_cancel()
                       ->setTitle('')
                       ->setDescription('');
      if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
          $values = $form->getValues();

          $answer->setFromArray($values);
          $answer->save();
          $this->_forward('success', 'utility', 'core', array(
                                                              'smoothboxClose' => true,
                                                              'parentRefresh'=> true,
                                                              'messages' => array(Zend_Registry::get('Zend_Translate')->_("Answer was successfully edited."))
                                                          ));
    }
  }

}
