<span class="pulldown">
<a href="javascript:void(0)" onclick="javascript:$('qa_answers').setStyle('display','none');$('qa_questions').setStyle('display','block');"><?php echo $this->translate('Questions'); ?> (<?php echo $this->paginator->getTotalItemCount() ?>)</a>
<a href="javascript:void(0)" onclick="javascript:$('qa_questions').setStyle('display','none');$('qa_answers').setStyle('display','block');"><?php echo $this->translate('Answers'); ?> (<?php echo $this->paginator_answer->getTotalItemCount() ?>)</a>
</span>

<br /><br />

<div id="qa_questions">
<h3><?php echo $this->translate('Questions:'); ?></h3>
  <ul class="qa_browse">
  <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

    <?php foreach ($this->paginator as $question): ?>
      <li>
        <div class='qa_browse_info'>
          <div class='qa_browse_info_blurb'>
            <strong><?php echo $this->htmlLink($question->getHref(), $question->getTitle()); ?></strong>
          </div>
          <p class='qa_browse_info_date'>
  			<?php echo $this->translate('Views: %s -', $question->question_views) ?>
              <?php echo $this->translate('Answers: %d -', $question->count_answers)?>
              
              <?php if ($question->issetVotes()): ?>
                <a class="smoothbox" href="<?php echo $this->url(array('type' => 'question', 'id' => $question->getIdentity()), 'who_voted')  ?>">
                    <?php echo $this->translate("Score:") ?>
                    <?php echo $question->getVotes('all') ?>
                </a>
            <?php else: ?>
                <?php echo $this->translate("Score:"); ?>
                0
            <?php endif; ?>
              <br />
            <?php echo $this->translate('Posted');?> <?php echo $this->timestamp($question->creation_date) ?>
         
          <?php
                  if ($this->isEnabledCategories) {
                      $tmp_categories = $this->categories->getRowMatching('category_id', $question->category_id);
                      if (is_object($tmp_categories))
                              echo $this->translate('in %s', $this->htmlLink(array('route' => 'default', 'module' => 'question', 'category' => $tmp_categories->url, 'reset' => true), $this->translate($tmp_categories->category_name)));
                  }
              ?>
               
               

            
            </p>
        </div>
      </li>

    <?php endforeach; ?>
   

  <?php if($this->paginator->getTotalItemCount() > $this->items_per_page):?>
    <?php echo $this->htmlLink($this->url(array('user_id' => Engine_Api::_()->core()->getSubject()->getIdentity()), 'user_questions'), $this->translate('View All Entries'), array('class' => 'buttonlink icon_qa_viewall')) ?>
  <?php endif;?>
  <?php else:?>
  <li class="tip" >
        <span>
          <?php echo $this->translate('Question entries not found.'); ?>
        </span>
  </li>

  <?php endif; ?>
  </ul>
</div>

<div id="qa_answers" style="display: none;">
  <h3><?php echo $this->translate('Answers'); ?>:</h3>
  <ul class="qa_browse">
  <?php if( $this->paginator_answer->getTotalItemCount() > 0 ): ?>

    <?php foreach( $this->paginator_answer as $answer ): ?>
      <li>
      <div class='qa_browse_info'>
        <div class='qa_browse_info_blurb'>
       <strong><?php echo $this->htmlLink($answer->getQuestionHref(), $answer->getShortAnswer(100)); ?></strong>
        </div>
        <p class='qa_browse_info_date'>
          <?php echo $this->translate('Posted %s -', $this->timestamp($answer->creation_date)) ?>

          <?php if ($answer->issetVotes()): ?>
              <a class="smoothbox" href="<?php echo $this->url(array('type' => 'answer', 'id' => $answer->getIdentity()), 'who_voted')  ?>">
                  <?php echo $this->translate("Score:") ?>
                  <span id="answervoite_likes_<?php echo $answer->answer_id ?>">
                      <?php echo $answer->getVotes('all') ?>
                  </span>
              </a>
          <?php else: ?>
              <?php echo $this->translate("Score:"); ?>
              <span id="answervoite_likes_<?php echo $answer->answer_id ?>">0</span>
          <?php endif; ?>

        </p>
      </div>
      </li>
    <?php endforeach; ?>

  <?php if($this->paginator_answer->getTotalItemCount() > $this->items_per_page):?>
    <?php echo $this->htmlLink($this->url(array('user_id' => Engine_Api::_()->core()->getSubject()->getIdentity()), 'answers'), $this->translate('View All Entries'), array('class' => 'buttonlink icon_qa_viewall')) ?>
  <?php endif;?>

  <?php else:?>
      <li class="tip" >
        <span>
          <?php echo $this->translate('No answers yet.'); ?>
        </span>
    </li>

  <?php endif; ?>
  </ul>
</div>
