<?php
    $script = "window.addEvent('load', function() {
                  new Tips('.tips_qa_top');
                 });";
    $this->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());
?>
<ul>
  <?php foreach( $this->users as $user_rating ): ?>
    <?php $user = $user_rating->getOwner() ?>
    <li>
      <div class='qa_browse_photo'>
          <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon'), array('class' => 'popularmembers_thumb')) ?>
      </div>
      <div class='qa_browse_info'>
        <div class='qa_top_members_name'>
          <?php echo $this->htmlLink($user->getHref(), $user->getTitle()) ?>
          <br/>
        </div>
        <div class="totalpoints">
            <div>
                <?php echo $this->translate('Total Points:'); ?> <?php echo $user_rating->total_points ?>
            </div>
            <span>
                <?php echo $this->translate('Questions:'); ?> <?php echo $user_rating->total_questions ?> - 
            </span>
            <span>
                <?php echo $this->translate('Answers: %d', $user_rating->total_answers); ?> - 
            </span>
            <span>
                <?php echo $this->translate('Best Answers:'); ?> <?php echo $user_rating->total_best_answers ?>
            </span>
        </div>
      </div>

    </li>
  <?php endforeach; ?>
</ul>
