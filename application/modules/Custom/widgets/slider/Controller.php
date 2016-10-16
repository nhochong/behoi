<?php
class Custom_Widget_SliderController extends Engine_Content_Widget_Abstract
{
	public function indexAction(){
		$this->view->headScript()->appendFile($this->view->baseUrl() . '/externals/custom-slider/Loop.js');
		$this->view->headScript()->appendFile($this->view->baseUrl() . '/externals/custom-slider/SlideShow.js');
		$this->view->headScript()->appendFile($this->view->baseUrl() . '/externals/custom-slider/SlideShow.CSS.js');
		$this->view->headLink()->appendStylesheet($this->view->baseUrl() . '/externals/custom-slider/Slider.css');
		$this->view->slides = $slides = Engine_Api::_()->getDbTable('sliders', 'custom')->fetchAll();
	}
}