<?php return array (
  'package' => 
  array (
    'type' => 'theme',
    'name' => 'ynresponsiveclean-blue',
    'version' => '4.02',
    'path' => 'application/themes/yn-responsivecleantemplate-blue',
    'repository' => 'younetco.com',
    'title' => 'YN - Responsive Clean Template - Blue',
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
      0 => 'application/themes/ynresponsiveclean-blue',
      1 => 'application/themes/configure/default',
      2 => 'application/themes/configure/ynresponsiveclean-blue',
    ),
    'description' => 'Responsive Clean Template - Blue',
  ),
  'files' => 
  array (
    0 => 'theme.css',
    1 => 'constants.css',
  ),
); ?>