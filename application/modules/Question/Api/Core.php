<?php

class Question_Api_Core extends Core_Api_Abstract {

    const IMAGE_WIDTH = 720;
    const IMAGE_HEIGHT = 720;
    const THUMB_WIDTH = 140;
    const THUMB_HEIGHT = 160;

    private $_can_qvote;
    private $_can_vote;
    private $_min_points_vote_down_error_message;
    private $_rating_setting;
    private $_user_points;
    private $_categories;
    protected $_create_question;
    protected $_Subject;
    protected $_anonymous;

    private function &__get_can_vote() {
        if ($this->_can_vote === null) {
            $tmp_user = Engine_Api::_()->user();
            if (!$tmp_user->getAuth()->hasIdentity())
                $this->_can_vote['hasIdentity'] = false;
            else
                $this->_can_vote['hasIdentity'] = true;
            if ($this->getSubject()->status == 'closed')
                $this->_can_vote['status'] = false;
            else
                $this->_can_vote['status'] = true;
        }
        return $this->_can_vote;
    }

    public function getCategories() {
        if ($this->_categories === null)
            $this->_categories = Engine_Api::_()->getDbtable('categories', 'question')->fetchAll(null, 'order ASC');
        return $this->_categories;
    }

    public function getQuestionPaginator($params = array()) {
        $paginator = Zend_Paginator::factory($this->getQuestionSelect($params));
        if (!empty($params['page'])) {
            $paginator->setCurrentPageNumber($params['page']);
        }
        if (!empty($params['limit'])) {
            $paginator->setItemCountPerPage($params['limit']);
        }
        return $paginator;
    }

    public function getRatingPaginator($params = array()) {
        $paginator = Zend_Paginator::factory($this->getRatingSelect($params));
        if (!empty($params['page'])) {
            $paginator->setCurrentPageNumber($params['page']);
        }
        if (!empty($params['limit'])) {
            $paginator->setItemCountPerPage($params['limit']);
        }
        return $paginator;
    }

    public function getRatingSelect($params = array()) {
        $period = (!empty($params['period']) and $params['period'] == 'month') ? 'mratings' : 'ratings';
        $table = Engine_Api::_()->getDbtable($period, 'question');
        $rName = $table->info('name');


        $select = $table->select()
                ->from($rName, array($rName . '.*', 'rownum' => new Zend_Db_Expr('@rownum:=@rownum+1')));
        if (!empty($params['order'])) {
            switch ($params['order']) {
                case 'pu': $order = 'total_points ASC';
                    break;
                case 'ud': $order = 'rating_id DESC';
                    break;
                case 'uu': $order = 'rating_id ASC';
                    break;
                case 'qd': $order = 'total_questions DESC';
                    break;
                case 'qu': $order = 'total_questions ASC';
                    break;
                case 'ad': $order = 'total_answers DESC';
                    break;
                case 'au': $order = 'total_answers ASC';
                    break;
                case 'bad': $order = 'total_best_answers DESC';
                    break;
                case 'bau': $order = 'total_best_answers ASC';
                    break;
                case 'pd':
                default: $order = 'total_points DESC';
                    break;
            }
        }
        else
            $order = 'total_points DESC';
        $select->order($order);

        if (!empty($params['search'])) {
            $select->joinLeft('engine4_users', "`engine4_users`.`user_id` = `$rName`.`rating_id`", array())
                    ->where("`engine4_users`.`username` LIKE ? or `engine4_users`.`displayname` LIKE ? ", '%' . $params['search'] . '%')
            ;
        }
        $second_select = $table->select()->setIntegrityCheck(false)
                ->from(array('tmp' => $select));
        return $second_select;
    }

    public function getQuestionSelect($params = array()) {
        $table = Engine_Api::_()->getDbtable('questions', 'question');
        $rName = $table->info('name');


        $select = $table->select()
                ->order(!empty($params['orderby']) ? $params['orderby'] . ' DESC' : 'modified_date DESC' );

        if (!empty($params['user_id']) && is_numeric($params['user_id'])) {
            $select->where($rName . '.user_id = ?', $params['user_id']);
        }
        if (!empty($params['resource']) and is_array($params['resource'])) {
            if (isset($params['resource']['resource_type'])) {
                $select->where($rName . '.resource_type = ?', $params['resource']['resource_type']);
            }
            if (isset($params['resource']['resource_id'])) {
                $select->where($rName . '.resource_id = ?', $params['resource']['resource_id']);
            }
        } else {
            $select->where($rName . '.resource_type IS NULL');
            $select->where($rName . '.resource_id  IS NULL');
        }
        if (!empty($params['user']) && $params['user'] instanceof User_Model_User) {
            $select->where($rName . '.user_id = ?', $params['user_id']->getIdentity());
        }

        if (!empty($params['users'])) {
            if (is_array($params['users']) and count($params['users']) > 0) {
                $str = (string) ( is_array($params['users']) ? "'" . join("', '", $params['users']) . "'" : $params['users'] );
                $select->where($rName . '.user_id in (?)', new Zend_Db_Expr($str));
            } else {
                $select->where($rName . '.user_id in ', '()');
            }
        }

        if (!empty($params['category'])) {
            $select->where($rName . '.category_id = ?', $params['category']);
        }
        if (!empty($params['question_id'])) {
            $select->where($rName . '.question_id = ?', $params['question_id']);
        }
        if (!empty($params['status']) and $params['status'] != '0') {
            $select->where($rName . ".`status` = ?", $params['status']);
        }

        // Could we use the search indexer for this?
        if (!empty($params['search'])) {
            $select->where("LOWER(" . $rName . ".question) LIKE ? or LOWER(" . $rName . ".title) LIKE ? ", '%' . strtolower($params['search']) . '%');
        }
        $select->from($rName, array('*', 'count_answers' => 'COUNT(DISTINCT `engine4_question_answers`.`answer_id`)'))
                ->joinLeftUsing('engine4_question_answers', 'question_id', array())
                ->group("$rName.question_id");
        if (isset($params['unanswered']) and $params['unanswered']) {
            $select->having(new Zend_Db_Expr('count_answers = 0'));
        }
        if (!empty($params['tags']) && is_string($params['tags'])) {
            $tmTable = Engine_Api::_()->getDbtable('TagMaps', 'core');
            $tmName = $tmTable->info('name');
            $select_tags = $tmTable->select();
            $select_tags->setIntegrityCheck(false)
                    ->from($tmName, array('resource_id'))
                    ->joinLeftUsing('engine4_core_tags', 'tag_id', array())
                    ->where($tmName . '.resource_type = ?', 'question');
            $tags_array = explode(',', $params['tags']);
            $tag_str = '';
            $i = 0;
            foreach ($tags_array as $tag_str_tmp) {
                if (!trim($tag_str_tmp))
                    continue;
                $tag_str .= "'" . trim(trim($tag_str_tmp), ',') . "',";
                $i++;
            }
            $tag_str = rtrim($tag_str, ',');
            if (trim($tag_str)) {
                $select_tags->where('engine4_core_tags.text in (?)', new Zend_Db_Expr($tag_str))
                        ->group(new Zend_Db_Expr('`engine4_core_tagmaps`.`resource_id`'))
                        ->having(new Zend_Db_Expr("count(`engine4_core_tagmaps`.`resource_id`) = $i"));
                $select->setIntegrityCheck(false)
                        ->where($rName . '.question_id in ?', $select_tags);
            }
        }
        if (isset($params['anonymous'])) {
            if ($params['anonymous']) {
                $select->where($rName . '.anonymous = 1');
            } else {
                $select->where($rName . '.anonymous = 0');
            }
        }

        return $select;
    }

    public function getAnswerPaginator($params = array()) {
        $paginator = Zend_Paginator::factory($this->getAnswerSelect($params));
        if (!empty($params['page'])) {
            $paginator->setCurrentPageNumber($params['page']);
        }
        if (!empty($params['limit'])) {
            $paginator->setItemCountPerPage($params['limit']);
        }
        return $paginator;
    }

    public function getAnswerSelect($params = array()) {
        $table = Engine_Api::_()->getDbtable('answers', 'question');
        $rName = $table->info('name');

        $select = $table->select()
                ->order(!empty($params['orderby']) ? $params['orderby'] . ' DESC' : 'creation_date DESC' );
        if (!empty($params['orderby'])) {
            if ($params['orderby'] == 'likes') {
                $select->setIntegrityCheck(false)
                        ->from($rName)
                        ->joinLeft('engine4_question_votes', $rName . '.answer_id = engine4_question_votes.answer_id and engine4_question_votes.vote_for = \'1\'', array('likes' => 'COUNT(DISTINCT `engine4_question_votes`.`vote_id`)'))
                        ->group($rName . '.answer_id');
            }
            if ($params['orderby'] == 'comments') {
                $select->setIntegrityCheck(false)
                        ->from($rName)
                        ->joinLeft('engine4_core_comments', $rName . '.answer_id = engine4_core_comments.resource_id and engine4_core_comments.resource_type = \'answer\'', array('comments' => 'COUNT(DISTINCT `engine4_core_comments`.`comment_id`)'))
                        ->group($rName . '.answer_id');
            }
        }

        if (isset($params['question_id'])) {
            $select->where($rName . '.question_id = ?', $params['question_id']);
        }
        if (isset($params['user_id'])) {
            $select->where($rName . '.user_id = ?', $params['user_id']);
        }
        if (isset($params['best_answer_id'])) {
            $select->where($rName . '.answer_id != ?', $params['best_answer_id']);
        }
        if (isset($params['answer_id'])) {
            $select->where($rName . '.answer_id = ?', $params['answer_id']);
        }
        if (isset($params['anonymous'])) {
            if ($params['anonymous']) {
                $select->where($rName . '.anonymous = 1');
            } else {
                $select->where($rName . '.anonymous = 0');
            }
        }
        return $select;
    }

    public function getCategory($category_id) {
        return $this->getCategories()->getRowMatching('category_id', $category_id);
    }

    public function can_answer(&$question) {
        $auth = Question_Model_DbTable_Allow::_()->is_can_Answer($question);
        return $auth;
    }

    public function can_choose_answer(&$question) {
        $auth = Question_Model_DbTable_Allow::_()->can_choose_Answer($question);
        return $auth;
    }

    public function can_vote(&$answer) {
        $subject_question = $this->getSubject();
        if ($subject_question->status == 'closed')
            return 2;
        if ($subject_question->status != 'open')
            return 3;
        $tmp_answer_id = $answer->answer_id;
        $this->__get_can_vote();
        if (empty($this->_can_vote[$tmp_answer_id])) {
            empty($tmp_user) && $tmp_user = Engine_Api::_()->user();
            if ($this->_can_vote['hasIdentity'] === false)
                return $this->_can_vote[$tmp_answer_id] = 7;
            if ($this->_can_vote['status'] === false)
                return $this->_can_vote[$tmp_answer_id] = 10;
            elseif (($tmp_user_id = $tmp_user->getViewer()->user_id) == $answer->user_id)
                return $this->_can_vote[$tmp_answer_id] = 8;
            $table = Engine_Api::_()->getDbtable('votes', 'question');
            $rowCount = $table->select()->limit(1)
                    ->where('user_id = ?', $tmp_user_id)
                    ->where('answer_id = ?', $tmp_answer_id)
                    ->query()
                    ->rowCount();
            if ($rowCount > 0)
                return $this->_can_vote[$tmp_answer_id] = 9;
            $this->_can_vote[$tmp_answer_id] = true;
        }
        return $this->_can_vote[$tmp_answer_id];
    }

    public function can_vote_up(&$answer) {
        if (($can_vote = $this->can_vote($answer)) !== true)
            return $can_vote;
        return true;
    }

    public function can_vote_down(&$answer) {
        if (($can_vote = $this->can_vote($answer)) !== true)
            return $can_vote;
        if (empty($this->_can_vote['down'])) {
            if (!$this->is_valid_rating_setting('question_min_points_vote_down'))
                $this->_can_vote['down'] = 11;
            else
                $this->_can_vote['down'] = true;
        }

        return $this->_can_vote['down'];
    }

    public function get_voted(&$answer) {
        $viewer = Engine_api::_()->user()->getViewer();
        if ($answer->isOwner($viewer))
            return null;

        $table = Engine_Api::_()->getDbtable('votes', 'question');
        $select = $table->select();
        $select->where('user_id = ?', $viewer->getIdentity())
                ->where('answer_id = ?', $answer->getIdentity());

        $row = $table->fetchRow($select);

        if ($row)
            return (bool) $row->vote_for;

        return null;
    }

    public function is_valid_rating_setting($type) {
        if (empty($this->_rating_setting[$type])) {
            if ($this->get_user_points() < Engine_Api::_()->getApi('settings', 'core')->getSetting($type, 0))
                $this->_rating_setting[$type] = false;
            else
                $this->_rating_setting[$type] = true;
        }
        return $this->_rating_setting[$type];
    }

    public function get_user_points($user_id = false) {
        if (!$user_id)
            $user_id = Engine_Api::_()->user()->getViewer()->user_id;
        if (empty($this->_user_points[(int) $user_id])) {
            $rating_item = Engine_Api::_()->getItem('question_rating', (int) $user_id);
            if ($rating_item === null)
                $this->_user_points[(int) $user_id] = 0;
            else
                $this->_user_points[(int) $user_id] = $rating_item->total_points;
        }
        return $this->_user_points[(int) $user_id];
    }

    public function getstatus_message($id) {
        $id = (int) $id;
        if (!$id)
            return '';
        switch ($id) {
            case 1:
                $message = Zend_Registry::get('Zend_Translate')->_('You must login to post an answer.');
                break;
            case 2:
                $message = Zend_Registry::get('Zend_Translate')->_('Question was closed.');
                break;
            case 3:
                $message = Zend_Registry::get('Zend_Translate')->_('Question was cancelled.');
                break;
            case 4:
                $message = 'You can not answer on your own question.';
                break;
            case 5:
                $max_answers = Engine_Api::_()->authorization()->getPermission(Engine_Api::_()->user()->getViewer()->level_id, 'question', 'max_answers');
                $message = Zend_Registry::get('Zend_Translate')->_("You can't leave more than %d answers to one question.");
                return sprintf($message, $max_answers);
                break;
            case 6:
                $message = Zend_Registry::get('Zend_Translate')->_("You can't post answers. This is not allowed for your user level.");
                break;
            case 7:
                $message = Zend_Registry::get('Zend_Translate')->_("You need to login for voting.");
                break;
            case 8:
                $message = Zend_Registry::get('Zend_Translate')->_("You can't vote for your own answers.");
                break;
            case 9:
                $message = Zend_Registry::get('Zend_Translate')->_('Your vote is already accepted.');
                break;
            case 10:
                $message = Zend_Registry::get('Zend_Translate')->_('Question is closed.');
                break;
            case 11:
                if ($this->_min_points_vote_down_error_message === null) {
                    $min_points = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_min_points_vote_down', 0);
                    $message = Zend_Registry::get('Zend_Translate')->_("You can't vote down until you have at least %d points.");
                    $this->_min_points_vote_down_error_message = sprintf($message, $min_points);
                }
                return $this->_min_points_vote_down_error_message;
                break;
            case 12:
                $message = Zend_Registry::get('Zend_Translate')->_("You aren't allowed to answer this question because of permissions set by author.");
                break;
            case 13:
                $message = Zend_Registry::get('Zend_Translate')->_("You can't vote for your own question.");
                break;
        }
        return Zend_Registry::get('Zend_Translate')->_($message);
    }

    /**
     *
     * @param <type> $type
     * Possible values: vote+, vote-, question, answer, best_answer.
     * @param <type> $user_id
     */
    public function setrating($type, $user_id = false) {
        $user_id = ($user_id === false) ? Engine_Api::_()->user()->getViewer()->getIdentity() : (int) $user_id;
        $rating_item = Engine_Api::_()->getItem('question_rating', $user_id);
        if ($rating_item === null) {
            $ratingTable = Engine_Api::_()->getDbtable('ratings', 'question');
            $db = $ratingTable->getAdapter();
            $db->beginTransaction();
            try {
                $ratingRow = $ratingTable->createRow();
                $ratingRow->rating_id = $user_id;
                $ratingRow->save();
                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
            $rating_item = Engine_Api::_()->getItem('question_rating', $user_id);
        }
        switch ($type) {
            case 'vote+':
                $addpoints = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_thumb_up', 1);
                break;
            case 'vote-':
                $addpoints = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_thumb_down', 1) * (-1);
                break;
            case 'question':
                $addpoints = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_posted_question', 1);
                $rating_item->total_questions++;
                break;
            case 'answer':
                $addpoints = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_posted_answer', 1);
                $rating_item->total_answers++;
                break;
            case 'best_answer':
                $addpoints = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_best_answer', 5);
                $rating_item->total_best_answers++;
                break;
            default:
                break;
        }
        $rating_item->total_points = (($sum_point = ($rating_item->total_points + $addpoints)) >= 0) ? $sum_point : 0;
        $rating_item->save();
    }

    public function can_delete_answer(&$answer) {
        $can_vote = &$this->__get_can_vote();
        if ($can_vote['hasIdentity'] === false or $can_vote['status'] === false)
            return false;
        $user_Viewer = Engine_Api::_()->user()->getViewer();
        $permission = Engine_Api::_()->authorization()->getPermission($user_Viewer->level_id, 'question', 'del_answer');
        if (!$permission)
            return false;
        $permission = unserialize($permission);
        if ($permission == 'everyone')
            return true;
        if ($permission == 'all' or $permission == 'qowner') {
            if ($this->getSubject()->isOwner($user_Viewer))
                return true;
        }
        if ($permission == 'all' or $permission == 'owner') {
            if ($answer->isOwner($user_Viewer))
                return true;
        }
        return false;
    }

    public function createImage($file) {
        // Get image info and resize
        $name = basename($file['tmp_name']);
        $path = dirname($file['tmp_name']);
        $extension = ltrim(strrchr($file['name'], '.'), '.');

        $mainName = $path . '/m_' . $name . '.' . $extension;
        $thumbName = $path . '/t_' . $name . '.' . $extension;

        $image = Engine_Image::factory();
        $image->open($file['tmp_name'])
                ->resize(self::IMAGE_WIDTH, self::IMAGE_HEIGHT)
                ->write($mainName)
                ->destroy();

        $image = Engine_Image::factory();
        $image->open($file['tmp_name'])
                ->resize(self::THUMB_WIDTH, self::THUMB_HEIGHT)
                ->write($thumbName)
                ->destroy();

        // Store photos
        $photo_params = array(
            'parent_id' => Engine_Api::_()->user()->getViewer()->getIdentity(),
            'parent_type' => 'question',
        );

        try {
            $photoFile = Engine_Api::_()->storage()->create($mainName, $photo_params);
            $thumbFile = Engine_Api::_()->storage()->create($thumbName, $photo_params);
        } catch (Exception $e) {
            throw $e;
        }

        $photoFile->bridge($thumbFile, 'thumb.normal');

        // Remove temp files
        @unlink($mainName);
        @unlink($thumbName);
        $photoFile->parent_id = 0;
        $photoFile->save();
        return $photoFile->file_id;
    }

    public function can_qvote() {
        if (empty($this->_can_qvote)) {
            $question = $this->getSubject();
            if ($question->status == 'closed')
                return $this->_can_qvote = 10;
            if ($question->status != 'open')
                return $this->_can_qvote = 3;
            $viewer = Engine_Api::_()->user()->getViewer();
            if (!Engine_Api::_()->user()->getAuth()->hasIdentity())
                return $this->_can_qvote = 7;
            if ($question->isOwner($viewer))
                return $this->_can_qvote = 13;
            $table = Engine_Api::_()->getDbtable('qvotes', 'question');
            $rowCount = $table->select()->limit(1)
                    ->where('user_id = ?', $viewer->getIdentity())
                    ->where('question_id = ?', $question->getIdentity())
                    ->query()
                    ->rowCount();
            if ($rowCount > 0)
                return $this->_can_qvote = 9;
            $this->_can_qvote = true;
        }
        return $this->_can_qvote;
    }

    public function can_qvote_up() {
        if (($can_vote = $this->can_qvote()) !== true)
            return $can_vote;
        return true;
    }

    public function can_qvote_down() {
        if (($can_vote = $this->can_qvote()) !== true)
            return $can_vote;
        if (!$this->is_valid_rating_setting('question_min_points_vote_down'))
            return 11;
        else
            return true;
    }

    public function get_qvoted() {
        $question = $this->getSubject();
        $viewer = Engine_Api::_()->user()->getViewer();

        if ($question->isOwner($viewer))
            return null;
        $table = Engine_Api::_()->getDbtable('qvotes', 'question');
        $select = $table->select()->limit(1)
                ->where('user_id = ?', $viewer->getIdentity())
                ->where('question_id = ?', $question->getIdentity());

        $row = $table->fetchRow($select);

        if ($row)
            return (bool) $row->vote_for;

        return null;
    }

    public function getVotePaginator($params = array()) {
        $paginator = Zend_Paginator::factory($this->getVoteSelect($params));
        if (!empty($params['page'])) {
            $paginator->setCurrentPageNumber($params['page']);
        }
        if (!empty($params['limit'])) {
            $paginator->setItemCountPerPage($params['limit']);
        }
        return $paginator;
    }

    public function getVoteSelect($params = array()) {
        $table = Engine_Api::_()->getItemTable('user');
        $rName = $table->info('name');
        $select = $table->select()
                ->from($rName);
        if (empty($params['type']))
            throw new Engine_Exception("Param type cann't be empty.");
        if (empty($params['vote_type']))
            throw new Engine_Exception("Param vote_type cann't be empty.");
        $type_table = Engine_Api::_()->getDbtable($params['type'], 'question');
        $tName = $type_table->info('name');
        $select->joinLeftUsing($tName, 'user_id', array())
                ->where($tName . '.' . $params['vote_type'] . ' = 1');
        if (!empty($params['id'])) {
            if ($params['type'] == 'votes') {
                $type_id = 'answer_id';
            } else {
                $type_id = 'question_id';
            }
            $select->where($tName . '.' . $type_id . ' = ?', $params['id']);
        }
        return $select;
    }

    public function can_create_question() {
        if (!Zend_Controller_Action_HelperBroker::getStaticHelper('RequireAuth')->setAuthParams('question', null, 'create')->checkRequire())
            return false;

        if (!$this->is_valid_rating_setting('question_min_points_ask'))
            return false;

        return true;
    }

    public function isAdmin(User_Model_User $user) {
        // Not logged in, not an admin
        if (!$user->getIdentity() || empty($user->level_id)) {
            return false;
        }

        // Check level
        $level = Engine_Api::_()->getItem('authorization_level', $user->level_id);
        if ($level->type == 'admin' || $level->type == 'moderator') {
            return true;
        }

        return false;
    }

    public function getAdditionMenuParams(Question_Model_Question $question = null, User_Model_User $user = null) {
        $params = array();
        $moderation = Zend_Controller_Action_HelperBroker::getStaticHelper('RequireAuth')->setAuthParams('question', null, 'moderation')->checkRequire();
        if ($question == null) {
            if (Engine_Api::_()->core()->hasSubject('question')) {
                $question = Engine_Api::_()->core()->getSubject('question');
            } else {
                return $params;
            }
        }
        if ($user == null) {
            $user = Engine_Api::_()->user()->getViewer();
            if (!$user->getIdentity()) {
                return $params;
            }
        }
        if ($question->isOwner($user) and $question->status == 'open') {
            $param = array(
                'label' => 'Edit Entry',
                'class' => 'icon_qa_edit buttonlink',
                'route' => 'question_edit',
                'params' => array(
                    'question_id' => $question->getIdentity()
                )
            );
            if ($question->hasResource()) {
                $param['params']['subject'] = $question->getResource()->getGuid();
            }
            $params[] = $param;
        } elseif ($moderation) {
            $params[] = array(
                'label' => 'Edit Entry',
                'class' => 'icon_qa_edit buttonlink',
                'route' => 'question_moderation',
                'action' => 'edit',
                'params' => array(
                    'question_id' => $question->getIdentity()
                )
            );
        }
        if ($question->status == 'open' and $question->User_can($user, 'cancel')) {
            $params[] = array(
                'label' => 'Cancel',
                'class' => 'smoothbox icon_qa_cancel buttonlink',
                'route' => 'default',
                'params' => array(
                    'module' => 'question',
                    'controller' => 'smoothbox',
                    'action' => 'cancel',
                    'id' => $question->getIdentity()
                )
            );
        }
        if ($question->status != 'open' and $question->User_can($user, 'reopen')) {
            $params[] = array(
                'label' => 'Reopen',
                'class' => 'smoothbox icon_qa_reopen buttonlink',
                'route' => 'default',
                'params' => array(
                    'module' => 'question',
                    'controller' => 'smoothbox',
                    'action' => 'reopen',
                    'id' => $question->getIdentity()
                )
            );
        }
        if ($question->User_can($user, 'del')) {
            $params[] = array(
                'label' => 'Delete',
                'class' => 'smoothbox icon_qa_delete buttonlink',
                'route' => 'default',
                'params' => array(
                    'module' => 'question',
                    'controller' => 'smoothbox',
                    'action' => 'deleteq',
                    'id' => $question->getIdentity()
                )
            );
        }
        if ($moderation) {
            $params[] = array(
                'label' => 'Manage Answers',
                'class' => 'icon_qa_edit buttonlink',
                'route' => 'question_moderation',
                'params' => array(
                    'question_id' => $question->getIdentity()
                )
            );
        }
        return $params;
    }

    public function setSubject(Question_Model_Question $question = null) {
        if ($question === null) {
            $this->_Subject = Engine_Api::_()->core()->getSubject('question');
        } else {
            $this->_Subject = $question;
        }
    }

    public function getSubject() {
        if ($this->_Subject == null) {
            $this->setSubject();
        }
        return $this->_Subject;
    }

    public function getQuestion_anonymous() {
        if ($this->_anonymous === NULL) {
            $this->_anonymous = new Question_Model_Anonymous();
        }
        return $this->_anonymous;
    }

	public function setPhoto($parent, $photo) {
		if ($photo instanceof Zend_Form_Element_File) {
			$file = $photo -> getFileName();
			$fileName = $file;
		} else if ($photo instanceof Storage_Model_File) {
			$file = $photo -> temporary();
			$fileName = $photo -> name;
		} else if ($photo instanceof Core_Model_Item_Abstract && !empty($photo -> file_id)) {
			$tmpRow = Engine_Api::_() -> getItem('storage_file', $photo -> file_id);
			$file = $tmpRow -> temporary();
			$fileName = $tmpRow -> name;
		} else if (is_array($photo) && !empty($photo['tmp_name'])) {
			$file = $photo['tmp_name'];
			$fileName = $photo['name'];
		} else if (is_string($photo) && file_exists($photo)) {
			$file = $photo;
			$fileName = $photo;
		} else {
			throw new User_Model_Exception('invalid argument passed to setPhoto');
		}

		if (!$fileName) {
			$fileName = $file;
		}

		$name = basename($file);
		$extension = ltrim(strrchr($fileName, '.'), '.');
		$base = rtrim(substr(basename($fileName), 0, strrpos(basename($fileName), '.')), '.');
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array('parent_type' => $parent -> getType(), 
						'parent_id' => $parent -> getIdentity(), 
						'user_id' => $parent -> owner_id, 
						'name' => $fileName, );

		// Save
		$filesTable = Engine_Api::_() -> getDbtable('files', 'storage');

		// Resize image (main)
		$mainPath = $path . DIRECTORY_SEPARATOR . $base . '_m.' . $extension;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(720, 720) -> write($mainPath) -> destroy();

		// Resize image (normal)
		$normalPath = $path . DIRECTORY_SEPARATOR . $base . '_in.' . $extension;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(140, 160) -> write($normalPath) -> destroy();

		// Store
		try {
			$iMain = $filesTable -> createFile($mainPath, $params);
			$iIconNormal = $filesTable -> createFile($normalPath, $params);

			$iMain -> bridge($iIconNormal, 'thumb.normal');
		} catch( Exception $e ) {
			// Remove temp files
			@unlink($mainPath);
			@unlink($normalPath);
			// Throw
			if ($e -> getCode() == Storage_Model_DbTable_Files::SPACE_LIMIT_REACHED_CODE) {
				throw new Album_Model_Exception($e -> getMessage(), $e -> getCode());
			} else {
				throw $e;
			}
		}

		// Remove temp files
		@unlink($mainPath);
		@unlink($normalPath);

		// Update row
		$parent -> modified_date = date('Y-m-d H:i:s');
		$parent -> file_id = $iMain -> file_id;
		$parent -> save();

		// Delete the old file?
		if (!empty($tmpRow)) {
			$tmpRow -> delete();
		}

		return $parent;
	}
}
