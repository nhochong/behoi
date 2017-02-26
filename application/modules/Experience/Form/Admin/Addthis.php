<?php
class Experience_Form_Admin_Addthis extends Engine_Form
{
  public function init()
  {
    
    $this
      ->setTitle('AddThis Settings')
      ->setDescription('These settings affect all members in your community.');
    $this->addElement('Text', 'experience_username', array(
      'label' => 'Username',
      'description' => 'Insert your Addthis account username',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.username'),
    ));
 $this->addElement('Password', 'experience_password', array(
      'label' => 'Password',
      'description' => 'Insert your Addthis account password',
      'value' => Engine_Api::_()->getApi('settings', 'core')
                                ->getSetting('experience.password'),
    ));
    $this->addElement('Text', 'experience_pubid', array(
      'label' => 'Profile ID',
      'description' => '',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.pubid'),
    ));
    $this->addElement('Text', 'experience_domain', array(
      'label' => 'Domain',
      'description' => 'Insert your domain',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.domain'),
    ));
      $this->addElement('Select', 'experience_period', array(
      'label' => 'Period',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.period','day'),
      'multiOptions' => array(
        'day' => 'Day',
        'week' => 'Week',
        'month' => 'Month',
      )
    ));
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}