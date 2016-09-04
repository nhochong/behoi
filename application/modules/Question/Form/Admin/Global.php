<?php

class Question_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');

    $this->addElement('Text', 'question_page', array(
      'label' => 'Entries Per Page',
      'description' => 'How many questions or answers will be shown per page? (Enter a number between 1 and 999)',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_page', 10),
      'required' => true,
      'validators' => array('Digits', array('validator' => 'Between', 'options' => array(1, 999)))
    ));
    $this->addElement('Text', 'question_min_points_ask', array(
      'label' => 'Min points to ask questions',
      'description' => 'This setting is useful if you want to allow posting questions only if user has already gained some points by posting answers.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_min_points_ask', 0),
      'required' => true,
      'validators' => array('Digits')
    ));

    $this->addElement('Text', 'question_min_points_vote_down', array(
      'label' => 'Min points to vote down',
      'description' => 'This setting is used if you want only loyal users to vote down.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_min_points_vote_down', 0),
      'required' => true,
      'validators' => array('Digits')
    ));
    $this->addElement('Text', 'question_points_best_answer', array(
      'label' => 'Points for the best answer',
      'description' => 'How many points does user get for the best answer.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_best_answer', 5),
      'required' => true,
      'validators' => array('Digits')
    ));

    $this->addElement('Text', 'question_points_posted_answer', array(
      'label' => 'Points for posted answer',
      'description' => 'How many points does user get for posting an answer.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_posted_answer', 1),
      'required' => true,
      'validators' => array('Digits')
    ));
    $this->addElement('Text', 'question_points_posted_question', array(
      'label' => 'Points for posted question',
      'description' => 'How many points does user get for posting a question.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_posted_question', 1),
      'required' => true,
      'validators' => array('Digits')
    ));
    $this->addElement('Text', 'question_points_thumb_up', array(
      'label' => 'Points for thumb up on answer',
      'description' => 'How many points does user get if their question or answer was voted up.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_thumb_up', 1),
      'required' => true,
      'validators' => array('Digits')
    ));
    $this->addElement('Text', 'question_points_thumb_down', array(
      'label' => 'Points for thumb down on answer',
      'description' => 'How many points does user lose if their answer was voted down.',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_points_thumb_down', 1),
      'required' => true,
      'validators' => array('Digits')
    ));

    $this->addDisplayGroup(array('question_min_points_ask',
                                 'question_min_points_vote_down'),
                           'limit_settings',
                           array('legend'=>'Limitation Settings')
                          );
    $limit_settings = $this->getDisplayGroup('limit_settings');
    $limit_settings->setDecorators(array('FormElements',
                                         'Fieldset',
                                         array('HtmlTag',
                                               array('openOnly'=>true,
                                                     'style'=>'margin-top:10px; clear:both')
                                               )
                                        )
                                  );
    $this->addDisplayGroup(array('question_points_best_answer',
                                 'question_points_posted_answer',
                                 'question_points_posted_question',
                                 'question_points_thumb_up',
                                 'question_points_thumb_down'),
                           'points_settings',
                           array('legend'=>'Points Settings')
                          );
    $points_settings = $this->getDisplayGroup('points_settings');
    $points_settings->setDecorators(array('FormElements',
                                          'Fieldset',
                                          array('HtmlTag',
                                                array('style'=>'margin-top:10px;')
                                                )
                                         )
                                    );
    $this->addElement('Radio', 'wall_ask', array(
      'label' => "Ask from 'What's New' feed",
      'description' => "Do you want to allow members ask questions from 'What's New' feed?",
      'multiOptions' => array(
        1 => 'Yes, do this.',
        0 => 'No, thanks.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('wall_ask', 1),
    ));
    $this->addElement('Radio', 'question_tags', array(
      'label' => "Enable tags",
      'description' => "Do you want to enable tags?",
      'multiOptions' => array(
        1 => 'Yes, do this.',
        0 => 'No, thanks.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0),
    ));
    $this->addElement('Radio', 'question_category', array(
      'label' => "Enable categories",
      'description' => "Do you want to enable categories?",
      'multiOptions' => array(
        1 => 'Yes, do this.',
        0 => 'No, thanks.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1),
    ));
    
    $this->addElement('Radio', 'question_anonymous', array(
      'label' => "Enable anonymous posts",
      'description' => "Do you want to let members ask and answer anonymous questions? Notice, members will be able to answer all questions as anonymous.",
      'multiOptions' => array(
        1 => 'Yes, do this.',
        0 => 'No, thanks.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('question_anonymous', 0),
    ));
        
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));

  }
}
