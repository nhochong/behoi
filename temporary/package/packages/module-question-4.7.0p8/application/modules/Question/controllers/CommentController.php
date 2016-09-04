<?php

class Question_CommentController extends Core_Controller_Action_Standard
{
  private $_current_answer;

  public function init() {
    $viewer = Engine_Api::_()->user()->getViewer();
    $type = 'answer';
    $identity = $this->_getParam('id');
    if( $type && $identity ) {
      $item = Engine_Api::_()->getItem($type, $identity);
      if( $item instanceof Core_Model_Item_Abstract && method_exists($item, 'comments') ) {
        $this->_current_answer = $item;
      }
    }

  }

  public function listAction() {

       $this->view->render_params = array('action' => 'list',
                                          'type' => 'answer',
                                          'id' => $this->_current_answer->getIdentity(),
                                          'page' => $this->_getParam('page', 1));
       $this->_helper->contextSwitch->initContext();
       if ($this->_getParam('moderation', false)) {
           $this->view->render_params['scriptPath'] = 'moderation/_comment_list.tpl';
           $this->view->render_params['ItemCountPerPage'] = 10000000000;
       }
  }
  
  public function createAction()
  {
    if( !$this->_helper->requireUser()->isValid() ) {
      return;
    }
       
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = $this->_current_answer;

    $this->view->form = $form = new Core_Form_Comment_Create();

    if( !$this->getRequest()->isPost() )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invalid request method");;
      return;
    }

    if( !$form->isValid($this->_getAllParams()) )
    {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invalid data");
      return;
    }

    // Process
    $db = $subject->comments()->getCommentTable()->getAdapter();
    $db->beginTransaction();

    try
    {
      // Filter HTML
      $filter = new Zend_Filter();
      $filter->addFilter(new Engine_Filter_Censor());
      $filter->addFilter(new Engine_Filter_HtmlSpecialChars());
      $body = $form->getValue('body');
      $body = $filter->filter($body);
      $comment = $subject->comments()->addComment($viewer, $body);

      $activityApi = Engine_Api::_()->getDbtable('actions', 'activity');
      $notifyApi = Engine_Api::_()->getDbtable('notifications', 'activity');
      $subjectOwner = $subject->getOwner('user');
      $comment_link = str_replace('#' . $subject->getIdentity(), '', $comment->getHref());
      // Activity
      $action = $activityApi->addActivity($viewer, $subject, 'comment_' . $subject->getType(), '', array(
        'owner' => $subjectOwner->getGuid(),
        'body' => '<a href="' . $comment_link . '">' . $body . '</a>'
      ));
      // Increment comment count
      Engine_Api::_()->getDbtable('statistics', 'core')->increment('core.comments');

      $db->commit();
    }

    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }
    $question = $subject->getQuestion();
    if (!$question->isSubscriber($viewer)) {
        $question->subscribertoggle($viewer);
    }
    $notifyApi = Engine_Api::_()->getDbtable('notifications', 'activity');
    $questionowner = $question->getOwner('user');
    $subscribers = $question->get_subscribers();
    foreach ($subscribers as $subscriber) {
        if( $viewer->isSelf($subscriber) )
            continue;
        $notifyApi->addNotification($subscriber, $viewer, $question, 'answer_new_comment', array('unsubscribe_link' => $this->view->url(array('module' => 'question',
                                                                                                                                              'controller' => 'index',
                                                                                                                                              'action' => 'unsubscribe',
                                                                                                                                              'unsubhash' => $subscriber->hash), 'default', true),
                                                                                                 'comment_link' => $comment_link,
                                                                                                 'comment_body' => $body ));
    }
    $this->view->subject = $subject;
    $this->view->status = true;
    $this->view->message = 'Comment added';
    $this->view->body = $this->view->RenderSimpleWidget('question.answer-comment', array('action' => 'list','type' => $this->_getParam('type'),
                                                                                         'id' => $this->_getParam('id'),
                                                                                         'format' => 'html',
                                                                                         'page' => 1));
    $this->_helper->contextSwitch->initContext();
  }

  public function deleteAction()
  {
    if( !$this->_helper->requireUser()->isValid() ) return;
    
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = $this->_current_answer;

    // Comment id
    $comment_id = $this->_getParam('comment_id');
    if( !$comment_id ) {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('No comment');
      return;
    }

    // Comment
    $comment = $subject->comments()->getComment($comment_id);
    if( !$comment ) {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('No comment or wrong parent');
      return;
    }

    // Authorization
    if( !$subject->authorization()->isAllowed($viewer, 'edit') &&
        ($comment->poster_type != $viewer->getType() ||
        $comment->poster_id != $viewer->getIdentity()) && !$this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->isValid() ) {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Not allowed');
      return;
    }

    // Method
    if( !$this->getRequest()->isPost() ) {
      $this->view->status = false;
      $this->view->error = Zend_Registry::get('Zend_Translate')->_('Invalid request method');
      return;
    }
    
    // Process
    $db = $subject->comments()->getCommentTable()->getAdapter();
    $db->beginTransaction();

    try
    {
      $subject->comments()->removeComment($comment_id);

      $db->commit();
    }

    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }
    $this->view->subject = $subject;
    $this->view->status = true;
    $this->view->message = Zend_Registry::get('Zend_Translate')->_('Comment deleted');
  }

}