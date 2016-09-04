<?php

class Question_Model_DbTable_Ratings extends Engine_Db_Table {

    protected $_rowClass = 'Question_Model_Rating';

    public function update_user_ratings() {
        try {
            $this->_db->query("
                              TRUNCATE `engine4_question_ratings`;
                            ");
            $this->_db->query("
                              REPLACE INTO `engine4_question_ratings` (`total_questions`,`rating_id`)
                                  (SELECT COUNT(`question_id`) AS 'count_question', `user_id`
                                  FROM `engine4_question_questions`
                                  GROUP BY `user_id`);
                            ");

            $this->_db->query("
                              REPLACE INTO `engine4_question_ratings` (`total_questions`,`total_answers`,`rating_id`)
                                  (SELECT IF(`total_questions`,`total_questions`,0), COUNT(`answer_id`) AS 'count_answer', `engine4_question_answers`.`user_id`
                                  FROM `engine4_question_answers`
                                  LEFT JOIN `engine4_question_ratings`
                                  ON `engine4_question_ratings`.`rating_id` = `engine4_question_answers`.`user_id`
                                  GROUP BY `engine4_question_answers`.`user_id`);
                            ");
            $this->_db->query("
                              REPLACE INTO `engine4_question_ratings` (`total_answers`,`total_questions`,`total_best_answers`,`rating_id`)
                                  (SELECT IF(`total_answers`,`total_answers`,0), IF(`total_questions`,`total_questions`,0), COUNT(`answer_id`) AS 'count_best_answer', `user_id`
                                  FROM `engine4_question_answers`
                                  LEFT JOIN `engine4_question_ratings`
                                  ON `engine4_question_ratings`.`rating_id` = `engine4_question_answers`.`user_id`
                                  WHERE `answer_id` IN (SELECT `best_answer_id` FROM `engine4_question_questions`
                                                        WHERE `best_answer_id` IS NOT NULL )
                                  GROUP BY `engine4_question_answers`.`user_id`);
                            ");
            $setting_core = Engine_Api::_()->getApi('settings', 'core');
            $question_points_posted_question = $setting_core->getSetting('question_points_posted_question', 1);
            $question_points_posted_answer = $setting_core->getSetting('question_points_posted_answer', 1);
            $question_points_best_answer = $setting_core->getSetting('question_points_best_answer', 5);
            $question_points_thumb_up = $setting_core->getSetting('question_points_thumb_up', 0);
            $question_points_thumb_down = $setting_core->getSetting('question_points_thumb_down', 0);
            $this->_db->query("UPDATE `engine4_question_ratings`
                             SET `total_points` = `total_questions`*$question_points_posted_question + `total_answers`*$question_points_posted_answer + `total_best_answers`*$question_points_best_answer");
            $this->_db->query("SET @a := 0;");
            $this->_db->query("UPDATE engine4_question_ratings,
                             (SELECT SUM(vote_for)*$question_points_thumb_up AS vote_for, SUM(vote_against)*$question_points_thumb_down AS vote_against, engine4_question_answers.user_id FROM engine4_question_votes
                             LEFT JOIN engine4_question_answers
                             ON engine4_question_answers.answer_id = engine4_question_votes.answer_id
                             GROUP BY engine4_question_answers.user_id) AS tmp
                             SET total_points = IF ((@a:=(total_points + tmp.vote_for - tmp.vote_against)) >= 0,@a,0)
                             WHERE engine4_question_ratings.rating_id = tmp.user_id");
            $this->_db->query("SET @a := 0;");
            $this->_db->query("UPDATE engine4_question_ratings,
                             (SELECT SUM(vote_for)*$question_points_thumb_up AS vote_for, SUM(vote_against)*$question_points_thumb_down AS vote_against, engine4_question_questions.user_id FROM engine4_question_qvotes
                             LEFT JOIN engine4_question_questions
                             ON engine4_question_questions.question_id = engine4_question_qvotes.question_id
                             GROUP BY engine4_question_questions.user_id) AS tmp
                             SET total_points = IF ((@a:=(total_points + tmp.vote_for - tmp.vote_against)) >= 0,@a,0)
                             WHERE engine4_question_ratings.rating_id = tmp.user_id");
        } catch (Exception $e) {
            return false;
        }
        return true;
    }

    public function getUserRatingPlace(User_Model_User $user) {
        $rName = $this->info('name');
        $select = $this->select()->from($rName, array('*', 'rownum' => new Zend_Db_Expr('@rownum:=@rownum+1')))
                ->order('total_points DESC');
        $second_select = $this->select()->setIntegrityCheck(false)
                ->from(array('tmp' => $select))
                ->where('rating_id = ?', $user->getIdentity());
        $this->_db->query("SET @rownum:=0;");
        $row = $this->fetchRow($second_select);

        if ($row !== null)
            return $row->rownum;
        else {
            return false;
        }
    }

    public function fetchAll($where = null, $order = null, $count = null, $offset = null) {
        $this->_db->query("SET @rownum:=0;");
        return parent::fetchAll($where, $order, $count, $offset);
    }

}