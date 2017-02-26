<?php
class Experience_Plugin_Core
{
  public function onStatistics($event)
  {
    $table  = Engine_Api::_()->getDbTable('experiences', 'experience');
    $select = new Zend_Db_Select($table->getAdapter());
    $select->from($table->info('name'), 'COUNT(*) AS count');
    $event->addResponse($select->query()->fetchColumn(0), 'experience');
  }

  public function onUserDeleteBefore($event)
  {
    $payload = $event->getPayload();
    if( $payload instanceof User_Model_User ) {
      // Delete experiences
      $experienceTable = Engine_Api::_()->getDbtable('experiences', 'experience');
      $experienceSelect = $experienceTable->select()->where('owner_id = ?', $payload->getIdentity());
      foreach( $experienceTable->fetchAll($experienceSelect) as $experience ) {
        $experience->delete();
      }
      // Delete subscriptions
      $subscriptionsTable = Engine_Api::_()->getDbtable('subscriptions', 'experience');
      $subscriptionsTable->delete(array(
        'user_id = ?' => $payload->getIdentity(),
      ));
      $subscriptionsTable->delete(array(
        'subscriber_user_id = ?' => $payload->getIdentity(),
      ));
    }
  }
}