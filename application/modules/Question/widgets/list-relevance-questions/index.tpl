<ul>
  <?php foreach( $this->paginator as $question ): ?>
      <li>
          <div class='qa_browse_photo'>
            <?php echo $this->htmlLink($question->getOwnerUser()->getHref(), $this->itemPhoto($question->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($question->getOwnerUser())))) ?>
          </div>
          <div class='qa_browse_info'>
          <div class='qa_browse_info_blurb'>
            <?php if (strtotime($question->creation_date) >= $this->hours_new_label): ?>  
              <span><?php echo $this->translate("New")?></span>
            <?php endif;?>  
            <?php echo $this->htmlLink($question->getHref(), $question->getTitle()); ?>
          </div>
          <p class='qa_browse_info_date'>
            <?php echo $this->translate("Answers: %d", $question->count_answers)?> -
            <?php echo $this->translate("Score:") ?> <?php echo $question->getVotes('all') ?> -
            <?php echo $this->translate('Views: %s', $question->question_views) ?><br />
            <?php echo $this->translate('Posted by %s about %s ', $question->getOwnerUser()->toString(), $this->timestamp($question->creation_date)) ?>
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
</ul>
