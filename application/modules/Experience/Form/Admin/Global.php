<?php
class Experience_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    // Form information
    $this->setTitle('Global Settings')
         ->setDescription('These settings affect all members in your community.');

    // Experience moderation setting
     $this->addElement('Radio', 'experience_moderation', array(
      'label' => 'Experience Moderation',
      'description' => "If set up \"Yes\" admin must approve experiences before user can view it. Otherwise, the experiences are automatically approved.",
      'multiOptions' => array(
        1 => 'Yes, allow experience moderation mode.',
        0 => 'No, not allow experience moderation mode.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.moderation', 0),
    ));

     // Experience moderation setting
     $this->addElement('Radio', 'experience_captcha', array(
      'label' => 'Experience Captcha',
      'description' => "If set up \"Yes\" captcha will be added to create form to prevent spamming.",
      'multiOptions' => array(
        1 => 'Yes, add Captcha when creating a experience.',
        0 => 'No, do not add Captcha when creating a experience.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.captcha', 0),
    ));
    
    
    $this->addElement('Radio', 'experience_cron', array(
      'label' => 'Import Experience',
      'multiOptions' => array(
        1 => 'Yes, allow automatically import experience.',
        0 => 'No, do not allow automatically import experience.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.cron', 1),
    ));
    
    // Submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}