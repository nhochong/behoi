<?php

class Question_Installer extends Engine_Package_Installer_Module
{
    public function onInstall() {die('xx');
        parent::onInstall();
        $this->_addBrowsePage();
        $this->_addManagePage();
        $this->_addRatingsPage();
        $this->_addAskPage();
        $this->_addViewPage();
        $this->_addEditPage();
        $this->_addAnswersPage();
        $this->_addUnansweredPage();
    }

    private function _getStructure(array $option) {
        $db     = $this->getDb();
        $db->insert('engine4_core_pages', $option);
        $page_id = $db->lastInsertId('engine4_core_pages');

          // Insert top
        $db->insert('engine4_core_content', array(
            'type' => 'container',
            'name' => 'top',
            'page_id' => $page_id,
            'order' => 1
          ));
        $top_id = $db->lastInsertId();

          // Insert main
        $db->insert('engine4_core_content', array(
            'page_id' => $page_id,
            'type' => 'container',
            'name' => 'main',
            'order' => 2
          ));
        $main_id = $db->lastInsertId('engine4_core_content');

        // Insert top-middle
        $db->insert('engine4_core_content', array(
            'type' => 'container',
            'name' => 'middle',
            'page_id' => $page_id,
            'parent_content_id' => $top_id,
          ));
        $top_middle_id = $db->lastInsertId();

        // Insert main-middle
        $db->insert('engine4_core_content', array(
            'type' => 'container',
            'name' => 'middle',
            'page_id' => $page_id,
            'parent_content_id' => $main_id,
            'order' => 2,
          ));
        $main_middle_id = $db->lastInsertId();

        // Insert main-right
        $db->insert('engine4_core_content', array(
            'type' => 'container',
            'name' => 'right',
            'page_id' => $page_id,
            'parent_content_id' => $main_id,
            'order' => 1
          ));
        $main_right_id = $db->lastInsertId();

        // Insert menu
        $db->insert('engine4_core_content', array(
            'type' => 'widget',
            'name' => 'question.browse-menu',
            'page_id' => $page_id,
            'parent_content_id' => $top_middle_id,
            'order' => 1
        ));

        // middle column
        $db->insert('engine4_core_content', array(
            'page_id' => $page_id,
            'type' => 'widget',
            'name' => 'core.content',
            'parent_content_id' => $main_middle_id,
            'order' => 1
        ));

        return array('page_id' => $page_id,
                     'top_id' => $top_id,
                     'main_id' => $main_id,
                     'top_middle_id' => $top_middle_id,
                     'main_middle_id' => $main_middle_id,
                     'main_right_id' => $main_right_id);
    }

    private function _pageEmpty($name) {
        $db     = $this->getDb();
        $select = new Zend_Db_Select($db);
        $select
          ->from('engine4_core_pages')
          ->where('name = ?', $name)
          ->limit(1);
          ;
        $info = $select->query()->fetch();
        return empty($info);
    }

    private function _addBrowsePage() {
        $db     = $this->getDb();
        if( version_compare('4.1.8p2', $this->_currentVersion, '>') ) {
            $file = APPLICATION_PATH . '/application/settings/database.php';
            $options = include $file;
            Engine_Db_Table::setTablePrefix($options['tablePrefix']);
            Engine_Loader::getInstance()->register('Core', APPLICATION_PATH . '/application/modules/Core');
            $tablePage = Engine_Api::_()->getDbtable('pages', 'core');
            $PageRow = $tablePage->fetchRow(array('name = ?' => 'question_index_index'));
            if ($PageRow != null and $PageRow->displayname != 'Q&A: Browse Page') {
                $tablePage->deletePage($PageRow);
            }
        }
        if( $this->_pageEmpty('question_index_index') ) {
            $structure = $this->_getStructure(array('name' => 'question_index_index',
                                                    'displayname' => 'Q&A: Browse Page',
                                                    'title' => 'Q&A: Browse Page',
                                                    'description' => 'Show all Questions on your site.',
                                                    'custom' => 0));
            // Add widget 'Q&A Browse Search'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.browse-search',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 2
                                                      ));
            // Add widget 'Ask a Question'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.ask-question',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 3
                                                      ));
        }

    }

    private function _addManagePage() {

        if($this->_pageEmpty('question_index_manage')) {
            $db     = $this->getDb();
            $structure = $this->_getStructure(array('name' => 'question_index_manage',
                                                    'displayname' => 'Q&A: Manage Questions',
                                                    'title' => 'Q&A: Manage Questions',
                                                    'description' => 'Show members of theirs questions.',
                                                    'custom' => 0));
            // Add widget 'Q&A Browse Search'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.browse-search',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 2
                                                      ));
            // Add widget 'Ask a Question'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.ask-question',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 3
                                                      ));

        }

    }

    private function _addRatingsPage() {

        if($this->_pageEmpty('question_index_rating')) {
            $db     = $this->getDb();
            $structure = $this->_getStructure(array('name' => 'question_index_rating',
                                                    'displayname' => 'Q&A: Ratings',
                                                    'title' => 'Q&A: Ratings',
                                                    'description' => 'Show members ratings.',
                                                    'custom' => 0));
            // Add widget 'Rating User Search'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.rating-user-search',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
            // Add widget 'Update Ratings'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.update-ratings',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 2
                                                      ));
        }

    }

    private function _addAskPage() {

        if($this->_pageEmpty('question_index_create')) {
            $db     = $this->getDb();
            $structure = $this->_getStructure(array('name' => 'question_index_create',
                                                    'displayname' => 'Q&A: Ask a Question',
                                                    'title' => 'Q&A: Ask a Question',
                                                    'description' => 'Show page for ask a Question.',
                                                    'custom' => 0));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
        }

    }

    private function _addViewPage() {

        if($this->_pageEmpty('question_index_view')) {
            $db     = $this->getDb();
            $structure = $this->_getStructure(array('name' => 'question_index_view',
                                                    'displayname' => 'Q&A: View a Question',
                                                    'title' => 'Q&A: View a Question',
                                                    'description' => 'Show page view a Question.',
                                                    'custom' => 0));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
        }

    }

    private function _addEditPage() {

        if($this->_pageEmpty('question_index_edit')) {
            $db     = $this->getDb();
            $structure = $this->_getStructure(array('name' => 'question_index_edit',
                                                    'displayname' => 'Q&A: Edit a Question',
                                                    'title' => 'Q&A: Edit a Question',
                                                    'description' => 'Show page for edit a Question.',
                                                    'custom' => 0));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
        }

    }

    private function _addAnswersPage() {

        if($this->_pageEmpty('question_index_answers')) {
            $db     = $this->getDb();
            $structure = $this->_getStructure(array('name' => 'question_index_answers',
                                                    'displayname' => 'Q&A: User Answers',
                                                    'title' => 'Q&A: User Answers',
                                                    'description' => 'Show user answers.',
                                                    'custom' => 0));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
        }

    }
    
    private function _addUnansweredPage() {
        $db     = $this->getDb();

        if( $this->_pageEmpty('question_index_unanswered') ) {
            $structure = $this->_getStructure(array('name' => 'question_index_unanswered',
                                                    'displayname' => 'Q&A: Unanswered Questions',
                                                    'title' => 'Q&A: Unanswered Questions',
                                                    'description' => 'Show only unanswered questions.',
                                                    'custom' => 0));
            // Add widget 'Q&A Browse Search'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.browse-search',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 1
                                                      ));
            // Add widget 'How do I collect points?'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.how-collect-points',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 2
                                                      ));
            // Add widget 'Ask a Question'
            $db->insert('engine4_core_content', array('page_id' => $structure['page_id'],
                                                      'type' => 'widget',
                                                      'name' => 'question.ask-question',
                                                      'parent_content_id' => $structure['main_right_id'],
                                                      'order' => 3
                                                      ));
        }

    }
}
?>