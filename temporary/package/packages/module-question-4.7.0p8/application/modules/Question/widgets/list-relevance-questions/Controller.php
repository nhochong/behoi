<?php

class Question_Widget_ListRelevanceQuestionsController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $table = Engine_Api::_()->getItemTable('question');
        $rName = $table->info('name');
        $select = Engine_Api::_()->question()->getQuestionSelect();
        $select->where($rName . '.creation_date > ?', new Zend_Db_Expr('DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)'));
        $select_table = $table->select();

        $select_table = $table->select()->setIntegrityCheck(false)->from(array('tmp' => $select), array('tmp.*', 'relevance' => new Zend_Db_Expr("((SUM(IF(`engine4_question_qvotes`.`vote_for`,`engine4_question_qvotes`.`vote_for`, 0)) - SUM(IF(`engine4_question_qvotes`.`vote_against`,`engine4_question_qvotes`.`vote_against`,0))) - (to_days(CURRENT_DATE) - to_days(tmp.`creation_date`)) + tmp.`count_answers`)")))
                ->joinLeftUsing('engine4_question_qvotes', 'question_id', array())
                ->order('relevance DESC')
                ->group("tmp.question_id")
                ->limit($this->_getParam('per_page', 5));
        $tmp = $select_table->__toString();
        $paginator = $table->fetchAll($select_table);

        if ($paginator->count() <= 0) {
            return $this->setNoRender();
        }
        $this->view->isEnabledCategories = $isEnabledCategories = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1);
        if ($isEnabledCategories)
            $this->view->categories = Engine_Api::_()->question()->getCategories();
        $this->view->paginator = $paginator;
        $this->view->hours_new_label = time() - (((int) $this->_getParam('hours_new_label', 24)) * 3600);
    }

    public function getCacheKey() {
        return Zend_Registry::get('Locale')->toString();
    }

    public function getCacheSpecificLifetime() {
        return 240;
    }

}