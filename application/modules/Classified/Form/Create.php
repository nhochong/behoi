<?php

/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Create.php 9802 2012-10-20 16:56:13Z pamela $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Classified_Form_Create extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Post New Listing')
      ->setDescription('Compose your new classified listing below, then click "Post Listing" to publish the listing.')
      ->setAttrib('name', 'classifieds_create');

    $this->addElement('Text', 'title', array(
      'label' => 'Listing Title',
      'allowEmpty' => false,
      'required' => true,
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
        new Engine_Filter_StringLength(array('max' => '63')),
      ),
    ));

    $user = Engine_Api::_()->user()->getViewer();
    $user_level = Engine_Api::_()->user()->getViewer()->level_id;

    // init to
    $this->addElement('Text', 'tags', array(
      'label' => 'Tags (Keywords)',
      'autocomplete' => 'off',
      'description' => 'Separate tags with commas.',
      'filters' => array(
        new Engine_Filter_Censor(),
        new Engine_Filter_HtmlSpecialChars(),
      ),
    ));
    $this->tags->getDecorator("Description")->setOption("placement", "append");

    // prepare categories
    $categories = Engine_Api::_()->getDbtable('categories', 'classified')->getCategoriesAssoc();
    if( count($categories) > 0 ) {
      $this->addElement('Multiselect', 'category_id', array(
        'label' => 'Category',
		'allowEmpty' => false,
		'required' => true,
        'multiOptions' => $categories,
		'attribs' => array(
			'class' => 'chosen-select',
			'multiple' => 'chosen',
		)
      ));
    }

    // Element: upload photo
    $allowed_upload = Engine_Api::_()->authorization()->getPermission($user_level, 'classified', 'photo');
    if( $allowed_upload ) {
      $this->addElement('File', 'photo', array(
        'label' => 'Main Photo'
      ));
      $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');
    }
	
    // Element: description
	$upload_url = Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'upload-photo'), 'classified_general', true);
    $this->addElement('TinyMce', 'body', array(
      'label' => 'Description',
      'disableLoadDefaultDecorators' => true,
      'required' => true,
      'allowEmpty' => false,
      'decorators' => array(
        'ViewHelper'
      ),
      'editorOptions' => array(
          'bbcode' => 1,
          'html'   => 1,
          'theme_advanced_buttons1' => array(
              'undo', 'redo', 'cleanup', 'removeformat', 'pasteword',  '|',
              'media', 'image','link', 'unlink', 'fullscreen', 'preview', 'emotions', 'code',
          ),
          'theme_advanced_buttons2' => array(
              'fontselect', 'fontsizeselect', 'bold', 'italic', 'underline',
              'strikethrough', 'forecolor', 'backcolor', '|', 'justifyleft',
              'justifycenter', 'justifyright', 'justifyfull', '|', 'outdent', 'indent', 'blockquote',
          ),
          'plugins' => array(
		   		'table', 'fullscreen', 'media', 'preview', 'paste',
		   		'code', 'image', 'textcolor', 'jbimages','link', 'emoticons'
		  ),
   		  
	      'toolbar1' => array(
		      'undo', '|', 'redo', '|', 'removeformat', '|', 'pastetext', '|', 'code', '|', 'media', '|', 
		      'image', '|', 'link', '|', 'jbimages', '|', 'fullscreen', '|', 'preview',  'emoticons'
		    ),         
          'upload_url' => $upload_url,
      ),
    ));

	// Element: Exploration
    $allowed_html = Engine_Api::_()->authorization()->getPermission($user_level, 'blog', 'auth_html');
    $this->addElement('TinyMce', 'more_info', array(
      'label' => 'Exploration',
      'editorOptions' => array(
          'bbcode' => 1,
          'html'   => 1,
          'theme_advanced_buttons1' => array(
              'undo', 'redo', 'cleanup', 'removeformat', 'pasteword',  '|',
              'media', 'image','link', 'unlink', 'fullscreen', 'preview', 'emotions', 'code',
          ),
          'theme_advanced_buttons2' => array(
              'fontselect', 'fontsizeselect', 'bold', 'italic', 'underline',
              'strikethrough', 'forecolor', 'backcolor', '|', 'justifyleft',
              'justifycenter', 'justifyright', 'justifyfull', '|', 'outdent', 'indent', 'blockquote',
          ),
          'plugins' => array(
		   		'table', 'fullscreen', 'media', 'preview', 'paste',
		   		'code', 'image', 'textcolor', 'jbimages','link', 'emoticons'
		  ),
   		  
	      'toolbar1' => array(
		      'undo', '|', 'redo', '|', 'removeformat', '|', 'pastetext', '|', 'code', '|', 'media', '|', 
		      'image', '|', 'link', '|', 'jbimages', '|', 'fullscreen', '|', 'preview',  'emoticons'
		    ),         
          'upload_url' => $upload_url,
      ),
    ));	
	
	// Element: Source
    /*$this->addElement('TinyMce', 'sources', array(
      'label' => 'Sources & Links',
	  'editorOptions' => array(
          'bbcode' => 1,
          'html'   => 1,
          'theme_advanced_buttons1' => array(
              'undo', 'redo', 'cleanup', 'removeformat', 'pasteword',  '|',
              'media', 'image','link', 'unlink', 'fullscreen', 'preview', 'emotions', 'code',
          ),
          'theme_advanced_buttons2' => array(
              'fontselect', 'fontsizeselect', 'bold', 'italic', 'underline',
              'strikethrough', 'forecolor', 'backcolor', '|', 'justifyleft',
              'justifycenter', 'justifyright', 'justifyfull', '|', 'outdent', 'indent', 'blockquote',
          ),
          'plugins' => array(
		   		'table', 'fullscreen', 'media', 'preview', 'paste',
		   		'code', 'image', 'textcolor', 'jbimages','link', 'emoticons'
		  ),
   		  
	      'toolbar1' => array(
		      'undo', '|', 'redo', '|', 'removeformat', '|', 'pastetext', '|', 'code', '|', 'media', '|', 
		      'image', '|', 'link', '|', 'jbimages', '|', 'fullscreen', '|', 'preview',  'emoticons'
		    ),         
          'upload_url' => $upload_url,
      ),
    ));	*/  
    
    // Add subforms
    if( !$this->_item ) {
      $customFields = new Classified_Form_Custom_Fields();
    } else {
      $customFields = new Classified_Form_Custom_Fields(array(
        'item' => $this->getItem()
      ));
    }
    if( get_class($this) == 'Classified_Form_Create' ) {
      $customFields->setIsCreation(true);
    }

    $this->addSubForms(array(
      'fields' => $customFields
    ));

    // Privacy
    $availableLabels = array(
      'everyone'            => 'Everyone',
      'registered'          => 'All Registered Members',
      'owner_network'       => 'Friends and Networks',
      'owner_member_member' => 'Friends of Friends',
      'owner_member'        => 'Friends Only',
      'owner'               => 'Just Me',
    );

    // View
    $viewOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('classified', $user, 'auth_view');
    $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));

    if( !empty($viewOptions) && count($viewOptions) >= 1 ) {
      // Make a hidden field
      if(count($viewOptions) == 1) {
        $this->addElement('hidden', 'auth_view', array('value' => key($viewOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_view', array(
            'label' => 'Privacy',
            'description' => 'Who may see this classified listing?',
            'multiOptions' => $viewOptions,
            'value' => key($viewOptions),
        ));
        $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
      }
    }

    // Comment
    $commentOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('classified', $user, 'auth_comment');
    $commentOptions = array_intersect_key($availableLabels, array_flip($commentOptions));

    if( !empty($commentOptions) && count($commentOptions) >= 1 ) {
      // Make a hidden field
      if(count($commentOptions) == 1) {
        $this->addElement('hidden', 'auth_comment', array('value' => key($commentOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_comment', array(
            'label' => 'Comment Privacy',
            'description' => 'Who may post comments on this classified listing?',
            'multiOptions' => $commentOptions,
            'value' => key($commentOptions),
        ));
        $this->auth_comment->getDecorator('Description')->setOption('placement', 'append');
      }
    }
    
//    $this->addElement('Hash', 'token', array(
//      'salt' => 'classifieds-' . crc32(__FILE__)
//    ));



    // Element: execute
    $this->addElement('Button', 'execute', array(
      'label' => 'Post Listing',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    // Element: cancel
    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'href' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'manage'), 'classified_general', true),
      'onclick' => '',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    // DisplayGroup: buttons
    $this->addDisplayGroup(array(
      'execute',
      'cancel',
    ), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper'
      ),
    ));
  }

}