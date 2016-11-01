<?php

/*
 * Author: LuanND
 * Company: YounetCo
 */

class Ynforum_Form_Admin_Post_Manage extends Engine_Form {

    public function init() {

        $this->clearDecorators()->addDecorator('FormElements')
                ->addDecorator('Form')->addDecorator('HtmlTag', array(
                    'tag' => 'div',
                    'class' => 'search'))
                ->addDecorator('HtmlTag2', array('tag' => 'div', 'class' => 'clear'))
                ->setAttribs(array('id' => 'filter_form',
                        
                ));       

        $this->addElement('Text', 'title', array(
            'label' => 'Title',
        	''
        ));
		
		 $this->addElement('Text', 'creator', array(
            'label' => 'Creator',
        	''
        ));
		
		$this->addElement('select', 'approved', array(
            'label' => 'Search by date of:',
            'multiOptions' => array(
                1 => 'Approved',
                0 => 'Pendding',
                2 => 'Denied',)
                ,));
       

        $date_validate = new Zend_Validate_Date("YYYY-MM-dd");
        $date_validate->setMessage("Please pick a valid day (yyyy-mm-dd)", Zend_Validate_Date::FALSEFORMAT);

        $this->addElement('Text', 'start_date', array(
            'label' => 'From',
            'required' => false,));
        $this->getElement('start_date')->addValidator($date_validate);

        $this->addElement('Text', 'end_date', array(
            'label' => 'To',
            // 'validator' => $date_validate,
            'required' => false,));
        $this->getElement('end_date')->addValidator($date_validate);
		
		$this->addElement('Hidden', 'order', array('order' => 10004,));      
        // Element: direction
        $this->addElement('Hidden', 'direction', array('order' => 10005,));
		
        
        $this->addElement('Button', 'submit1', array(
            'label' => 'Search',
            'type' => 'submit',
            'ignore' => true,));
    }

}

?>
