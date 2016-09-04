<?php

class Question_Form_Admin_Level extends Engine_Form
{
    protected $_public;

  public function setPublic($public)
  {
    $this->_public = $public;
  }

  public function init()
  {
    $this
      ->setTitle('Member Level Settings')
      ->setDescription('These settings are applied on a per member level basis. Start by selecting the member level you want to modify, then adjust the settings for that level below.')
      ->setAttrib('name', 'level_settings');

    $this->loadDefaultDecorators();
    $this->getDecorator('Description')->setOptions(array('tag' => 'h4', 'placement' => 'PREPEND'));

    // prepare user levels
    $table = Engine_Api::_()->getDbtable('levels', 'authorization');
    $select = $table->select();
    $user_levels = $table->fetchAll($select);

    foreach ($user_levels as $user_level){
      $levels_prepared[$user_level->level_id]= $user_level->getTitle();
    }

    // category field
    $this->addElement('Select', 'level_id', array(
          'label' => 'Member Level',
          'multiOptions' => $levels_prepared,
          'onchange' => "javascript:window.location.href = en4.core.baseUrl + 'admin/question/level/'+this.value;",
          'ignore' => true
        ));

    $this->addElement('Radio', 'view', array(
      'label' => 'Browse Questions',
      'description' => 'Do you want to allow this user level to view questions?',
      'multiOptions' => array(
        1 => 'Yes, allow this user level to view questions.',
        0 => 'No, deny this user level to view questions.'
      ),
      'value' => 0,
    ));
    if (!$this->_public)
        {
        $this->addElement('Radio', 'create', array(
          'label' => 'Create Questions',
          'description' => 'Do you want to allow this user level to create questions?',
          'multiOptions' => array(
            1 => 'Yes, allow this user level to post questions.',
            0 => 'No, deny this user level to post questions.'
          ),
          'value' => 1,
        ));

        $this->addElement('MultiCheckbox', 'answer', array(
              'label' => 'Post Answers',
              'description' => 'Do you want to allow this user level to post answers?',
              'multiOptions' => array(
                'everyone' => 'Allow users to post answers for all questions posted by others',
                'owner' => "Allow users to post answers for their own questions."
              ),
              'value' => array('everyone', 'owner')
            ));
        $this->addElement('MultiCheckbox', 'choose_answer', array(
              'label' => 'Choose the Best Answer',
              'description' => 'Allow this user level to set choose best answers for',
              'multiOptions' => array(
                'everyone' => 'Questions posted by other users (check if this user level is used for moderation)',
                'owner' => "Only their own questions (check if you want author of question to choose the best answer )"
              ),
              'value' => array('everyone', 'owner')
            ));
        $this->addElement('Radio', 'comment_answer', array(
              'label' => 'Comments on Answers',
              'description' => 'Do you want to allow this user level to post comments on answers?',
              'multiOptions' => array(
                1 => 'Yes, allow that.',
                0 => 'No, deny that'
              ),
              'value' => 0,
            ));
        $this->addElement('Text', 'max_answers', array(
              'label' => 'Multiple Answers',
              'description' => 'How many answers are allowed to be posted to the same question by a single user? (0 unlimited)',
              'value' => 0,
            ));
        $this->addElement('Text', 'max_files', array(
              'label' => 'File Attachments',
              'description' => 'How many files is it possible to attach to a question? (0 - not allowed)',
              'value' => 0,
            ));
        $this->addElement('Radio', 'del_answer', array(
              'label' => 'Delete Answers',
              'description' => 'Do you want to allow this user level to delete answers?',
              'multiOptions' => array(
                'everyone' => 'Allow to delete all answers(choose if this level is used for moderators).',
                'all' => 'Allow to delete answers to their own questions.',
           //     'qowner' => 'Allow to delete answer on their question.',
                'owner' => 'Allow to delete only their own answers.',
                'none' => 'No, do not allow to delete answers.'
              ),
              'value' =>  'none',
            ));
        $this->addElement('Radio', 'del_question', array(
              'label' => 'Delete Question',
              'description' => 'Do you want to allow this user level to delete questions?',
              'multiOptions' => array(
                'everyone' => 'Allow to delete all questions(choose if this level is used for moderators).',
                'owner' => 'Allow to delete only their own questions.',
                'none' => 'No, do not allow to delete questions.'
              ),
              'value' =>  'none',
            ));
        $this->addElement('Radio', 'cancel_question', array(
              'label' => 'Cancel Question',
              'description' => 'Do you want to allow this user level to cancel questions?',
              'multiOptions' => array(
                'everyone' => 'Allow to cancel all questions(choose if this level is used for moderators).',
                'owner' => 'Allow to cancel only their own questions.',
                'none' => 'No, do not allow to cancel questions.'
              ),
              'value' =>  'owner',
            ));
        $this->addElement('Radio', 'reopen_question', array(
              'label' => 'ReOpen Question',
              'description' => 'Do you want to allow this user level to reopen questions?',
              'multiOptions' => array(
                'everyone' => 'Allow to reopen all questions(choose if this level is used for moderators).',
                'owner' => 'Allow to reopen only their own questions.',
                'none' => 'No, do not allow to reopen questions.'
              ),
              'value' =>  'none',
            ));
        $this->addElement('Radio', 'delcom_question', array(
              'label' => 'Delete Comment',
              'description' => 'Do you want to allow this user level to delete comments?',
              'multiOptions' => array(
                'everyone' => 'Allow to delete all comments(choose if this level is used for moderators).',
                'owner' => 'Allow to delete any comments in their questions.',
                'none' => 'No, do not allow to delete comments.'
              ),
              'value' =>  'none',
            ));
        $this->addElement('Radio', 'moderation', array(
              'label' => 'Advanced Moderation',
              'description' => 'Do you want to allow this user level to edit text of questions or answers and relocation comments?',
              'multiOptions' => array(
                '1' => 'Yes.',
                '0' => 'No.'
              ),
              'value' =>  '0',
            ));

        // Element: auth_view
        $this->addElement('MultiCheckbox', 'auth_view', array(
            'label' => 'Question Entry Privacy',
            'description' => 'Your members can choose from any of the options checked below when they decide who may  see their question entries. These options apply on your members\' "Add Entry" and "Edit Entry" pages. If you do not check any options, everyone will be allowed to view questions.',
            'multiOptions' => array(
              'everyone'            => 'Everyone',
              'registered'          => 'All Registered Members',
              'owner_network'       => 'Friends and Networks',
              'owner_member_member' => 'Friends of Friends',
              'owner_member'        => 'Friends Only',
              'owner'               => 'Just Me'
            )
            ));

          // Element: auth_comment
          $this->addElement('MultiCheckbox', 'auth_answer', array(
            'label' => 'Question Answer Options',
            'description' => 'Your members can choose from any of the options checked below when they decide who may answer on their questions. If you do not check any options, everyone will be allowed to answer on question.',
            'multiOptions' => array(
              'registered'          => 'All Registered Members',
              'owner_network'       => 'Friends and Networks',
              'owner_member_member' => 'Friends of Friends',
              'owner_member'        => 'Friends Only',
              'owner'               => 'Just Me'
            )
          ));
        }
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Settings',
      'type' => 'submit',
      'ignore' => true
    ));

  }
}
