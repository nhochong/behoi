<?php

class Question_Form_Create extends Engine_Form {

    public function init() {
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $this
                ->setTitle(Zend_Registry::get('Zend_Translate')->_("Ask a Question"))
                ->setDescription(Zend_Registry::get('Zend_Translate')->_("What do you want to know?"))
                ->setAttrib('enctype', 'multipart/form-data')
                ->setAttrib('id', 'form-upload');
        $user = Engine_Api::_()->user()->getViewer();
        $this->addElement('Text', 'title', array(
            'label' => Zend_Registry::get('Zend_Translate')->_("Title"),
            'maxlength' => 100,
            'allowEmpty' => true,
            'required' => false,
            'filters' => array('StringTrim', 'StripTags', new Engine_Filter_Censor(), new Engine_Filter_StringLength(array('max' => '100'))),
        ));
        $this->title->getDecorator("Description")->setOption("placement", "append");
        $theme_buttons = array('link', 'unlink', '|', 'bold', 'italic', 'underline', '|', 'pastetext', '|', 'media');
        if (Engine_Api::_()->question()->isAdmin(Engine_Api::_()->user()->getViewer())) {
            $theme_buttons[] = '|';
            $theme_buttons[] = 'code';
        }

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

        $this->addElement('TinyMce', 'question', array(
            'label' => Zend_Registry::get('Zend_Translate')->_("Question"),
            'required' => true,
            'allowEmpty' => false,
            'class' => "mceEditor",
            'editorOptions' => array_merge(array('mode' => "specific_textareas",
                'editor_selector' => "mceEditor",
                'extended_valid_elements' => 'a[href|rel=nofollow]',
                'dialog_type' => "modal",
                'content_css' => Zend_Registry::get('StaticBaseUrl') . 'application/modules/Question/externals/styles/customTinyMce.css'
                    ), $editorOptions),
            'filters' => array(new Engine_Filter_Censor(),
                new Zend_Filter_StripNewlines(),
                new Zend_Filter_PregReplace('/(<p>&nbsp;<\/p>)*$/', ''))
        ));
        if ($settings->getSetting('question_category', 1)) {
            $this->addElement('Select', 'category_id', array(
                'label' => Zend_Registry::get('Zend_Translate')->_("Category"),
                'required' => true,
                'allowEmpty' => false,
                'multiOptions' => array(
                    '' => Zend_Registry::get('Zend_Translate')->_('Select Category')
                )
            ));
            $categories = Engine_Api::_()->question()->getCategories();
            foreach ($categories as $category) {
                $this->category_id->addMultiOption($category->category_id, $category->category_name);
            }
        }
        if ($settings->getSetting('question_tags', 0)) {
            $this->addElement('Text', 'whtags', array(
                'label' => Zend_Registry::get('Zend_Translate')->_('Tags'),
                'autocomplete' => 'off',
                'description' => Zend_Registry::get('Zend_Translate')->_('Separate tags with commas.'),
                'allowEmpty' => true,
                'filters' => array('StringTrim', new Engine_Filter_Censor()),
            ));
            $this->whtags->getDecorator('Description')->setOption('placement', 'append');
        }
        if (Engine_Api::_()->authorization()->isAllowed('question', null, 'max_files')) {
            $this->addElement('FancyUpload', 'file');
            $this->file->clearDecorators()
                    ->addDecorator('viewScript', array(
                        'viewScript' => '_FancyUpload.tpl',
                        'placement' => ''
            ));
            $this->file->getDecorator('viewScript')->setOption('data', array('max_files' => unserialize(Engine_Api::_()->authorization()->getPermission(Engine_Api::_()->user()->getViewer()->level_id, 'question', 'max_files'))));
        }



        $availableLabels = array(
            'everyone' => 'Everyone',
            'registered' => 'All Registered Members',
            'owner_network' => 'Friends and Networks',
            'owner_member_member' => 'Friends of Friends',
            'owner_member' => 'Friends Only',
            'owner' => 'Just Me'
        );

        // Element: auth_view
        $viewOptions = (array) unserialize(Engine_Api::_()->authorization()->getPermission($user->level_id, 'question', 'auth_view'));
        $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));

        if (!empty($viewOptions) && count($viewOptions) >= 1) {
            // Make a hidden field
            if (count($viewOptions) == 1) {
                $this->addElement('hidden', 'auth_view', array('value' => key($viewOptions)));
                // Make select box
            } else {
                $this->addElement('Select', 'auth_view', array(
                    'label' => 'Privacy View',
                    'description' => 'Who may see this question entry?',
                    'multiOptions' => $viewOptions,
                    'value' => key($viewOptions),
                ));
                $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
            }
        }

        // Element: auth_answer
        $viewOptions = (array) unserialize(Engine_Api::_()->authorization()->getPermission($user->level_id, 'question', 'auth_answer'));
        unset($availableLabels['everyone']);
        $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));

        if (!empty($viewOptions) && count($viewOptions) >= 1) {
            // Make a hidden field
            if (count($viewOptions) == 1) {
                $this->addElement('hidden', 'auth_answer', array('value' => key($viewOptions)));
                // Make select box
            } else {
                $this->addElement('Select', 'auth_answer', array(
                    'label' => 'Privacy Answer',
                    'description' => 'Who may answer to this question entry?',
                    'multiOptions' => $viewOptions,
                    'value' => key($viewOptions),
                ));
                $this->auth_answer->getDecorator('Description')->setOption('placement', 'append');
            }
        }

        // Element: question_anonymous

        if ($settings->getSetting('question_anonymous', 0)) {
            $this->addElement('Checkbox', 'anonymous', array(
                'label' => 'Post anonymous',
                'disableLoadDefaultDecorators' => true,
                'value' => 0
            ));
            $this->anonymous->addDecorator('ViewHelper')
                    ->addDecorator('Label', array('placement' => Zend_Form_Decorator_Abstract::APPEND))
                    ->addDecorator('Description', array('tag' => 'p', 'class' => 'description', 'placement' => 'PREPEND'))
                    ->addDecorator('HtmlTag', array('tag' => 'div', 'id' => 'anonymous-element', 'class' => 'form-element'))
                    ->addDecorator(array('indent' => 'HtmlTag'), array('tag' => 'div', 'class' => 'form-label', 'id' => 'anonymous-label', 'placement' => Zend_Form_Decorator_Abstract::PREPEND))
                    ->addDecorator('HtmlTag2', array('tag' => 'div', 'id' => 'anonymous-wrapper', 'class' => 'form-wrapper'));
            $script = <<<EOF
            function wh_anonymous_hide(input) {
                    $('auth_view-wrapper').setStyle('display', (input.checked) ? 'none' : '');
                    $('auth_answer-wrapper').setStyle('display', (input.checked) ? 'none' : '');
                    if (input.checked) {
                        $('auth_answer').set('value', 'registered');
                        $('auth_view').set('value', 'everyone');
                    }
            }
            window.addEvent("domready", function() {
                try {
                wh_anonymous_hide($('anonymous'));
                $('anonymous').addEvent('change', function (event) {
                                                                        wh_anonymous_hide(event.target);
                });
                }
                catch(e){}
            });
EOF;
            $this->getView()->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());
        }
        $this->addElement('Checkbox', 'search', array(
            'label' => 'Show this question entry in search results',
            'value' => 1,
        ));



        $this->addElement('Button', 'submit', array(
            'label' => Zend_Registry::get('Zend_Translate')->_('Submit Question'),
            'type' => 'submit',
            'decorators' => array('ViewHelper')
        ));
    }

    public function add_cancel($question_id) {
        $tmp = $this->getView()->url(array('route' => 'question_view', 'question_id' => (int) $question_id), 'default');
        $this->addElement('Cancel', 'cancel', array(
            'label' => Zend_Registry::get('Zend_Translate')->_("return to question"),
            'link' => true,
            'prependText' => ' or ',
            'href' => $this->getView()->url(array('question_id' => (int) $question_id, 'action' => 'view', 'controller' => 'index', 'module' => 'question'), 'default'),
            'decorators' => array(
                'ViewHelper'
            )
        ));
    }

    public function populate(array $values) {
        if (array_key_exists('question_id', $values))
            $this->add_cancel($values['question_id']);
        parent::populate($values);
    }

    public function isValid($values) {
        if (isset($values['files']) and is_array($values['files']) and count($values['files'])) {
            $this->setFiles($values['files']);
        }
        return parent::isValid($values);
    }

    public function setFiles($files) {
        if (is_array($files) and count($files) and Engine_Api::_()->authorization()->isAllowed('question', null, 'max_files')) {
            $this->getElement('file')->getDecorator('viewScript')->setOption('data', array('files' => $files,
                'max_files' => unserialize(Engine_Api::_()->authorization()->getPermission(Engine_Api::_()->user()->getViewer()->level_id, 'question', 'max_files'))));
        }
    }

}
