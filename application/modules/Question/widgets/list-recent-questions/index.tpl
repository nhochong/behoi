<ul>
  <?php foreach( $this->paginator as $question ): ?>
      <li>
          <div class='qa_browse_photo'>
            <?php echo $this->htmlLink($question->getOwnerUser()->getHref(), $this->itemPhoto($question->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($question->getOwnerUser())))) ?>
          </div>
          <div class='qa_browse_info'>
          <div class='qa_browse_info_blurb'>
            <?php echo $this->htmlLink($question->getHref(), Engine_Api::_()->core()->subPhrase($question->getTitle(), 50), array('title' => $question->getTitle()) ); ?>
          </div>
          <p class='qa_browse_info_date'>
            <?php echo $this->translate("Answers: %d", $question->count_answers)?> -
            <?php echo $this->translate("Views:") ?> <?php echo $question->question_views ?>
          </p>

        </div>
      </li>
  <?php endforeach; ?>
</ul>