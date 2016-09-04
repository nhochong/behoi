<?php

class Question_Form_Rating extends Engine_Form {
    protected static $_instance;

    public static function getInstance() {
        if (self::$_instance===null) {
            self::$_instance = new self;
        }
        return self::$_instance;
    }

    public function init() {
        $this
          ->setAttribs(array(
            'id' => 'filter_form',
            'class' => 'global_form_box',
          ))
          ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
          ;

        $this->addElement('Text', 'search', array(
          'label' => Zend_Registry::get('Zend_Translate')->_('Search User'),
          'onchange' => 'this.form.submit();',
        ));

        $this->addElement('Hidden', 'page', array(
          'value' => 1

        ));
        $this->addElement('Hidden', 'order', array(
          'order' => 2
        ));
    }
}