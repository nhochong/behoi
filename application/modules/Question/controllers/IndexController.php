<?php

class Question_IndexController extends Core_Controller_Action_Standard {

    public function init() {
        parent::init();
        // Render
        $this->_helper->content->setEnabled();
        $this->view->isEnabledCategories = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1);
    }

    public function indexAction() {

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'view')->isValid())
            return;
        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->form = $form = Question_Form_Search::getInstance();
        $this->view->can_create = Engine_Api::_()->question()->can_create_question();
        $this->view->categories = $categories = Engine_Api::_()->question()->getCategories();
        $values = array();

        if ($form->isValid($this->_getAllParams())) {
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
        if ($user_q_id = $this->_getParam('user_id', false)) {
            $values['user_id'] = $user_q_id;
            $owner = Engine_Api::_()->getItem('user', $user_q_id);
            Engine_Api::_()->core()->setSubject($owner);
            if (!$owner->isOwner($viewer)) {
                $values['anonymous'] = 0;
            }
        }
        if ($this->_hasParam('category')) {
            $category = $categories->getRowMatching('url', $this->_getParam('category'));
            if (!empty($category)) {
                $values['category'] = $category->getIdentity();
                $form->populate(array('category' => $category->url));
            }
        }
        $this->view->assign($values);
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getQuestionPaginator($values);
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage(Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 20));
        $this->view->moderation = $this->_helper->requireAuth()->setAuthParams('question', null, 'moderation')->setNoForward()->isValid();
    }

    public function unansweredAction() {

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'view')->isValid())
            return;
        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->form = $form = Question_Form_Search::getInstance();
        $form->status->setValue('open');
        $this->view->can_create = Engine_Api::_()->question()->can_create_question();
        $this->view->categories = Engine_Api::_()->question()->getCategories();

        // Process form
        if ($this->getRequest()->isPost()) {
            $form->isValid($this->getRequest()->getPost());
        }
        $values = $form->getValues();
        $values['unanswered'] = true;
        if ($user_q_id = $this->_getParam('user_id', false)) {
            $values['user_id'] = $user_q_id;
            $this->view->owner = Engine_Api::_()->getItem('user', $user_q_id);
        }
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
        }
        $this->view->assign($values);

        $this->view->paginator = $paginator = Engine_Api::_()->question()->getQuestionPaginator($values);
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage(Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 20));
        $this->renderScript('index/index.tpl');
    }

    public function manageAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;
        if (!$can_create = $this->_helper->requireAuth()->setAuthParams('question', null, 'create')->checkRequire())
            return;
        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->form = $form = Question_Form_Search::getInstance();
        $this->view->can_create = Engine_Api::_()->question()->can_create_question();
        $this->view->can_delete = $this->can_delete_question('owner');
        $form->removeElement('show');

        // Populate form
        $this->view->categories = $categories = Engine_Api::_()->question()->getCategories();

        // Process form
        $form->isValid($this->getRequest()->getPost());
        $values = $form->getValues();
        $values['user_id'] = $viewer->getIdentity();
        if ($this->_hasParam('category')) {
            $category = $categories->getRowMatching('url', $this->_getParam('category'));
            if (!empty($category)) {
                $values['category'] = $category->getIdentity();
                $form->populate(array('category' => $category->url));
            }
        }
        // Do the show thingy
        $this->view->assign($values);

        $this->view->paginator = $paginator = Engine_Api::_()->question()->getQuestionPaginator($values);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->question_page;
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage($items_per_page);
    }

    public function createAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;
        if (!Engine_Api::_()->question()->can_create_question())
            $this->_helper->requireAuth->forward();
        $this->view->form = $form = new Question_Form_Create();
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
            return $this->_helper->redirector->gotoRouteAndExit(array('question_id' => $question->getIdentity()), 'question_view');
        }
    }

    public function editAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;

        $viewer = Engine_Api::_()->user()->getViewer();
        $question = Engine_Api::_()->getItem('question', $this->_getParam('question_id'));

        if (!Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($question);
        }

        if (!$this->_helper->requireSubject('question')->isValid())
            return;
        if (!$this->_helper->requireAuth()->setAuthParams($question, $viewer, 'edit')->isValid())
            return;
        $this->view->form = $form = new Question_Form_Create();
        $form->setDescription(Zend_Registry::get('Zend_Translate')->_('Edit your question'))
                ->setTitle('Edit Question')
                ->populate($question->toArray());
        if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) {
            $tagStr = '';
            foreach ($question->tags()->getTagMaps() as $tagMap) {
                $tag = $tagMap->getTag();
                if (!isset($tag->text))
                    continue;
                if ('' !== $tagStr)
                    $tagStr .= ', ';
                $tagStr .= $tag->text;
            }

            $form->whtags->setValue($tagStr);
        }
        $files_q = $question->getFiles();
        if (is_array($files_q)) {
            $form->setFiles($files_q);
        }
        $form->submit->setLabel('Save Question');
        if ($question->hasResource()) {
            $form->removeElement('category_id');
            $form->removeElement('auth_answer');
            $form->removeElement('auth_view');
        } else {
            $auth = Engine_Api::_()->authorization()->context;
            $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');

            foreach ($roles as $role) {
                if ($form->auth_view) {
                    if ($auth->isAllowed($question, $role, 'view')) {
                        $form->auth_view->setValue($role);
                    }
                }

                if ($form->auth_answer) {
                    if ($auth->isAllowed($question, $role, 'answer')) {
                        $form->auth_answer->setValue($role);
                    }
                }
            }
            $this->view->categories = Engine_Api::_()->question()->getCategories();
        }
        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
            $values = $form->getValues();
            $db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();
            try {
                $question->setFromArray($values);
                $question->save();
                // Add tags
                if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) {
                    $tags = array_filter(preg_split('/[,]+/', $values['whtags']), "trim");
                    $question->tags()->setTagMaps($viewer, $tags);
                }
                // Auth
                $this->_setAuth($question, $values);
                $action = Engine_Api::_()->getDbtable('actions', 'activity')->getActionsByObject($question);
                // Rebuild privacy
                $actionTable = Engine_Api::_()->getDbtable('actions', 'activity');
                foreach ($actionTable->getActionsByObject($question) as $action) {
                    $actionTable->resetActivityBindings($action);
                }
                $tableStorage = Engine_Api::_()->getItemTable('storage_file');
                $tableStorage->update(array('parent_id' => 0), array('parent_id = ?' => $question->question_id));
                if ($this->_helper->requireAuth()->setAuthParams('question', null, 'max_files')->isValid()) {
                    $tmp_files = $this->getRequest()->getPost('files', false);
                    $max_files = unserialize(Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'question', 'max_files'));
                    if (is_array($tmp_files) and count($tmp_files)) {
                        $save_file_data = array('parent_id' => $question->question_id);
                        $where_str = new Zend_Db_Expr(implode(',', array_slice($tmp_files, 0, $max_files)));
                        $where_files = array("file_id IN (?) or parent_file_id IN (?)" => $where_str);
                        $tableStorage->update($save_file_data, $where_files);
                    }
                }
                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
            return $this->_helper->redirector->gotoRouteAndExit(array('question_id' => $question->getIdentity()), 'question_view');
        }
    }

    public function viewAction() {

        $viewer = Engine_Api::_()->user()->getViewer();
        $question = Engine_Api::_()->getItem('question', $this->_getParam('question_id'));

        if (!Engine_Api::_()->core()->hasSubject('question') and $question instanceof Core_Model_Item_Abstract) {
            Engine_Api::_()->core()->setSubject($question);
        }

        if (!$this->_helper->requireSubject('question')->isValid())
            return;
        if (!$this->_helper->requireAuth()->setAuthParams($question, $viewer, 'view')->isValid())
            return;

        $question->question_views++;
        $question->save();
        $is_best_answer = $question->best_answer_id;

        $this->view->question = $question;
        $this->view->categories = $categories = Engine_Api::_()->question()->getCategories();
        if ($this->getSession()->answer_add) {
            $this->view->message = Zend_Registry::get('Zend_Translate')->_('The answer was successfully added.');
            $this->getSession()->__unset('answer_add');
        }
        $createanswer = new Question_Form_CreateAnswer();
        $this->view->browse_by = $browse_by = new Zend_Form_Element_Select('answer_browse_by', array('multiOptions' => array('creation_date' => Zend_Registry::get('Zend_Translate')->_('Most Recent'),
                'likes' => Zend_Registry::get('Zend_Translate')->_("Most Appreciated"),
                'comments' => Zend_Registry::get('Zend_Translate')->_("Most Commented")),
            'onchange' => 'javascript:order_action(this.value);',
            'decorators' => array('ViewHelper')));

        if ($this->getRequest()->isPost() && $this->getRequest()->getPost('page') === null && $createanswer->isValid($this->getRequest()->getPost()) && Engine_Api::_()->question()->can_answer($question) === 0) {
            $answerTable = Engine_Api::_()->getDbtable('answers', 'question');
            $values = $createanswer->getValues();


            // Begin database transaction
            $db = $answerTable->getAdapter();
            $db->beginTransaction();

            try {
                $answerRow = $answerTable->createRow();
                $answerRow->setFromArray($values);
                $answerRow->user_id = $viewer->getIdentity();
                $answerRow->question_id = $question->question_id;
                $answerRow->save();

                // Auth
                $auth = Engine_Api::_()->authorization()->context;
                $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'everyone');

                foreach ($roles as $role) {
                    $auth->setAllowed($answerRow, $role, 'view', true);
                }

                Engine_Api::_()->authorization()->removeAdapter('question_allow');
                if ($question->hasResource()) {
                    if (!$question->anonymous)
                        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $question->getResource(), 'ge_answer_new', '', array('owner' => $question->getOwner('user')->getGuid()));
                } else {
                    //question && answer are normal
                    if (!$question->anonymous && !$answerRow->anonymous)
                        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $answerRow, 'answer_new', '', array('owner' => $question->getOwner('user')->getGuid()));
                    //only answer is anonymous
                    elseif (!$question->anonymous && $answerRow->anonymous)
                        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity(new Question_Model_Anonymous(), $answerRow, 'answer_new_a_a', '', array('owner' => $question->getOwnerUser()->getGuid()));
                    //only question is anonymous
                    elseif ($question->anonymous && !$answerRow->anonymous)
                        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $answerRow, 'answer_new_q_a');
                    //question && answer are anonymous
                    else
                        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($question->getOwnerUser(), $answerRow, 'answer_new_a_q');
                }
                if ($action != null) {
                    Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($action, $question);
                }
                $db->commit();

                if (!$question->isSubscriber($viewer)) {
                    $question->subscribertoggle($viewer);
                }
                $notifyApi = Engine_Api::_()->getDbtable('notifications', 'activity');

                if ($question->hasResource()) {
                    $resourceType = $question->getResource()->getType();
                    $resourceString = $question->getResource()->__toString();
                    $resourceTitle = $question->getResource()->getTitle();
                    $resourceLink = $question->getResource()->getHref();
                }
                $ownerUser = $answerRow->getOwnerUser();
                foreach ($subscribers as $subscriber) {
                    if ($viewer->isSelf($subscriber))
                        continue;
                    if ($question->hasResource()) {
                        $notify_type = ($question->isOwner($subscriber)) ? $resourceType . '_answer_new' : $resourceType . '_answer_new_subs';
                        $notifyApi->addNotification($subscriber, $ownerUser, $question, $notify_type, array('unsubscribe_link' => $this->view->url(array('module' => 'question',
                                'controller' => 'index',
                                'action' => 'unsubscribe',
                                'unsubhash' => $subscriber->hash), 'default', true),
                            'resource' => $resourceString,
                            'resource_title' => $resourceTitle,
                            'resource_link' => $resourceLink));
                    } else {
                        $notify_type = ($question->isOwner($subscriber)) ? 'answer_new' : 'answer_new_subs';
                        $notifyApi->addNotification($subscriber, $ownerUser, $question, $notify_type, array('unsubscribe_link' => $this->view->url(array('module' => 'question',
                                'controller' => 'index',
                                'action' => 'unsubscribe',
                                'unsubhash' => $subscriber->hash), 'default', true)));
                    }
                }
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
            Engine_Api::_()->question()->setrating('answer', $viewer->getIdentity());
            $this->getSession()->answer_add = true;
            $this->_helper->redirector->gotoRoute(array('route' => 'question_view', 'question_id' => $question->question_id));
        }
        $this->view->createanswer = $createanswer;
        $this->view->can_answer = Engine_Api::_()->question()->can_answer($question);
        $this->view->can_choose_answer = Engine_Api::_()->question()->can_choose_answer($question);
        $answer_param = array('question_id' => $question->question_id);
        if (is_numeric($is_best_answer) && $is_best_answer > 0) {
            $answer_param['best_answer_id'] = $is_best_answer;
            $this->view->best_answer = Engine_Api::_()->getItem('answer', $is_best_answer);
        }
        if ($this->getRequest()->isPost() and $browse_by->isValid($this->getRequest()->getPost('order', 'creation_date'))) {
            $answer_param['orderby'] = $browse_by->getValue();
        }
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getAnswerPaginator($answer_param);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 20);
        $paginator->setCurrentPageNumber(($this->getRequest()->getPost('page') === null and (int) $this->_getParam('page')) ? $this->_getParam('page') : $this->getRequest()->getPost('page') );
        $paginator->setItemCountPerPage($items_per_page);

        $this->view->files = $question->getFiles();
        $this->view->addition_menu_params = Engine_Api::_()->question()->getAdditionMenuParams();
    }

    public function chooseAction() {

        $best_id = $this->_getParam('best_id');
        $answer = Engine_Api::_()->question()
                ->getAnswerSelect(array('answer_id' => $best_id))
                ->query();
        if ($answer->rowCount() != 1)
            return $this->_forward('requiresubject', 'error', 'core');
        $answer = $answer->fetch();
        $question = Engine_Api::_()->getItem('question', $answer['question_id']);
        if (!Engine_Api::_()->question()->can_choose_answer($question))
            return $this->_redirectCustom($question->getHref());
        $question->best_answer_id = $answer['answer_id'];
        $question->status = 'closed';
        $question->save();
        $viewer = Engine_Api::_()->user()->getViewer();

        if (!$viewer->isOwner($question->getOwner())) {
            $ownerUser = $viewer;
        } else {
            $ownerUser = $question->getOwnerUser();
        }
        Engine_Api::_()->authorization()->removeAdapter('question_allow');
        if ($question->hasResource()) {
            $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($ownerUser, $question->getResource(), 'ge_choose_best');
        } else {
            $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($ownerUser, $question, 'choose_best');
        }
        if ($action != null) {
            Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($action, $question);
        }
        Engine_Api::_()->question()->setrating('best_answer', $answer['user_id']);
        $subscribers = $question->get_subscribers();
        $notifyApi = Engine_Api::_()->getDbtable('notifications', 'activity');
        foreach ($subscribers as $subscriber) {
            if ($viewer->isSelf($subscriber))
                continue;
            $notifyApi->addNotification($subscriber, $ownerUser, $question, 'choose_best');
        }

        return $this->_redirectCustom($question->getHref());
    }

    public function ratingAction() {

        $settings = Engine_Api::_()->getApi('settings', 'core');
        if ($settings->getSetting('need_qarating_update', 0) and (time() - $settings->getSetting('time_qarating_update', 0)) > 120) {

            if (!Engine_Api::_()->getDbtable('ratings', 'question')->update_user_ratings()) {
                $this->view->error = 'Update Rating is not finished. Please report to Admin about this.';
                $this->renderScript('etc/error.tpl');
                return;
            }
            $settings->setSetting('need_qarating_update', 0);
            $settings->setSetting('time_qarating_update', time());
        }
        $viewer = Engine_Api::_()->user()->getViewer();

        $this->view->form = $form = Question_Form_Rating::getInstance();

        // Process form
        $values = array();
        if ($this->getRequest()->isPost() and $form->isValid($this->getRequest()->getPost())) {
            $values = $form->getValues();
            //  $this->view->assign($values);
        }

        $this->view->order_users = 'ud';
        $this->view->order_points = 'pu';
        $this->view->order_questions = 'qd';
        $this->view->order_answers = 'ad';
        $this->view->order_best_answers = 'bad';
        if (isset($values['order'])) {
            switch ($values['order']) {
                case 'ud': $this->view->order_users = 'uu';
                    break;
                case 'pu': $this->view->order_points = 'pd';
                    break;
                case 'qd': $this->view->order_questions = 'qu';
                    break;
                case 'ad': $this->view->order_answers = 'au';
                    break;
                case 'bad': $this->view->order_best_answers = 'bau';
                    break;
            }
        }
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getRatingPaginator($values);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 20);
        $page = $this->_getParam('page', NULL);
        if ($page === null) {
            $place = Engine_Api::_()->getDbtable('ratings', 'question')->getUserRatingPlace($viewer);
            $page = ceil($place / $items_per_page);
        }
        $paginator->setCurrentPageNumber($page);
        $paginator->setItemCountPerPage($items_per_page);
    }

    public function updateurAction() {
        $this->_helper->requireAuth()->setAuthParams('question', null, 'update_ratings')->isValid();
        if (Engine_Api::_()->getDbtable('ratings', 'question')->update_user_ratings()) {
            $settings = Engine_Api::_()->getApi('settings', 'core');
            $settings->setSetting('need_qarating_update', 0);
            $settings->setSetting('time_qarating_update', time());
            $this->_helper->redirector->gotoRoute(array('action' => 'rating'));
        } else {
            $this->view->error = 'Rating Update is not finished. Please try again.';
            $this->renderScript('etc/error.tpl');
        }
    }

    public function answersAction() {

        if (!$this->_helper->requireAuth()->setAuthParams('question', null, 'view')->isValid())
            return;
        $viewer = Engine_Api::_()->user()->getViewer();
        $values = array();
        if ($user_q_id = $this->_getParam('user_id', false)) {
            $values['user_id'] = $user_q_id;
            $this->view->owner = $owner = Engine_Api::_()->getItem('user', $user_q_id);
        }
        $this->view->assign($values);
        if (!$owner->isOwner($viewer)) {
            $values['anonymous'] = 0;
        }
        $this->view->paginator = $paginator = Engine_Api::_()->question()->getAnswerPaginator($values);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 20);
        $paginator->setCurrentPageNumber($this->_getParam('page'));
        $paginator->setItemCountPerPage($items_per_page);
    }

    public function can_delete_question($input) {
        if ($this->_helper->requireAuth()->setAuthParams('question', null, 'del_question')->checkRequire()) {
            $user_Viewer = Engine_Api::_()->user()->getViewer();
            $allowed_view = unserialize(Engine_Api::_()->authorization()->getPermission($user_Viewer->level_id, 'question', 'del_question'));
            if (!$allowed_view)
                return false;
            if ($allowed_view == 'everyone')
                return true;
            if (is_string($input) and $allowed_view == $input) {
                return true;
            } elseif ($input instanceof Question_Model_Question) {
                $user_role = ($input->isOwner($user_Viewer)) ? 'owner' : 'everyone';
                if ($user_role == $allowed_view)
                    return true;
                else
                    return false;
            }
            else
                return false;
        }
        else
            return false;
    }

    public function unsubscribeAction() {
        $hash = $this->_getParam('unsubhash', null);
        if (empty($hash) or strlen($hash) > 32) {
            return $this->_forward('notfound', 'error', 'core');
        }
        $sub = Engine_Api::_()->getDbtable('subscribers', 'question')->fetchRow(array('hash = ?' => $hash));
        if ($sub === null)
            return $this->_forward('notfound', 'error', 'core');
        $this->view->question = Engine_Api::_()->getItem('question', $sub->question_id);
        if ($this->getRequest()->isPost() and $this->getRequest()->getPost('task') == 'do_unsubscribe') {
            $sub->delete();
            $this->view->status = false;
        } else {
            $this->view->status = true;
        }
        $this->_helper->content->setEnabled(false);
    }

    protected function _addQuestion(Question_Form_Create $form) {

        $questionTable = Engine_Api::_()->getItemTable('question');
        $values = $form->getValues();
        $viewer = Engine_Api::_()->user()->getViewer();

        // Begin database transaction
        $db = $questionTable->getAdapter();
        $db->beginTransaction();

        try {

            $questionRow = $questionTable->createRow();
            $questionRow->setFromArray($values);
            $questionRow->user_id = $viewer->getIdentity();
            $questionRow->owner_type = $viewer->getType();
            $questionRow->save();
            // Add tags
            if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) {
                $tags = array_filter(preg_split('/[,]+/', $values['whtags']), "trim");
                $questionRow->tags()->setTagMaps($viewer, $tags);
            }
            $this->_setAuth($questionRow, $values);

            if ($this->_helper->requireAuth()->setAuthParams('question', null, 'max_files')->isValid()) {
                $tmp_files = $this->getRequest()->getPost('files', false);
                if (is_array($tmp_files) and count($tmp_files)) {
                    $save_file_data = array('parent_id' => $questionRow->question_id);
                    $max_files = unserialize(Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'question', 'max_files'));
                    $where_str = new Zend_Db_Expr(implode(',', array_slice($tmp_files, 0, $max_files)));
                    $where_files = array("parent_type = ?" => 'question',
                        "file_id IN (?) or parent_file_id IN (?)" => $where_str);
                    $tableStorage = Engine_Api::_()->getItemTable('storage_file')->update($save_file_data, $where_files);
                }
            }
            $db->commit();
        } catch (Exception $e) {
            $db->rollBack();
            throw $e;
        }
        Engine_Api::_()->question()->setrating('question', $viewer->getIdentity());
        $questionRow->subscribertoggle($viewer);
        return $questionRow;
    }

    private function _setAuth($question, $values) {
        // Auth
        $auth = Engine_Api::_()->authorization()->context;
        $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');

        if (empty($values['auth_view'])) {
            $values['auth_view'] = 'everyone';
        }

        $viewMax = array_search($values['auth_view'], $roles);

        foreach ($roles as $i => $role) {
            $auth->setAllowed($question, $role, 'view', ($i <= $viewMax));
        }

        $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered');

        if (empty($values['auth_answer'])) {
            $values['auth_answer'] = 'registered';
        }

        $answerMax = array_search($values['auth_answer'], $roles);

        foreach ($roles as $i => $role) {
            $auth->setAllowed($question, $role, 'answer', ($i <= $answerMax));
        }
    }

	public function uploadPhotoAction() {
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$this -> _helper -> layout -> disableLayout();

		if (!Engine_Api::_() -> authorization() -> isAllowed('question', $viewer, 'create')) {
			return false;
		}

		if (!$this -> _helper -> requireAuth() -> setAuthParams('question', null, 'create') -> isValid())
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
			Engine_Api::_() -> question() -> setPhoto($photo, $_FILES['userfile']);

			$this -> view -> status = true;
			$this -> view -> name = $_FILES['userfile']['name'];
			$this -> view -> photo_id = $photo -> photo_id;
			$this -> view -> photo_url = $photo -> getPhotoUrl();

			$album = $album_Table -> getSpecialAlbum($viewer, 'question');

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
}
