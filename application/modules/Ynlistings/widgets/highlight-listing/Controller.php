<?php

class Ynlistings_Widget_HighlightListingController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        $table = Engine_Api::_()->getItemTable('ynlistings_listing');
        $tableName = $table -> info('name');
        if (Engine_Api::_()->hasModuleBootstrap('ynlocationbased')) {
            $select = Engine_Api::_()->ynlocationbased()->getLocationBasedSelect('ynlistings', 'listings');
        }
        else {
            $select = $table->select()->from("$tableName", array("$tableName.*"));
        }
        $hightlight_listing = $table->fetchRow($select
            ->where('highlight = ?', 1)
            ->where('status = ?', 'open')
            ->where('approved_status = ?', 'approved') -> limit(1));
        if ($hightlight_listing) {
            $this->view->listing = $hightlight_listing;
        } else {
            $this->setNoRender();
        }
    }
}
