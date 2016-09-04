<?php $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/question_core.js') ?>

  <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>

  <table width="95%" border="0" class="qa_rating" cellpadding="0" cellspacing="0">
    <?php foreach( $this->paginator as $rating ): ?>
    
      <tr class='rating_user <?php if ($rating->isOwner($this->viewer())):?>active_user<?php endif;?>'>
         <td class="qa_user_rate"><?php echo $rating->rownum ?></td>
         <td class="qa_user_thumb">
             <?php echo $this->htmlLink($rating->getOwner()->getHref(), $this->itemPhoto($rating->getOwner(), 'thumb.icon')) ?>
         </td>
         <td class="userdata">
            <div class="title_rate">
	         <?php $owner = $rating->getOwner() ?>            
                 <?php echo $owner->toString() ?>            
            </div> 
            <div class="totalpoints">
				 <?php echo $this->translate('Total Points:'); ?> <?php echo $rating->total_points ?>
            </div>     
            <div class="rate_info">
	         <?php echo $this->translate('Questions:'); ?> <?php echo $rating->total_questions ?> -
                 <?php echo $this->translate("Answers: %d - ", $rating->total_answers); ?>
                 <?php echo $this->translate('Best Answers:'); ?> <?php echo $rating->total_best_answers ?>
            </div> 
            </td>

            <td class="addfriend">
            <?php if ($this->viewer()->getIdentity() and !$rating->isOwner($this->viewer())): ?>            
                <?php echo $this->membership($rating->getOwner(), $this->viewer()) ?>
            <?php endif;?>                
            </td>

     </tr>
    <?php endforeach; ?>

  </table>

  
  <?php else:?>
    <div class="tip">
      <span>
        <?php echo $this->translate('No ratings are available yet.'); ?>
      </span>
    </div>
  <?php endif; ?>
  
   <?php if( $this->paginator->count() >= 1): ?>
    <div>
      <?php echo $this->paginationControl($this->paginator, null, 'pagination/questionpagination.tpl'); ?>
    </div>
    <br />
  <?php endif; ?>