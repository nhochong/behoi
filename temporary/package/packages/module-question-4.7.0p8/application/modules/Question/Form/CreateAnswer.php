<?php

class Question_Form_CreateAnswer extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle(Zend_Registry::get('Zend_Translate')->_('Your Answer:'))
      ->setAttrib('enctype', 'multipart/form-data');

    $theme_buttons = array('link', 'unlink', '|', 'bold', 'italic', 'underline', '|','pastetext', '|', 'media', 'image');
    if (Engine_Api::_()->question()->isAdmin(Engine_Api::_()->user()->getViewer())) {
        $theme_buttons[] = '|';
        $theme_buttons[] = 'code';
    }
    $baseUrl = Zend_Registry::get('StaticBaseUrl');

    $manifest = Zend_Registry::get('Engine_Manifest');
    if (version_compare($manifest['core']['package']['version'], '4.7.0', '<'))
      $editorOptions = array(
      'plugins' => array('media', 'paste', 'inlinepopups'),
      'theme_advanced_buttons1' => $theme_buttons
      );
    else
      $editorOptions = array(
      'plugins' => array('link', 'media', 'paste', 'code'),
      'toolbar1' => $theme_buttons,
      );
    $this->addElement('TinyMce', 'answer', array(
                                                  'label' => 'Answer',
                                                  'required' => true,
                                                  'allowEmpty' => false,
                                                  'class' => "mceEditor",
                                                  'editorOptions' => array_merge(array('mode' => "specific_textareas",
                                                                           'editor_selector' => "mceEditor",
                                                                           'extended_valid_elements' => 'a[href|rel=nofollow]',
                                                                           'dialog_type' => "modal",
                                                                           'content_css' => Zend_Registry::get('StaticBaseUrl').'application/modules/Question/externals/styles/customTinyMce.css'), $editorOptions),
                                                  'filters' => array( new Engine_Filter_Censor(),
                                                                      new Zend_Filter_StripNewlines(),
                                                                      new Zend_Filter_PregReplace('/(<p>&nbsp;<\/p>)*$/', ''))
                                                ));
    $this->answer->removeDecorator('label');   
    
    if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_anonymous', 0)) {
        $this->addElement('Checkbox', 'anonymous', array(
            'label' => 'post anonymously',
            'description' => 'Your username will be hidden automatically.',
            'disableLoadDefaultDecorators' => true,
            'value' => 0
        ));
        $this->anonymous->addDecorator('ViewHelper')
             ->addDecorator('Label', array('placement' => Zend_Form_Decorator_Abstract::APPEND))   
             ->addDecorator('Description', array('tag' => 'p', 'class' => 'description', 'placement' => 'PREPEND'))             
             ->addDecorator('HtmlTag', array('tag' => 'div', 'id'  => 'anonymous-element', 'class' => 'form-element'))
             ->addDecorator('HtmlTag2', array('tag' => 'div', 'id'  => 'anonymous-wrapper', 'class' => 'form-wrapper'));
    }
    $this->addElement('Button', 'submit', array(
      'label' => Zend_Registry::get('Zend_Translate')->_('Submit Answer'),
      'type' => 'submit',
    ));
  }

  public function add_cancel($question_id) {
      $tmp = $this->getView()->url(array('route' => 'question_view', 'question_id' => (int)$question_id), 'default');
      $this->addElement('Cancel', 'cancel', array(
      'label' => Zend_Registry::get('Zend_Translate')->_("cancel"),
      'link' => true,
      'prependText' => ' or ',
      'href' => 'javascript:void(0);',
      'onclick' => 'javascript:parent.Smoothbox.close()',
      'decorators' => array(
        'ViewHelper'
      )
    ));
    return $this;
  }
}
