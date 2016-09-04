<?php

class Question_View_Helper_RenderSimpleWidget extends Zend_View_Helper_Abstract
{
  public function RenderSimpleWidget($name, $params = array())
  {
    $structure = array(
      'type' => 'widget',
      'name' => $name,
      'action' => ( !empty($params['action']) ? $params['action'] : 'index' ),
    );
    if( !empty($params) ) {
      $structure['request'] = new Zend_Controller_Request_Simple('index', 'index', 'core', $params);
    }

    // Create element (with structure)
    $element = new Engine_Content_Element_Widget($structure);

    return $element->clearDecorators()->render();
  }

}