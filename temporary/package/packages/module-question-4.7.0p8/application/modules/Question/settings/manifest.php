<?php return array(
      // Package -------------------------------------------------------------------
  'package' => array(
    'type' => 'module',
    'name' => 'question',
    'version' => '4.7.0p8',
    'path' => 'application/modules/Question',
    'title' => 'Questions',
    'description' => 'Questions & Answers Plugin',
    'author' => 'WebHive Team',
    'repository' => '',
    'dependencies' => array(
      array(
        'type' => 'module',
        'name' => 'core',
        'minVersion' => '4.1.8',
      ),
    ),
    'meta' => array(
      'title' => 'Questions',
      'description' => 'Questions & Answers Plugin',
      'author' => 'WebHive Team',
    ),
    'actions' => array(
       'install',
       'upgrade',
       'refresh',
       'enable',
       'disable',
     ),
     'callback' => array(
      'path' => 'application/modules/Question/settings/install.php',
      'class' => 'Question_Installer'
    ),
    'directories' => array(
      'application/modules/Question',
    ),
    'files' => array(
      'application/languages/en/question.csv',
    ),
  ),
  // Hooks ---------------------------------------------------------------------
  'hooks' => array(
    array(
      'event' => 'onStatistics',
      'resource' => 'Question_Plugin_Core'
    ),
    array(
      'event' => 'onUserDeleteBefore',
      'resource' => 'Question_Plugin_Core',
    ),
    array(
      'event' => 'getActivity',
      'resource' => 'Question_Plugin_Core',
    ),  
  ),
  // Compose -------------------------------------------------------------------
  'composer' => array(
    'question' => array(
      'script' => array('_composeQuestion.tpl', 'question'),
      'auth' => array('question', 'create'),
    ),
  ),
  // Items ---------------------------------------------------------------------
  'items' => array(
    'question',
    'answer',
    'question_rating',
    'quser',
    'question_anonymous'  
  ),
  // Routes --------------------------------------------------------------------
  'routes' => array(
    'question_edit' => array(
      'route' => 'question/edit/:question_id',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'index',
        'action' => 'edit'
      )
    ),
   'question_view' => array(
      'route' => 'question/view/:question_id/:slug',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'index',
        'action' => 'view',        
        'slug' => ''
      ),
      'reqs' => array(
        'question_id' => '\d+'
      )
    ),
    'question_moderation' => array(
      'route' => 'question/moderation/:question_id/:action/*',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'moderation',
        'action' => 'index'
      ),
      'reqs' => array(
        'action' => '(index|edit)',
        'question_id' => '\d+'
      )
    ),
    'user_questions' => array(
      'route' => 'question/:user_id/*',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'index',
        'action' => 'index',
      ),
      'reqs' => array(
        'user_id' => '\d+'
      )
    ),
    'answers' => array(
      'route' => 'question/answers/:user_id/*',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'index',
        'action' => 'answers',
      ),
      'reqs' => array(
        'user_id' => '\d+'
      )
    ),
    'choose' => array(
      'route' => 'question/choose/:best_id',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'index',
        'action' => 'choose'
      )
    ),
    'who_voted' => array(
      'route' => 'question/who-voted/:type/:id/:vote_type/:page/',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'smoothbox',
        'action' => 'who-voted',
        'vote_type' => 'vote_for',
        'page' => 1
      ),
      'reqs' => array(
        'id' => '\d+',
        'type' => '(question|answer)',
        'vote_type' => '(vote_for|vote_against)',
        'page' => '\d+'
      )
    ),
    'question_admin_manage_level' => array(
      'route' => 'admin/question/level/:level_id',
      'defaults' => array(
        'module' => 'question',
        'controller' => 'admin-level',
        'action' => 'index',
        'level_id' => 1
      )
    )
  )
)
?>
