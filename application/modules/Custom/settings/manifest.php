<?php return array (
  'package' => 
  array (
    'type' => 'module',
    'name' => 'custom',
    'version' => '4.0.0',
    'path' => 'application/modules/Custom',
    'title' => 'Custom',
    'description' => 'Customization',
    'author' => 'tuuvt',
    'callback' => 
    array (
      'class' => 'Engine_Package_Installer_Module',
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
      'application/modules/Custom',
    ),
    'files' => 
    array (
      'application/languages/en/custom.csv',
    ),
  ),
    // Items 
  'items' => array(
    'slider',
  ),
); ?>