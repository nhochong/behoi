<?php
return array(
  'package' => array(
    'type' => 'theme',
    'name' => 'ynresponsive1',
    'version' => '4.02',
    'path' => 'application/themes/ynresponsive1',
    'repository' => 'younetco.com',
    'title' => 'YN - Responsive Clean Template - Green',
    'thumb' => 'theme.jpg',
    'author' => 'YouNet Company',
    'actions' => array(
      'install',
      'upgrade',
      'refresh',
      'remove',
    ),
    'callback' => array(
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
      array(
         'type' => 'module',
         'name' => 'ynresponsive1',
         'minVersion' => '4.05',
      ),
    ),
    'directories' => array(
      'application/themes/ynresponsive1',
      'application/themes/configure/default',
      'application/themes/configure/ynresponsive1',
    ),
    'description' => 'YouNet Responsive Clean Template - Green',
  ),
  'files' => array(
    'theme.css',
    'constants.css',
  ),
) ?>