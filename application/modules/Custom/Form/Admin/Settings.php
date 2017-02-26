<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: General.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Custom_Form_Admin_Settings extends Engine_Form
{
  public function init()
  {
	// Decorators
    $this->loadDefaultDecorators();
	
    // Set form attributes
    $this->setTitle('Settings');

	$editorOptions = array(
        'html' => (bool) true,
        'forced_root_block' => false,
        'force_p_newlines' => false,
        'plugins' => array(
            'table', 'fullscreen', 'preview', 'paste',
            'code', 'image', 'textcolor', 'link'
        ),
        'toolbar1' => array(
            'undo', 'redo', 'removeformat', 'pastetext', '|', 'code',
            'image', 'link', 'fullscreen',
            'preview'
    ));
	
    $this->addElement('Tinymce', 'about_us', array(
      'label' => 'About us',
	  'editorOptions' => $editorOptions,
    ));
    
    // init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
}