





<ul>
  <?php foreach( $this->paginator as $answer ): ?>
    <li>
      <div class='qa_browse_photo'>
        <?php echo $this->htmlLink($answer->getOwnerUser()->getHref(), $this->itemPhoto($answer->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($answer->getOwnerUser())))) ?>
      </div>
    <div class='qa_browse_info'>
      <div class='qa_browse_info_blurb'>
     	<?php echo $this->htmlLink($answer->getQuestionHref(), $answer->getShortAnswer(100)); ?>
      </div>
      <p class='qa_browse_info_date'>
        <?php echo $this->translate("Posted_by %s about %s", $answer->getOwnerUser()->toString(), $this->timestamp($answer->creation_date)) ?>
                
		<?php /*
        Votes: +<span id="+_<?php echo $answer->answer_id ?>"><?php echo $answer->getVotes('+') ?></span>, -<span id="-_<?php echo $answer->answer_id ?>"><?php echo $answer->getVotes('-') ?></span>
		*/ ?>
      </p>
    </div>
    </li>
  <?php endforeach; ?>
</ul>