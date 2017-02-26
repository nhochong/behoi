<?php
class Experience_Form_Edit extends Experience_Form_Create
{
/*----- Init Form Function -----*/
  public function init()
  {
    parent::init();
    $this->setTitle('Edit Experience Entry')
      ->setDescription('Edit your entry below, then click "Post Entry" to publish the entry on your experience.');
    $this->submit->setLabel('Save Changes');
    $captcha = Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.captcha',0);
    if($captcha){
      $this->removeElement('captcha');
    }
  }
}