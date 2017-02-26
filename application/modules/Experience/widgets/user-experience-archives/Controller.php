<?php
class Experience_Widget_UserExperienceArchivesController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
  {
    if(Engine_Api::_()->core()->hasSubject('user')){
      $user = Engine_Api::_()->core()->getSubject('user');
    }
    else if( Engine_Api::_()->core()->hasSubject('experience') ) {
      $experience = Engine_Api::_()->core()->getSubject('experience');
      $user = $experience->getOwner();
    }
    else {
          return $this->setNoRender();
    }
    $archiveList = Engine_Api::_()->experience()->getArchiveList($user->getIdentity());
    $this->view->archieve_list = $this->_handleArchiveList($archiveList);
  }

   protected function _handleArchiveList($results)
  {
    $localeObject = Zend_Registry::get('Locale');

    $experience_dates = array();
    foreach ($results as $result)
      $experience_dates[] = strtotime($result->creation_date);

    // GEN ARCHIVE LIST
    $time = time();
    $archive_list = array();

    foreach( $experience_dates as $experience_date )
    {
      $ltime = localtime($experience_date, TRUE);
      $ltime["tm_mon"] = $ltime["tm_mon"] + 1;
      $ltime["tm_year"] = $ltime["tm_year"] + 1900;

      // LESS THAN A YEAR AGO - MONTHS
      if( $experience_date+31536000>$time )
      {
        $date_start = mktime(0, 0, 0, $ltime["tm_mon"], 1, $ltime["tm_year"]);
        $date_end = mktime(0, 0, 0, $ltime["tm_mon"]+1, 1, $ltime["tm_year"]);
        //$label = date('F Y', $experience_date);
        $type = 'month';

        $dateObject = new Zend_Date($experience_date);
        $format = $localeObject->getTranslation('MMMMd', 'dateitem', $localeObject);
        $label = $dateObject->toString($format, $localeObject);
      }

      // MORE THAN A YEAR AGO - YEARS
      else
      {
        $date_start = mktime(0, 0, 0, 1, 1, $ltime["tm_year"]);
        $date_end = mktime(0, 0, 0, 1, 1, $ltime["tm_year"]+1);
        //$label = date('Y', $experience_date);
        $type = 'year';

        $dateObject = new Zend_Date($experience_date);
        $format = $localeObject->getTranslation('yyyy', 'dateitem', $localeObject);
        if( !$format ) {
          $format = $localeObject->getTranslation('y', 'dateitem', $localeObject);
        }
        $label = $dateObject->toString($format, $localeObject);
      }

      if( !isset($archive_list[$date_start]) )
      {
        $archive_list[$date_start] = array(
          'type' => $type,
          'label' => $label,
          'date_start' => $date_start,
          'date_end' => $date_end,
          'count' => 1
        );
      }
      else
      {
        $archive_list[$date_start]['count']++;
      }
    }

    return $archive_list;
  }
}