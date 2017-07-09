<?php
class Custom_Widget_HiddenHeaderController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$tagname = $this->_getParam('tagname', 'h1');
		$content = $this->_getParam('content', '');
		$hiddenHeader = '<' . $tagname . ' title="' . $content . '">' . $content . '</' . $tagname . '>';
		$this->view->hiddenHeader = $hiddenHeader;
	}
}
