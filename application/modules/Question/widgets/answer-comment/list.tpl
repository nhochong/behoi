<script type="text/javascript">

  en4.core.runonce.add(function() {
    // Scroll to comment
    if( window.location.hash != '' ) {
      var hel = $(window.location.hash);
      if( hel ) {
        window.scrollTo(hel);
      }
    }
   
  });
</script>

<?php $this->headTranslate(array(
  'Are you sure you want to delete this?',
)); ?>

<?php if( !$this->page ): ?>
<div class='comments' id="comments_<?php echo $this->item_id?>">
<?php endif; ?>
  <div class='comments_options'>
    <?php if( isset($this->form) ): ?>
      <a href='javascript:void(0);' onclick="$('comment-form_<?php echo $this->item_id?>').style.display = '';$('comment-form_<?php echo $this->item_id?>').body.focus();"><?php echo $this->translate('Post Comment') ?></a>
      <div style="clear:both;"></div>
    <?php endif; ?>
    
    <?php if ($this->comments->getTotalItemCount()):?>
      <span id="count_comments_<?php echo $this->item_id?>"><?php echo $this->translate(array('%s comment', '%s comments', $this->comments->getTotalItemCount()), $this->locale()->toNumber($this->comments->getTotalItemCount())) ?></span> 
    <?php endif;?>


  </div>
  <ul>
    <?php if( $this->comments->getTotalItemCount() > 0 ): // COMMENTS ------- ?>

      <?php if( $this->page && $this->comments->getCurrentPageNumber() > 1 ): ?>
        <li>
          <div> </div>
          <div class="comments_viewall">
            <?php echo $this->htmlLink('javascript:void(0);', $this->translate('View previous comments'), array(
              'onclick' => 'question.comments.loadComments("'.$this->subject->getType().'", "'.$this->subject->getIdentity().'", "'.($this->page - 1).'")'
            )) ?>
          </div>
        </li>
      <?php endif; ?>

      <?php if( !$this->page && $this->comments->getCurrentPageNumber() < $this->comments->count() ): ?>
        <li>
          <div> </div>
          <div class="comments_viewall">
            <?php echo $this->htmlLink('javascript:void(0);', $this->translate('View more comments'), array(
              'onclick' => 'question.comments.loadComments("'.$this->subject->getType().'", "'.$this->subject->getIdentity().'", "'.($this->comments->getCurrentPageNumber()).'")'
            )) ?>
          </div>
        </li>
      <?php endif; ?>

      <?php // Iterate over the comments backwards (or forwards!)
      $comments = $this->comments->getIterator();
      if( $this->page ):
        $i = 0;
        $l = count($comments) - 1;
        $d = 1;
        $e = $l + 1;
      else:
        $i = count($comments) - 1;
        $l = count($comments);
        $d = -1;
        $e = -1;
      endif;
      for( ; $i != $e; $i += $d ):
        $comment = $comments[$i];
        $poster = $this->item($comment->poster_type, $comment->poster_id);
        $canDelete = ( $this->canDelete || $poster->isSelf($this->viewer()) );
        ?>
        <li id="comment-<?php echo $comment->comment_id ?>">
          <div class="comments_author_photo">
            <?php echo $this->htmlLink($poster->getHref(),
              $this->itemPhoto($poster, 'thumb.icon', $poster->getTitle())
            ) ?>
          </div>
          <div class="comments_info">
            <span class='comments_author'>by <?php echo $this->htmlLink($poster->getHref(), $poster->getTitle()); ?></span>
            <div class="comments_date">
              <?php echo $this->timestamp($comment->creation_date); ?>
              <?php if( $canDelete ): ?>
                -
                <a href="javascript:void(0);" onclick="question.comments.deleteComment('<?php echo $this->subject->getType()?>', '<?php echo $this->subject->getIdentity() ?>', '<?php echo $comment->comment_id ?>')">
                  <?php echo $this->translate('delete') ?>
                </a>
              <?php endif; ?>
            </div>
            <p class="comments_post"><?php echo $this->viewMore($comment->body) ?></p>    
          </div>
        </li>
      <?php endfor; ?>

      <?php if( $this->page && $this->comments->getCurrentPageNumber() < $this->comments->count() ): ?>
        <li>
          <div> </div>
          <div class="comments_viewall">
            <?php echo $this->htmlLink('javascript:void(0);', $this->translate('View later comments'), array(
              'onclick' => 'question.comments.loadComments("'.$this->subject->getType().'", "'.$this->subject->getIdentity().'", "'.($this->page + 1).'")'
            )) ?>
          </div>
        </li>
      <?php endif; ?>

    <?php endif; ?>

  </ul>
  <script type="text/javascript">
    en4.core.runonce.add(function(){
      $($('comment-form_<?php echo $this->item_id?>').body).autogrow();
      question.comments.attachCreateComment($('comment-form_<?php echo $this->item_id?>'));
    });
  </script>
  <?php if( isset($this->form) ) echo $this->form->setAttribs(array('id' => 'comment-form_'.$this->item_id, 'style' => 'display:none;'))->render() ?>
<?php if( !$this->page ): ?>
</div>
    <?php endif; ?>
