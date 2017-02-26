<?php

class Question_Form_Search extends Engine_Form {

    protected static $_instance;

    public static function getInstance() {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }
        return self::$_instance;
    }

    public function init() {
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $this
                ->setAttribs(array(
                    'id' => 'question_filter_form',
                    'class' => 'global_form_box',
                ))
                ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
                ->setMethod('get');
        ;

        $this->addElement('Text', 'search', array(
            'label' => Zend_Registry::get('Zend_Translate')->_('Search Questions'),
            'onchange' => 'this.form.submit();',
        ));

        $this->addElement('Select', 'orderby', array(
            'label' => Zend_Registry::get('Zend_Translate')->_('Browse By'),
            'multiOptions' => array(
                'modified_date' => Zend_Registry::get('Zend_Translate')->_('Most Recent'),
                'question_views' => Zend_Registry::get('Zend_Translate')->_('Most Viewed'),
                'count_answers' => Zend_Registry::get('Zend_Translate')->_('Most Answered')
            ),
            'onchange' => 'this.form.submit();',
        ));

        $this->addElement('Select', 'status', array(
            'label' => Zend_Registry::get('Zend_Translate')->_('Status'),
            'multiOptions' => array(
                '0' => Zend_Registry::get('Zend_Translate')->_('All'),
                'open' => Zend_Registry::get('Zend_Translate')->_('Open'),
                'closed' => Zend_Registry::get('Zend_Translate')->_('Closed'),
                'canceled' => Zend_Registry::get('Zend_Translate')->_('Canceled')
            ),
            'onchange' => 'this.form.submit();',
        ));
        if ($settings->getSetting('question_category', 1)) {
            $action_url = Zend_Controller_Front::getInstance()->getRouter()->assemble(array('category' => ''));
            $this->addElement('Select', 'category', array(
                'label' => Zend_Registry::get('Zend_Translate')->_('Category'),
                'multiOptions' => array(
                    '0' => Zend_Registry::get('Zend_Translate')->_("All Categories"),
                ),
                'onchange' => "javascript:this.form.set('action', '$action_url'+this.value);  this.form.submit();",
            ));
            $categories = Engine_Api::_()->question()->getCategories();
            foreach ($categories as $category) {
                $this->category->addMultiOption($category->url, $category->category_name);
            }
        }
        if ($settings->getSetting('question_tags', 0)) {
            $this->addElement('Text', 'tags', array(
                'label' => Zend_Registry::get('Zend_Translate')->_('Tags'),
                'autocomplete' => 'off',
                'allowEmpty' => true,
                'filters' => array('StringTrim', new Engine_Filter_Censor()),
                'onchange' => 'var forms = function(){$("filter_form").submit();}; setTimeout(forms, 500);'
            ));
        }

        $this->addElement('Hidden', 'page', array(
            'order' => 1
        ));
    }

}
