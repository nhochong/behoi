<?php $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/question_core.js') ?>

<?php if (isset($this->owner)): ?>
 <h2>
    <?php echo $this->translate('%1$s\'s Answers', $this->htmlLink($this->owner->getHref(), $this->owner->getTitle()))?>
  </h2>
<?php endif; ?>
<form action="<?php echo $this->url(array('user_id' => $this->owner->getIdentity()), 'answers') ?>" method="post" enctype="application/x-www-form-urlencoded" id="filter_form" name="filter_form">
    <input type="hidden" value="" id="page" name="page"/>
</form>

  <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>


  <ul class="qa_browse">
    <?php foreach( $this->paginator as $answer ): ?>
      <li>
    <div class='qa_browse_info'>
      <div class='qa_browse_info_blurb'>
     <strong><?php echo $this->htmlLink($answer, $answer->getShortAnswer(100)); ?></strong>
      </div>
      <p class='qa_browse_info_date'>
        <?php echo $this->translate('Posted by %s about %s -', $answer->getOwnerUser()->toString(), $this->timestamp($answer->creation_date)) ?>
        <?php echo $this->translate("Score: %s", $answer->getVotes('all')) ?>
      </p>
    </div>
    </li>
    <?php endforeach; ?>
  </ul>
  


  <?php else:?>
    <div class="tip">
      <span>
        <?php echo $this->translate('No answers yet'); ?>
      </span>
    </div>
  <?php endif; ?>
  
  <?php if( $this->paginator->count() >= 1): ?>
    <div>
      <?php echo $this->paginationControl($this->paginator, null, 'pagination/questionpagination.tpl'); ?>
    </div>
  <?php endif; ?>