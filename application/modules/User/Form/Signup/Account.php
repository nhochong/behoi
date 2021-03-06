<?php

/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Form_Signup_Account extends Engine_Form_Email
{  
  public function init()
  {
    $settings = Engine_Api::_()->getApi('settings', 'core');
    
    $this->_emailAntispamEnabled = ($settings
        ->getSetting('core.spam.email.antispam.signup', 1) == 1) &&
      empty($_SESSION['facebook_signup']) &&
      empty($_SESSION['twitter_signup']) &&
      empty($_SESSION['janrain_signup']);
    
    $inviteSession = new Zend_Session_Namespace('invite');
    $tabIndex = 10;
    
    // Init form
    $this->setTitle('Create Account');
    $this->setAttrib('id', 'signup_account_form');

    // Element: name (trap)
    $this->addElement('Text', 'name', array(
      'class' => 'signup-name',
      'label' => 'Name',
      'validators' => array(
	      array('StringLength', true, array('max' => 0)))));

    $this->name->getValidator('StringLength')->setMessage('An error has occured, please try again later.');

    // Element: email
    $emailElement = $this->addEmailElement(array(
      'label' => 'Email Address',
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        array('NotEmpty', true),
        array('EmailAddress', true),
        array('Db_NoRecordExists', true, array(Engine_Db_Table::getTablePrefix() . 'users', 'email'))
      ),
      'filters' => array(
        'StringTrim'
      ),
      // fancy stuff
      'inputType' => 'email',
      'autofocus' => 'autofocus',
      'tabindex' => $tabIndex++,
    ));
    $emailElement->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
    $emailElement->getValidator('NotEmpty')->setMessage('Please enter a valid email address.', 'isEmpty');
    $emailElement->getValidator('Db_NoRecordExists')->setMessage('Someone has already registered this email address, please use another one.', 'recordFound');
    $emailElement->getValidator('EmailAddress')->getHostnameValidator()->setValidateTld(false);
    // Add banned email validator
    $bannedEmailValidator = new Engine_Validate_Callback(array($this, 'checkBannedEmail'), $emailElement);
    $bannedEmailValidator->setMessage("This email address is not available, please use another one.");
    $emailElement->addValidator($bannedEmailValidator);
    
    if( !empty($inviteSession->invite_email) ) {
      $emailElement->setValue($inviteSession->invite_email);
    }

    //if( $settings->getSetting('user.signup.verifyemail', 0) > 0 && $settings->getSetting('user.signup.checkemail', 0) == 1 ) {
    //  $this->email->addValidator('Identical', true, array($inviteSession->invite_email));
    //  $this->email->getValidator('Identical')->setMessage('Your email address must match the address that was invited.', 'notSame');
    //}
    
	// Element: username
    if( $settings->getSetting('user.signup.username', 1) > 0 ) {
      $this->addElement('Text', 'username', array(
        'label' => 'Profile Address',
        'required' => true,
        'allowEmpty' => false,
        'validators' => array(
          array('NotEmpty', true),
          // array('Alnum', true),
          array('StringLength', true, array(4, 64)),
          array('Regex', true, array('/^[a-z][a-z0-9_.]*$/i')),
          array('Db_NoRecordExists', true, array(Engine_Db_Table::getTablePrefix() . 'users', 'username'))
        ),
        'tabindex' => $tabIndex++,
          //'onblur' => 'var el = this; en4.user.checkUsernameTaken(this.value, function(taken){ el.style.marginBottom = taken * 100 + "px" });'
      ));
      $this->username->getDecorator('Description')->setOptions(array('placement' => 'APPEND', 'escape' => false));
      $this->username->getValidator('NotEmpty')->setMessage('Please enter a valid profile address.', 'isEmpty');
      $this->username->getValidator('Db_NoRecordExists')->setMessage('Someone has already picked this profile address, please use another one.', 'recordFound');;
      $this->username->getValidator('Regex')->setMessage('Profile addresses must be alphanumeric.', 'regexNotMatch');
      // $this->username->getValidator('Alnum')->setMessage('Profile addresses must be alphanumeric.', 'notAlnum');

      // Add banned username validator
      $bannedUsernameValidator = new Engine_Validate_Callback(array($this, 'checkBannedUsername'), $this->username);
      $bannedUsernameValidator->setMessage("This profile address is not available, please use another one.");
      $this->username->addValidator($bannedUsernameValidator);
    }
	
    // Element: code
    if( $settings->getSetting('user.signup.inviteonly') > 0 ) {
      $codeValidator = new Engine_Validate_Callback(array($this, 'checkInviteCode'), $emailElement);
      $codeValidator->setMessage("This invite code is invalid or does not match the selected email address");
      $this->addElement('Text', 'code', array(
        'label' => 'Invite Code',
        'required' => true
      ));
      $this->code->addValidator($codeValidator);

      if( !empty($inviteSession->invite_code) ) {
        $this->code->setValue($inviteSession->invite_code);
      }
    }

    if( $settings->getSetting('user.signup.random', 0) == 0 && 
        empty($_SESSION['facebook_signup']) && 
        empty($_SESSION['twitter_signup']) && 
        empty($_SESSION['janrain_signup']) ) {

      // Element: password
      $this->addElement('Password', 'password', array(
        'label' => 'Password',
        'description' => 'Passwords must be at least 6 characters in length.',
        'required' => true,
        'allowEmpty' => false,
        'validators' => array(
          array('NotEmpty', true),
          array('StringLength', false, array(6, 32)),
        ),
        'tabindex' => $tabIndex++,
      ));
      $this->password->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
      $this->password->getValidator('NotEmpty')->setMessage('Please enter a valid password.', 'isEmpty');

      // Element: passconf
      $this->addElement('Password', 'passconf', array(
        'label' => 'Password Again',
        'description' => 'Enter your password again for confirmation.',
        'required' => true,
        'validators' => array(
          array('NotEmpty', true),
        ),
        'tabindex' => $tabIndex++,
      ));
      $this->passconf->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
      $this->passconf->getValidator('NotEmpty')->setMessage('Please make sure the "password" and "password again" fields match.', 'isEmpty');

      $specialValidator = new Engine_Validate_Callback(array($this, 'checkPasswordConfirm'), $this->password);
      $specialValidator->setMessage('Password did not match', 'invalid');
      $this->passconf->addValidator($specialValidator);
    }
    
    // Element: profile_type
    $topStructure = Engine_Api::_()->fields()->getFieldStructureTop('user');
    if( count($topStructure) == 1 && $topStructure[0]->getChild()->type == 'profile_type' ) {
      $profileTypeField = $topStructure[0]->getChild();
      $options = $profileTypeField->getOptions();
      if( count($options) > 1 ) {
        $options = $profileTypeField->getElementParams('user');
        unset($options['options']['order']);
        unset($options['options']['multiOptions']['0']);
        $this->addElement('Select', 'profile_type', array_merge($options['options'], array(
              'required' => true,
              'allowEmpty' => false,
              'tabindex' => $tabIndex++,
            )));
      } else if( count($options) == 1 ) {
        $this->addElement('Hidden', 'profile_type', array(
          'value' => $options[0]->option_id
        ));
      }
    }

    // Element: captcha
    if( Engine_Api::_()->getApi('settings', 'core')->core_spam_signup ) {
      $this->addElement('captcha', 'captcha', Engine_Api::_()->core()->getCaptchaOptions(array(
        'tabindex' => $tabIndex++,
      )));
    }
    
    if( $settings->getSetting('user.signup.terms', 1) == 1 ) {
      // Element: terms
      $description = Zend_Registry::get('Zend_Translate')->_('I have read and agree to the <a target="_blank" href="%s/help/terms">terms of service</a>.');
      $description = sprintf($description, Zend_Controller_Front::getInstance()->getBaseUrl());

      $this->addElement('Checkbox', 'terms', array(
        'label' => 'Terms of Service',
        'description' => $description,
        'required' => true,
        'validators' => array(
          'notEmpty',
          array('GreaterThan', false, array(0)),
        ),
        'tabindex' => $tabIndex++,
      ));
      $this->terms->getValidator('GreaterThan')->setMessage('You must agree to the terms of service to continue.', 'notGreaterThan');
      //$this->terms->getDecorator('Label')->setOption('escape', false);

      $this->terms->clearDecorators()
          ->addDecorator('ViewHelper')
          ->addDecorator('Description', array('placement' => Zend_Form_Decorator_Abstract::APPEND, 'tag' => 'label', 'class' => 'null', 'escape' => false, 'for' => 'terms'))
          ->addDecorator('DivDivDivWrapper');

      //$this->terms->setDisableTranslator(true);
    }

    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Continue',
      'type' => 'submit',
      'ignore' => true,
      'tabindex' => $tabIndex++,
    ));
    
    if( empty($_SESSION['facebook_signup']) ){
      // Init facebook login link
//      if( 'none' != $settings->getSetting('core_facebook_enable', 'none')
//          && $settings->core_facebook_secret ) {
//        $this->addElement('Dummy', 'facebook', array(
//          'content' => User_Model_DbTable_Facebook::loginButton(),
//        ));
//      }
    }
    
    if( empty($_SESSION['twitter_signup']) ){
      // Init twitter login link
//      if( 'none' != $settings->getSetting('core_twitter_enable', 'none')
//          && $settings->core_twitter_secret ) {
//        $this->addElement('Dummy', 'twitter', array(
//          'content' => User_Model_DbTable_Twitter::loginButton(),
//        ));
//      }
    } 
    // Set default action
    $this->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_signup', true));
  }

  public function checkPasswordConfirm($value, $passwordElement)
  {
    return ( $value == $passwordElement->getValue() );
  }

  public function checkInviteCode($value, $emailElement)
  {
    $inviteTable = Engine_Api::_()->getDbtable('invites', 'invite');
    $select = $inviteTable->select()
      ->from($inviteTable->info('name'), 'COUNT(*)')
      ->where('code = ?', $value)
      ;
      
    if( Engine_Api::_()->getApi('settings', 'core')->getSetting('user.signup.checkemail') ) {
      $select->where('recipient LIKE ?', $emailElement->getValue());
    }
    
    return (bool) $select->query()->fetchColumn(0);
  }

  public function checkBannedEmail($value, $emailElement)
  {
    $bannedEmailsTable = Engine_Api::_()->getDbtable('BannedEmails', 'core');
    if ($bannedEmailsTable->isEmailBanned($value)) {
      return false;
    }
    $isValidEmail = true;
    $event = Engine_Hooks_Dispatcher::getInstance()->callEvent('onCheckBannedEmail', $value);
    foreach ((array)$event->getResponses() as $response) {
      if ($response) {
        $isValidEmail = false;
        break;
      }
    }
    return $isValidEmail;
  }

  public function checkBannedUsername($value, $usernameElement)
  {
    $bannedUsernamesTable = Engine_Api::_()->getDbtable('BannedUsernames', 'core');
    return !$bannedUsernamesTable->isUsernameBanned($value);
  }
}
