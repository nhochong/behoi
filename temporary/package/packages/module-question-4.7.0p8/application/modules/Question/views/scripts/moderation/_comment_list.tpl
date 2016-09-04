<ul>
<?php $this->headTranslate(array(
  'Are you sure you want to delete this?',
)); ?>

    <?php if( $this->comments->getTotalItemCount() > 0 ): // COMMENTS ------- ?>

      <?php // Iterate over the comments backwards (or forwards!)

      foreach ( $this->comments as $comment):
        $poster = $this->item($comment->poster_type, $comment->poster_id);
    ?>
        <li id="comment-<?php echo $comment->comment_id ?>" style="clear: both;">
          <div class="comments_author_photo">
            <?php echo $this->htmlLink($poster->getHref(), $this->itemPhoto($poster, 'thumb.icon')) ?>
          </div>
          <div class="comments_info">
              <span class="comments_author"><?php echo $this->translate('by %s', $poster->toString()) ?></span>
              <div class="comments_date"><?php echo $this->translate('%s ', $this->timestamp($comment->creation_date)) ?> -
                <a href="javascript:void(0);" onclick="question.comments.deleteComment('<?php echo $this->subject->getType()?>', '<?php echo $this->subject->getIdentity() ?>', '<?php echo $comment->comment_id ?>')">
                    <?php echo $this->translate('delete') ?>
                </a> - 
                <a href="javascript:void(0);" onclick="moderation.comment_move_answers('<?php echo $comment->comment_id ?>')">
                    <?php echo $this->translate('make answer from this comment') ?>
                </a> -
                <a href="javascript:void(0);" onclick="moderation.comment_move_comments('<?php echo $comment->comment_id ?>', '<?php echo $comment->resource_id ?>')">
                    <?php echo $this->translate('move to other answer') ?>
                </a>
              </div>

            <p class="comments_post"><?php echo $comment->body; ?></p>
          </div>
        </li>
      <?php endforeach; ?>

    <?php endif; ?>
</ul>