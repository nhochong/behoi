<?php

class Custom_IndexController extends Core_Controller_Action_Standard
{
	public function indexAction()
	{
		$this->view->someVar = 'someVal';
	}
	
	public function subscribeEmailAction()
	{    
		$email = $this->getParam('email');
		if(empty($email)){
			$this->view->status = false;
			$this->view->message = Zend_Registry::get('Zend_Translate')->_('Invalid email');
			return;
		}
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
			$this->view->status = false;
			$this->view->message = Zend_Registry::get('Zend_Translate')->_('Invalid email');
			return;
		}
		
		// Process
		$table = Engine_Api::_()->getDbTable('subscribers','custom');
		$emails = $table->fetchAll($table->select()->where('email = ?', $email));
		if(!count($emails)){
			$db = $table->getAdapter();
			$db->beginTransaction();

			try {
				// Create blog
			
				$values = array(
					'email' => $email,
					'creation_date' => date('Y-m-d H:i:s')
				);
			
				$row = $table->createRow();     	
				$row->setFromArray($values);
				$row->save();
				// Commit
				$db->commit();
			} catch( Exception $e ){
				$db->rollBack();
				throw $e;
			}
		}    
		$this->view->status = true;
		$this->view->message = Zend_Registry::get('Zend_Translate')->_('Thanks for submitting your email. We\'ll keep you up to date on our progress!');
	}
}
