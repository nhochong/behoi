<?php
class Ultimatenews_Form_CreateFeed extends Engine_Form
{
    
  public function init()
  {
	    $this->loadDefaultDecorators();
	    $this->getDecorator('Description')->setOptions(array('tag' => 'h4', 'placement' => 'PREPEND'));
	    
		$translate = Zend_Registry::get('Zend_Translate');
		
	    //init category name
	    $this->addElement('Text', 'category_name', array(
	    	'label' => 'Feed Name',
	    	'required' => true,
	    	'style' => 'width:300px;',
	    ));
        $this->addElement('Textarea', 'url_resource', array(
            'label' => 'Feed URL',
            'required' => true,
            'style' => 'width:300px; ',
        ));
		
		// init to
	    $this->addElement('Text', 'tags',array(
	      'label'=>'Tags (Keywords)',
	      'autocomplete' => 'off',
	      'description' => 'Separate tags with commas.',
	      'filters' => array(
	        new Engine_Filter_Censor(),
	      ),
	    ));
	    $this->tags->getDecorator("Description")->setOption("placement", "append");
		
	    $this->addElement('Text', 'category_logo', array(
            'label' => 'Logo of RSS Provider',
            'required' => false,
            'style' => 'width:300px;',
        ));
        
         $this->addElement('File', 'logo', array(
          'label' => 'Or Upload Logo From Your Computer(gif,png)',
        ));
		
        $cats = Engine_Api::_()->ultimatenews()->getAllCategoryparents(array('category_active' => 1));
        $catPerms    = array();
        $catPerms[0] = "Other";
        foreach( $cats as $cat )
        {
            $catPerms[$cat['category_id']] = $translate->translate($cat['category_name']);
        }
        $this->addElement('Select', 'category_parent_id', array(
	        'label'        => 'Category',
	        'style' => 'width:310px;',
	        'multiOptions' => $catPerms
        ));
        
        $this->addElement('Checkbox', 'is_active', array(
		      'label' => "Active RSS?",
		      'value' => 1,
		      'checked' => true,
		      ));
        
        $this->addElement('Checkbox', 'mini_logo', array(
          'label' => "Display Mini Logo?",
          'value' => 1,
          'checked' => true,
        )); 
       
	    $this->addElement('Checkbox', 'display_logo', array(
          'label' => "Display logo?",
          'value' => 1,
          'checked' => true,
        ));
	    
        $this->addElement('Radio', 'full_content', array(
	      'label' => 'Getting full feed content',
	      'description' => 'Enabling this option will get full news content in details',
	      'multiOptions' => array(
	        '1' => 'Yes, allow getting full news content',
	        '0' => 'No, only get the feed content',
	      ),
	      'value' => '1',
	      'onclick' => 'en4.Ultimatenews.isFullContent(this);',
	      'ignore' => false,
	    ));
	    
        $this->addElement('Text', 'characters', array(
	    	'label' => 'Number to display limited characters',
	    	'style' => 'width:300px;',
        	'value' => '0',
        	'description' => 'Set 0 for unlimited characters',
	    ));
	  	$this->characters->getDecorator('Description')->setOption('placement', 'append');
	    
	    // Init submit
		$this -> addElement('Button', 'submit', array(
			'label' => 'Save',
			'type' => 'submit',
			'decorators' => array( array(
					'ViewScript',
					array(
						'viewScript' => '_formButtonCancel.tpl',
						'class' => 'form element'
					)
				)),
		));
  	
  }
  
}
