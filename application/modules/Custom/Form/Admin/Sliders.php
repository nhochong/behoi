<?php
class Custom_Form_Admin_Sliders extends Engine_Form
{
	public function init()
  {
     $this
      ->setTitle('Slider Settings')
      ->setDescription('The settings Slider.');
     
    //Title
      $this->addElement('Text', 'title',array(
      'label'=>'Title',
     // 'allowEmpty' => false,
      'description' => '',
      'required' => false,
      'filters' => array(
        new Engine_Filter_Censor(),
      ),
    ));
    
    //Description   
       $this->addElement('textarea', 'description',array(
      'label'=>'Description',
      'description' => '',
      //'required' => true,
      //'allowEmpty' => false,
      'filters' => array(
        new Engine_Filter_Censor(),
      ),
    ));

    $this->addElement('File', 'photo', array(
      'label' => 'Slider Photo',
    ));
    $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');
    
     $this->addElement('Text', 'links_url',array(
      'label'=>'Links',
      //'allowEmpty' => false,
      'description' => '',
      //'required' => true,
      'filters' => array(
        new Engine_Filter_Censor(),
      ),
    ));
  
    $this->addElement('button', 'submit', array(
      'label' => 'Submit',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
      ));
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'onClick'=> 'javascript:parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      )
    ));
    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
    $button_group = $this->getDisplayGroup('buttons');
}
}