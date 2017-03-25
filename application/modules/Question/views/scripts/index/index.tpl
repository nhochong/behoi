<?php $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/question_core.js') ?>
<?php
    $script = "window.addEvent('load', function() {
                  new Tips($$('.Tips'));
                 });";
    $this->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());
?>

<?php $settings = Engine_Api::_()->getApi('settings', 'core'); ?>


  <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

  <ul class="qa_browse">
    <?php foreach( $this->paginator as $question ): ?>
      <li>
        <div class="qa-right">	  
            <div class="qa_browse_options">
              <?php if ( $this->moderation or $question->isOwner($this->viewer()) or $question->User_can($this->viewer(), 'cancel') or $question->User_can($this->viewer(), 'reopen') or ($question->User_can($this->viewer(), 'del'))): ?>
              <a href="javascript:void(0)" class="qa_browse_options_links"></a>
              <?php endif; ?>
              <div class="pulldown_contents_wrapper">
                <div class="pulldown_contents">
                  <ul>            
                    <?php if ($question->isOwner($this->viewer()) and $question->status == 'open'): ?>
                      <li><a href='<?php echo $this->url(array('question_id' => $question->question_id), 'question_edit', true) ?>' class='icon_qa_edit buttonlink'><?php echo $this->translate('Edit Entry');?></a></li>

                    <?php elseif ( $this->moderation ): ?>
                      <li><a href='<?php echo $this->url(array('action' => 'edit', 'question_id' => $question->question_id), 'question_moderation', true) ?>' class='icon_qa_edit buttonlink'><?php echo $this->translate('Edit Entry');?></a></li>
                    <?php endif; ?>

                    <?php if ($question->status == 'open' and $question->User_can($this->viewer(), 'cancel')): ?>
                      <li><?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question', 'controller' => 'smoothbox', 'action' => 'cancel', 'id' => $question->question_id),  $this->translate('Cancel'), array('class' => 'smoothbox icon_qa_cancel buttonlink')) ?></li>
                    <?php endif; ?>

                    <?php if ($question->status != 'open' and $question->User_can($this->viewer(), 'reopen')): ?>
                      <li><?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question', 'controller' => 'smoothbox', 'action' => 'reopen', 'id' => $question->question_id),  $this->translate("Reopen"), array('class' => 'smoothbox icon_qa_reopen buttonlink')) ?></li>
                    <?php endif; ?>

                    <?php if ($question->User_can($this->viewer(), 'del')): ?>
                       <li><?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question', 'controller' => 'smoothbox', 'action' => 'deleteq', 'id' => $question->question_id), $this->translate('Delete'), array('class' => 'smoothbox icon_qa_delete buttonlink')) ?></li>
                    <?php endif; ?>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          <div class='qa_browse_photo'>
			<div class='qa_browse_additional_info'>
              <ul>
                <li><a href="<?php echo $question->getHref() ?>"><?php echo $this->translate(array("%d <br /> Answer", "%d <br />Answers", $question->count_answers), $question->count_answers)?></a></li>
                <li><?php echo $this->translate(array('%s <br /> View', '%s <br /> Views', $question->question_views), $question->question_views) ?></li>
              </ul>
            </div>
          </div>
           
        <div class='qa_browse_info'>
            <span class="qa_title"><strong><?php echo $this->htmlLink($question->getHref(), $question->getTitle()); ?></strong></span>
            <p class='qa_browse_info_date qa_browse_info_date_top'>
				<?php echo $this->translate('by %s', $question->getOwnerUser()->toString()) ?>
				<?php
                    if ($this->isEnabledCategories) {
                        $tmp_categories = $this->categories->getRowMatching('category_id', $question->category_id);
                        if (is_object($tmp_categories))
                                echo $this->translate('in %s', $this->htmlLink(array('category' => $tmp_categories->url, 'reset' => false), $this->translate($tmp_categories->category_name)));
                    }
				?>
				<?php echo $this->translate('about %s', $this->timestamp($question->creation_date)) ?>
				<span class="qa_question_status <?php if($question->status != 'open') {echo 'closed-quest';}?>"><?php echo $this->translate('%s', $this->translate($question->status))?></span>
            </p>
            <?php
				if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) :
					$tags = $question->gettags();
					if ($tags !== null and count($tags)):
			?>
					<div class='question-tags'>
                        <?php foreach ($tags as $tag): ?>
                              <a href='javascript:void(0);' onclick='javascript:searchTagAction("<?php echo $tag->getTag()->text; ?>");'><?php echo $tag->getTag()->text?></a>
                        <?php endforeach; ?>
					</div>        
					<?php endif; ?>
			<?php endif; ?>
        </div>

        <div class="qa-clearfix"></div>

      </li>
    <?php endforeach; ?>
  </ul>
  
  <?php if( $this->paginator->count() >= 1): ?>
    <div>
<?php echo $this->paginationControl($this->paginator, null, null, array(
  'query' => $this->formValues
)); ?>
    </div>
  <?php endif; ?>

<?php elseif( $this->category || $this->show == 2 || $this->search || $this->status ):?>
    <div class="tip">
      <span>
        <?php echo $this->translate('Nobody has posted a questions in this category yet. Be the first to %1$spost%2$s one!', '<a href="'.$this->url(array('action' => 'create')).'">', '</a>');?>
      </span>
    </div>
  <?php else:?>
    <div class="tip">
      <span>
        <?php echo $this->translate('Nobody has written a question entry yet.'); ?>
        <?php if ($this->can_create): // @todo check if user is allowed to create a poll ?>
          <?php echo $this->translate('Be the first to %1$swrite%2$s one!', '<a href="'.$this->url(array('action' => 'create')).'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
  <?php endif; ?>