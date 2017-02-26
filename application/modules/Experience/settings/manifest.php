<?php return array (
  /*----- Package -----*/
  'package' =>
  array (
    'type' => 'module',
    'name' => 'experience',
    'version' => '4.0.0',
    'path' => 'application/modules/Experience',
    'title' => 'Experience',
    'description' => 'The experience plugin helps users share their feeling, emotion and their knowledge to each other.',
    'author' => 'HungNT',
    'dependencies' => array(
      array(
        'type' => 'module',
        'name' => 'core',
        'minVersion' => '4.1.7',
      ),
    ),
    'callback' =>
    array (
      'path' => 'application/modules/Experience/settings/install.php',
      'class' => 'Experience_Installer',
    ),
    'actions' =>
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'enable',
      4 => 'disable',
    ),
    'directories' =>
    array (
      0 => 'application/modules/Experience',
    ),
    'files' =>
    array (
      0 => 'application/languages/en/experience.csv',
      0 => 'application/languages/vi_VN/experience.csv',
    ),
  ),
  /*----- Hook -----*/
  'hooks' => array(
    array(
      'event' => 'onStatistics',
      'resource' => 'Experience_Plugin_Core'
    ),
    array(
      'event' => 'onUserDeleteBefore',
      'resource' => 'Experience_Plugin_Core',
    ),
  ),
  /*----- Item -----*/
  'items' => array(
    'experience',
    'experience_category',
    'experience_feature',
  	'experience_link'
  ),
  /*----- Routes -----*/
  'routes' => array(

    'experience_specific' => array(
      'route' => 'experiences/:action/:experience_id/*',
      'defaults' => array(
        'module' => 'experience',
        'controller' => 'index',
        'action' => 'index',
      ),
      'reqs' => array(
        'experience_id' => '\d+',
        'action' => '(delete|edit)',
      ),
    ),

    'experience_general' => array(
      'route' => 'experiences/:action/*',
      'defaults' => array(
        'module' => 'experience',
        'controller' => 'index',
        'action' => 'index',
      ),
      'reqs' => array(
        'action' => '(index|create|manage|listing|style|tag|upload-photo|rss|become)',
      ),
    ),

    'experience_view' => array(
      'route' => 'experiences/:user_id/*',
      'defaults' => array(
        'module' => 'experience',
        'controller' => 'index',
        'action' => 'list',
      ),
      'reqs' => array(
        'user_id' => '\d+',
      ),
    ),

    'experience_entry_view' => array(
      'route' => 'experiences/:user_id/:experience_id/:slug',
      'defaults' => array(
        'module' => 'experience',
        'controller' => 'index',
        'action' => 'view',
        'slug' => '',
      ),
      'reqs' => array(
        'user_id' => '\d+',
        'experience_id' => '\d+'
      ),
    ),
    // Public
    'experience_import' => array(
      'route' => 'experiences/import',
      'defaults' => array(
        'module' => 'experience',
        'controller' => 'import',
        'action' => 'import',
      ),
      'reqs' => array(
        'action' => '(import)',
      ),
    ),
      'experience_export' => array(
          'route' => 'experiences/export/:action/*',
          'defaults' => array(
              'module' => 'experience',
              'controller' => 'export',
              'action' => 'index',
          ),
          'reqs' => array(
              'action' => '(index|export)',
          ),
      ),

  ),
); ?>