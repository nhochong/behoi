<?php

class Question_Model_Question extends Core_Model_Item_Abstract {

    protected $_parent_type = 'user';
    protected $_parent_is_owner = true;
    protected $_owner_type = 'quser';
    protected $_owner;
    protected $_anonymous;
    protected $_votes;
    protected $_SubscribersTable;
    protected $_resource;
    public $owner_id;
    static protected $_del_question;
    static protected $_cancel_question;
    static protected $_reopen_question;
    static protected $_delcom_question;

    public function __construct(array $config) {
        parent::__construct($config);
        $this->owner_id = $this->user_id;
    }

    public function getHref() {

        $params = array('question_id' => $this->question_id,
            'slug' => $this->getSlug());
        return Zend_Controller_Front::getInstance()->getRouter()
                        ->assemble($params, 'question_view', true);
    }

    public function getQuestion($trunkate = false) {
        $trunkate = (int) $trunkate;
        if ($trunkate) {
            $question_body = mb_substr(strip_tags($this->question), 0, $trunkate);
            if (strlen($this->question) > $trunkate)
                $question_body .= "...";
            return $question_body;
        }
        else
            return $this->question;
    }

    public function getTitle() {
        if (trim($this->title))
            return $this->title;
        else
            return $this->getQuestion(100);
    }

    public function getDescription() {
        return $this->getQuestion(255);
    }

    public function getOwner($recurseType = null) {
        if ($this->owner_id === null) {
            $this->owner_id = $this->user_id;
        }
        if ($this->_owner == null)
            $this->_owner = parent::getOwner($recurseType);
        return $this->_owner;
    }

    public function User_can(User_Model_User $user, $type) {
        if (!in_array($type, array('del', 'cancel', 'reopen', 'delcom'))) {
            throw new Engine_Exception('Invalid type of permission.');
        }
        $type_var = '_' . $type . '_question';
        if (self::$$type_var === null) {
            if (!isset($user->level_id))
                $allowed_view = false;
            else
                $allowed_view = unserialize(Engine_Api::_()->authorization()->getPermission($user->level_id, 'question', $type . '_question'));
            self::$$type_var = $allowed_view;
        }
        $allowed_view = self::$$type_var;
        if (!$allowed_view)
            return false;
        if ($allowed_view == 'everyone')
            return true;
        if (($allowed_view == 'owner' and $this->isOwner($user)))
            return true;
        else
            return false;
    }

    public function getFiles() {
        $files = Engine_Api::_()->getItemTable('storage_file')->fetchAll(array('parent_type = ?' => 'question',
                    'parent_id = ?' => $this->question_id,
                    'type IS NULL'))->toArray();
        if (!count($files))
            return false;
        $files_array = array();
        foreach ($files as $file) {
            $files_array[] = $file['file_id'];
        }
        return $files_array;
    }

    public function getSlug($str = null) {
        $str = $this->getTitle();
        $str = rtrim($str, '.');
        $str = preg_replace('/([a-z])([A-Z])/', '$1 $2', $str);
        $str = strtolower($str);
        $str = preg_replace('/[^a-z0-9-]+/i', '-', $str);
        $str = preg_replace('/-+/', '-', $str);
        $str = trim($str, '-');
        if (!$str) {
            $str = '-';
        }
        return $str;
    }

    /**
     * return count question votes
     *
     * @param <type> $type :
     * all - sum '+' & '-'
     * '-' - votes agains question
     * '+' - count votes for question
     */
    public function getVotes($type = 'all') {
        if (!in_array($type, array('all', '+', '-')))
            throw new Engine_Exception('Invalid argument passed to getVotes()');
        if ($this->_votes === null) {
            $this->_votes = Engine_Api::_()->getDbtable('qvotes', 'question')->getvotes((int) $this->getIdentity());
        }
        switch ($type) {
            case '+':
                $type = 'vote_for';
                break;
            case '-':
                $type = 'vote_against';
                break;
            default : $type = 'all';
                break;
        }
        return $this->_votes->$type;
    }

    public function isSubscriber($user, Question_Model_Subscriber &$subscriber = NULL) {
        if ($user instanceof User_Model_User)
            $user_id = $user->getIdentity();
        else
            $user_id = (int) $user;
        return $this->_getSubscribersTable()->isSubscriber($user_id, $this->getIdentity(), $subscriber);
    }

    public function subscribertoggle($user) {
        if ($user instanceof User_Model_User)
            $user_id = $user->getIdentity();
        else
            $user_id = (int) $user;
        return $this->_getSubscribersTable()->subscribertoggle($user_id, $this->getIdentity());
    }

    public function get_subscribers() {
        return $this->_getSubscribersTable()->get_subscribers($this->getIdentity());
    }

    public function issetVotes() {
        return ($this->getVotes('+') or $this->getVotes('-'));
    }

    public function hasResource() {
        if ($this->_resource === null) {
            $resource_type = $this->resource_type;
            $resource_id = $this->resource_id;
            if (!empty($resource_type) and !empty($resource_id)) {
                $item = Engine_Api::_()->getItem($resource_type, $resource_id);
                if (!empty($item)) {
                    $this->_resource = $item;
                    return true;
                } else {
                    $this->_resource = false;
                    return false;
                }
            } else {
                $this->_resource = false;
                return false;
            }
        }
        return !(empty($this->_resource));
    }

    public function getResource() {
        if ($this->hasResource()) {
            return $this->_resource;
        }
        else
            return null;
    }

    public function tags() {
        return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('tags', 'core'));
    }

    public function gettags() {
        return $this->tags()->getTagMaps();
    }

    public function getKeywords($separator = ' ') {
        $keywords = array();
        foreach ($this->gettags() as $tagmap) {
            $tag = $tagmap->getTag();
            $keywords[] = $tag->getTitle();
        }

        if (null === $separator) {
            return $keywords;
        }

        return join($separator, $keywords);
    }

    public function getOwnerUser() {
        if ($this->_anonymous === NULL) {
            if ($this->anonymous) {
                $this->_anonymous = new Question_Model_Anonymous();
            } else {
                $this->_anonymous = $this->getOwner();
            }
        }
        return $this->_anonymous;
    }

    protected function _getSubscribersTable() {
        if ($this->_SubscribersTable === null) {
            $this->_SubscribersTable = Engine_Api::_()->getDbtable('subscribers', 'question');
        }
        return $this->_SubscribersTable;
    }

}