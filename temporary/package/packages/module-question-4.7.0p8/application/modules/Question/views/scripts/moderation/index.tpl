<?php $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/question_core.js') ?>
<?php if (is_array($this->files)) {
         $this->headLink()->appendStylesheet($this->baseUrl() . '/application/modules/Question/externals/styles/SqueezeBox.css');
         $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/SqueezeBox/SqueezeBox.js');

         $script = "window.addEvent('domready', function() {
                        SqueezeBox.assign($$('a[rel=boxed]'));
                    });";
         $this->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());

    } ?>
<?php
    $script = "var moderation = new question_moderation({question_id: '{$this->question->getIdentity()}'});";
    $this->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());
?>
<form action="<?php echo $this->url(array('module'=>'question','controller'=>'index','action'=>'index'), 'default') ?>" method="post" enctype="application/x-www-form-urlencoded" id="filter_form_q" name="filter_form_q">
    <input type="hidden" value="" id="category" name="category"/>
</form>
<div class="headline"><h2><?php echo $this->translate('Question Moderation') ?></h2></div>
<?php echo $this->htmlLink($this->question->getHref(), $this->translate('Return to view')) ?>
<div class="qa_question_body">
<?php echo $this->htmlLink(Array('route' => 'question_moderation', 'action' => 'edit', 'question_id' => $this->question->getIdentity()), $this->translate('Edit'), array('class' => 'qw_edit buttonlink')) ?>
  <div class='qa_browse_photo'>
    <?php echo $this->htmlLink($this->question->getOwnerUser()->getHref(), $this->itemPhoto($this->question->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($this->question->getOwnerUser())))) ?>
  </div>
  <div class='qa_browse_info'>
        <p class='qa_browse_info_date qa_browse_info_date_top'>
          <?php echo $this->translate('by %s ', $this->question->getOwnerUser()->toString()) ?>

          <?php
                if ($this->isEnabledCategories) {
                    $tmp_categories = $this->categories->getRowMatching('category_id', $this->question->category_id);
                    if (is_object($tmp_categories))
                         echo $this->translate('in %s', $this->htmlLink(array('route' => 'default', 'module' => 'question', 'category' => $tmp_categories->url, 'reset' => true), $this->translate($tmp_categories->category_name)));
                }
          ?>

          <?php echo $this->translate(' about %s', $this->timestamp($this->question->creation_date)) ?>

        <span class="qa_question_status <?php if($this->question->status != 'open') {echo 'closed-quest';}?>"><?php echo $this->translate('%s', $this->translate($this->question->status))?></span>
          
        </p>

    <?php if (trim($this->question->title)): ?>
        <p class="qa_title"><strong><?php echo $this->question->title ?></strong></p>
        <?php endif; ?>
        <span class="qa_title_descr"><p class='qa_title'><?php echo $this->question->getQuestion() ?></p></span>
        <?php if (is_array($this->files)):
            $file_api = Engine_Api::_()->getApi('storage', 'storage');
        ?>
            <div>
                <ul class="attached-images">
                    <?php foreach($this->files as $data_file) :
                        $file_thumb = $file_api->get($data_file, 'thumb.normal');
                        $file = $file_api->get($data_file);
                        if( !$file ) {continue; }
                    ?>
                        <li>
                            <a rel="boxed" href="<?php echo strtok($file->map(), '?'); ?>">
                                <img src="<?php echo $file_thumb->map(); ?>" class="photo" />
                            </a>
                        </li>
                    <?php endforeach;?>
                </ul>
            </div>
            <div style="clear: both;"></div>
        <?php endif; ?>

      </div>
    
</div>

<div class="qa_answers">
    <div class="qa_answers_list">

        <?php $count_answers = $this->paginator->getTotalItemCount(); ?>

        <?php if( $count_answers == 1): ?>
            <?php echo $this->translate("1 Answer")?>
        <?php else: ?>
            <?php echo $this->translate('%d Answers', $this->paginator->getTotalItemCount())?>
        <?php endif; ?>
    </div>
</div>
<br/>
<button id="reset_selected" onclick="javascript:moderation.reset_selected();" class="select_hide"><?php echo $this->translate('Reset Selected') ?></button>
<?php if ($this->paginator->getTotalItemCount() > 0): ?>
    <ul id="qa_browse" class="qa_browse drag_box">
        <?php foreach( $this->paginator as $answer ): ?>
            <li id="answer-<?php echo $answer->answer_id ?>" cl>
                <div class='qa_browse_photo'>
                    <?php echo $this->htmlLink($answer->getOwnerUser()->getHref(), $this->itemPhoto($answer->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($answer->getOwnerUser())))) ?>
                </div>
                <div class='qa_browse_info'>
                    <div class="qa_browse_info_blurb">
                        <p class='qa_browse_info_date qa_browse_info_date_top'>
                        <?php echo $this->translate('by %s', $answer->getOwnerUser()->toString()) ?>
                            <?php echo $this->translate(' about %s ', $this->timestamp($answer->creation_date)) ?>

                                <div class="manage_addition_menu">
                                    <div class="pulldown_contents_wrapper">
                                        <div class="pulldown_contents">
                                            <ul class="navigation">
                                                <li><?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question', 'controller' => 'smoothbox', 'action' => 'delete', 'id' => $answer->answer_id), $this->translate("delete"), array('class' => 'smoothbox buttonlink icon_qa_delete')) ?></li>
                                                <li><?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question', 'controller' => 'smoothbox', 'action' => 'edit-answer', 'id' => $answer->answer_id), $this->translate("edit"), array('class' => 'smoothbox buttonlink icon_qa_edit')) ?></li>
                                                <li><a href="javascript:void(0);" onclick="moderation.answer_move_comments('<?php echo $answer->answer_id ?>')" class="buttonlink icon_qa_move"><?php echo $this->translate('move this answer to comments') ?></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                    </p>

                    <?php echo $answer->answer; ?>
                  
                    <div id="answer_comments-<?php echo $answer->answer_id ?>" style="min-height: 40px;clear: both; margin-top: 20px;" class="drag_box mod_answer comments">
                        <?php if ($answer->comments()->getCommentCount()) : ?>
                            <span class="comments_title"><?php echo $this->translate('Comments:'); ?> </span>
                        <?php endif ?>
                        <?php echo $this->action("list", "comment", "question", array("type"=>"answer", "id"=>$answer->answer_id, 'moderation' => 1)) ?>
                        <button id="answer_hide_button-<?php echo $answer->answer_id ?>" class="select_hide" ><?php echo $this->translate('Select') ?></button>
                    </div>

                    </div><!--qa_browse_info_blurb-->
                    
                </div>
	    </li>

        <?php endforeach; ?>
    </ul><!--qa_browse-->
<?php else:?>
    <div class="tip">
        <span>
            <?php echo $this->translate('No answers founded.'); ?>
        </span>
    </div>
<?php endif; ?>