<?php

class Question_View_Helper_HowCollectPoints extends Zend_View_Helper_Abstract
{
  public function HowCollectPoints()
  {
    $settings = Engine_Api::_()->getApi('settings', 'core');
    $translate = Zend_Registry::get('Zend_Translate');
    $content = <<<EOF
    <div class="layout_question_list_point">
        <h3>{$translate->_('How do I collect points?')}</h3>
        <ul>
            <li style="padding-top:5px">
               <div class="qa_points">+{$settings->getSetting('question_points_best_answer', 5)}</div>
               <div class="qa_point_desc">{$translate->_('Chosen as best answer')}</div>
            </li>
            <li>
		<div class="qa_points">+{$settings->getSetting('question_points_posted_answer', 1)}</div>
		<div class="qa_point_desc">{$translate->_('Posted answer')}</div>
            </li>
            <li>
		<div class="qa_points">+{$settings->getSetting('question_points_posted_question', 1)}</div>
		<div class="qa_point_desc">{$translate->_('Posted question')}</div></li>
            <li>
		<div class="qa_points">+{$settings->getSetting('question_points_thumb_up', 1)}</div>
		<div class="qa_point_desc">{$translate->_('Thumb up')}</div></li>
            <li>
		<div class="qa_points">-{$settings->getSetting('question_points_thumb_down', 1)}</div>
		<div class="qa_point_desc">{$translate->_('Thumb down')}</div></li>
            </ul>
      </div>
EOF;

    return $content;
  }

}