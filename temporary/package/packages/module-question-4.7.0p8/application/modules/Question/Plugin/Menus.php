<?php

class Question_Plugin_Menus {

    public function canCreateQuestions() {
        // Must be logged in
        $viewer = Engine_Api::_()->user()->getViewer();
        if (!$viewer || !$viewer->getIdentity()) {
            return false;
        }

        // Must be able to create questions
        if (!Engine_Api::_()->authorization()->isAllowed('question', $viewer, 'create')) {
            return false;
        }

        return true;
    }

    public function canViewQuestions() {
        $viewer = Engine_Api::_()->user()->getViewer();

        // Must be able to view questions
        if (!Engine_Api::_()->authorization()->isAllowed('question', $viewer, 'view')) {
            return false;
        }

        return true;
    }

}