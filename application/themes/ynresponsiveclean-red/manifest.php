<?php return array (
  'package' => 
  array (
    'type' => 'theme',
    'name' => 'ynresponsiveclean-red',
    'version' => '4.02',
    'path' => 'application/themes/ynresponsiveclean-red',
    'repository' => 'younetco.com',
    'title' => 'YN - Responsive Clean Template - Red',
    'thumb' => 'theme.jpg',
    'author' => 'YouNet Company',
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'remove',
    ),
    'callback' => 
    array (
      'class' => 'Engine_Package_Installer_Theme',
    ),
    'dependencies' => 
    array (
      0 => 
      array (
        'type' => 'module',
        'name' => 'ynresponsiveclean',
        'minVersion' => '4.02',
      ),
      1 => 
      array (
        'type' => 'module',
        'name' => 'ynresponsive1',
        'minVersion' => '4.05',
      ),
    ),
    'directories' => 
    array (
      0 => 'application/themes/ynresponsiveclean-red',
      1 => 'application/themes/configure/default',
      2 => 'application/themes/configure/ynresponsiveclean-red',
    ),
    'description' => 'Responsive Clean Template - Red',
  ),
  'files' => 
  array (
    0 => 'theme.css',
    1 => 'constants.css',
  ),
); ?>