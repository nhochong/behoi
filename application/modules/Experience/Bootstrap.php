<?php
class Experience_Bootstrap extends Engine_Application_Bootstrap_Abstract {
    public function _initABC() {
        // add mode view action
        $headScript = new Zend_View_Helper_HeadScript();
        $headScript->appendFile(Zend_Registry::get('StaticBaseUrl') . 'application/modules/Experience/externals/scripts/ynblog-viewmode-actions.js');
    }
}