<div class="layout_user_list_most_popular">
<ul>
  <?php foreach( $this->paginator as $question ): ?>
      <li>
          <div class='qa_browse_info'>
          <div class='qa_browse_info_blurb'>
            <?php echo $this->htmlLink($question->getHref(), Engine_Api::_()->core()->subPhrase($question->getTitle(), 60), array('title' => $question->getTitle()) ); ?>
          </div>
          <p class='qa_browse_info_date'>
            <?php echo $this->translate("Answers: %d", $question->count_answers)?> -
            <?php echo $this->translate("Views:") ?> <?php echo $question->question_views ?>
          </p>

        </div>
      </li>
  <?php endforeach; ?>
</ul>
</div>