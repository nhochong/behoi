<?php

class Question_Model_Answer extends Core_Model_Item_Abstract {

    protected $_owner_type = 'user';
    protected $_type = 'answer';
    protected $_parent_type = 'user';
    protected $_anonymous;
    protected $_parent_is_owner = true;
    protected $_searchColumns = array();
    protected $_votes;

    public function getHref() {
        $answer_param = array('question_id' => $this->question_id);
        $paginator = Engine_Api::_()->question()->getAnswerPaginator($answer_param);
        $items_per_page = Engine_Api::_()->getApi('settings', 'core')->question_page;
        $paginator->setItemCountPerPage($items_per_page);
        $pages = $paginator->count();
        for ($index = 1; $index <= $pages; $index++) {
            if ($paginator->getItemsByPage($index)->getRowMatching('answer_id', $this->answer_id) !== null)
                break;
        }

        return Zend_Controller_Front::getInstance()->getRouter()->assemble(array('question_id' => $this->question_id,
                    'page' => $index), 'question_view', true) . '#' . $this->answer_id;
    }

    public function getQuestionHref() {
        // This doesn't have a primary view page
        return array('route' => 'question_view', 'question_id' => $this->question_id);
    }

    /**
     * return count answer votes
     *
     * @param <type> $type :
     * all - sum '+' & '-'
     * '-' - votes agains answer
     * '+' - count votes for answer
     */
    public function getVotes($type = 'all') {
        if (!in_array($type, array('all', '+', '-')))
            throw new Engine_Exception('Invalid argument passed to getVotes()');
        if ($this->_votes === null) {
            $this->_votes = Engine_Api::_()->getDbtable('votes', 'question')->getvotes((int) $this->answer_id);
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

    public function getShortAnswer($trunkate = false) {
        $trunkate = (int) $trunkate;
        if ($trunkate) {
            $answer_body = mb_substr(strip_tags($this->answer), 0, $trunkate);
            if (strlen($this->answer) > $trunkate)
                $answer_body .= "...";
            return $answer_body;
        }
        else
            return $this->answer;
    }

    public function comments() {
        return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('comments', 'core'));
    }

    public function getQuestion() {
        return Engine_Api::_()->getItem('question', $this->question_id);
    }

    public function getTitle() {
        return $this->getShortAnswer(100);
    }

    public function issetVotes() {
        return ($this->getVotes('+') or $this->getVotes('-'));
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

}