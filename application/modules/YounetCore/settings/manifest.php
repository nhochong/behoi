<?php return array (
  'package' => 
  array (
    'type' => 'module',
    'name' => 'younet-core',
    'version' => '4.02p12',
    'path' => 'application/modules/YounetCore',
    'title' => 'YN - Core Module',
    'description' => 'YouNet Core Module',
      'author' => '<a href="http://socialengine.younetco.com/" title="YouNet Company" target="_blank">YouNet Company</a>',
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
      0 => 'application/modules/YounetCore',
    ),
    'files' => 
    array (
      0 => 'application/languages/en/younet-core.csv',
    ),
  ),
); ?>