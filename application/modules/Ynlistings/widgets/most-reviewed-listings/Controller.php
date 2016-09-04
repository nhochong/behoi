<?php

class Ynlistings_Widget_MostReviewedListingsController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        $num_of_listings = $this->_getParam('num_of_listings', 3);
        $listingTable = Engine_Api::_()->getItemTable('ynlistings_listing');
        $listingTblName = $listingTable->info('name');
        $reviewTable = Engine_Api::_()->getItemTable('ynlistings_review');
        $reviewTblName = $reviewTable->info('name');
        if (Engine_Api::_()->hasModuleBootstrap('ynlocationbased')) {
            $select = Engine_Api::_()->ynlocationbased()->getLocationBasedSelect('ynlistings', 'listings', array("COUNT($reviewTblName.review_id) as review_count"));
        }
        else {
            $select = $listingTable->select()->from("$listingTblName", array("$listingTblName.*", "COUNT($reviewTblName.review_id) as review_count"));
        }
        $select
            ->joinLeft("$reviewTblName", "$reviewTblName.listing_id = $listingTblName.listing_id", "")
            ->where("$listingTblName.search = ?", 1)
            ->where("$listingTblName.status = ?", "open")
            ->where("$listingTblName.approved_status = ?", "approved")
            ->group("$listingTblName.listing_id")->order("COUNT($reviewTblName.review_id) DESC")->limit($num_of_listings);
        $this->view->listings = $listings = $listingTable->fetchAll($select);
        if (count($listings) == 0) {
            $this->setNoRender(true);
        }
    }
}
