<?php

class Ynlistings_Widget_FeaturedListingsController extends Engine_Content_Widget_Abstract
{

    public function indexAction()
    {
        $table = Engine_Api::_()->getItemTable('ynlistings_listing');
        $num_of_listings = $this->_getParam('num_of_listings', 6);
        $tableName = $table -> info('name');
        if (Engine_Api::_()->hasModuleBootstrap('ynlocationbased')) {
            $select = Engine_Api::_()->ynlocationbased()->getLocationBasedSelect('ynlistings', 'listings');
        }
        else
        {
            $select = $table->select()->from("$tableName", array("$tableName.*"));
        }
        $select
            ->where('featured = ?', 1)
            ->where('status = ?', 'open')
            ->where('approved_status = ?', 'approved')
            ->order('rand()')
            ->limit($num_of_listings);
        $this->view->listings = $listings = $table->fetchAll($select);
        if (count($listings) == 0) {
            $this->setNoRender(true);
        }

    }
}