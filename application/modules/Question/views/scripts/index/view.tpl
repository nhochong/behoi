<?php $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/question_core.js') ?>
<script type="text/javascript">
	en4.core.runonce.add(function() {
		window.addEvent('domready',function(event){
			$$('#answer-element span#answer_parent').setStyle('background', '#f00');
		});
	});
</script>
<?php
	$script = "window.addEvent('load', function() {
	       new Tips($$('.Tips'));
	       myquestion = new question ({
	        question_id:{$this->question->question_id},
	        url: '{$this->url(array('module'=>'question','controller'=>'index','action'=>'voite'), 'default') }',
	        lang:{
	            'voted' : '{$this->string()->escapeJavascript($this->translate('You already voted for this answer.'))}',
	            'like' : '{$this->string()->escapeJavascript($this->translate("Like"))}'
	           }
	       });
	       });";
	$this->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());
	$this->headTranslate(array("Unsubscribe"));
	?>
<?php if (is_array($this->files)) {
	$this->headLink()->appendStylesheet($this->baseUrl() . '/application/modules/Question/externals/styles/SqueezeBox.css');
	$this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/SqueezeBox/SqueezeBox.js');
	
	$script = "window.addEvent('domready', function() {
	     SqueezeBox.assign($$('a[rel=boxed]'));
	
	     });";
	$this->headScript()->appendScript($script, $type = 'text/javascript', $attrs = array());
	
	} ?>
<form method="POST" enctype="multipart/form-data" style="display:none;" name="filter_form" id="filter_form" action="<?php echo $this->url(array('question_id' => $this->question->question_id), 'question_view', true) ?>">
	<input type="hidden" name="page" value="" id="page"/>
	<input type="hidden" name="order" value="<?php echo $this->browse_by->getValue()?>" id="order"/>
</form>
<form action="<?php echo $this->url(array('module'=>'question','controller'=>'index','action'=>'index'), 'default') ?>" method="post" enctype="application/x-www-form-urlencoded" id="filter_form_q" name="filter_form_q">
	<input type="hidden" value="" id="tags" name="tags"/>
</form>
<?php $settings = Engine_Api::_()->getApi('settings', 'core'); ?>
<div class="qa_question_body">
	<?php
		if( !empty($this->addition_menu_params) ) :
			$navigation = new Zend_Navigation();
			$navigation->addPages($this->addition_menu_params);
		?>
	<div class="manage_addition_menu">
		<div class="pulldown_contents_wrapper">
			<div class="pulldown_contents">
				<?php echo $this->navigation()->menu()->setContainer($navigation)->render(); ?>
			</div>
		</div>
	</div>
	<?php endif; ?>
	<div class='qa_browse_photo'>
		<?php echo $this->htmlLink($this->question->getOwnerUser()->getHref(), $this->itemPhoto($this->question->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($this->question->getOwnerUser())))) ?>
		<span><span><em class="Tips" title="<?php echo $this->translate('User Points') ?>" id="qa_user_id_<?php echo $this->question->getOwner()->getIdentity() ?>"><?php echo Engine_Api::_()->question()->get_user_points($this->question->getOwner()->getIdentity()) ?></em></span></span>
		<div id="questionvoite_<?php echo $this->question->getIdentity(); ?>" class="qa_votes">
			<ul>
				<?php if (($can_qvote_up = Engine_Api::_()->question()->can_qvote_up()) === true): ?>
				<li id="questionvoite_up_<?php echo $this->question->getIdentity() ?>">
					<a href="javascript:void(0);" onclick="myquestion.question_voite('+');" class="qa_like_btn"></a>
					<?php else: ?>
				<li id="questionvoite_up_<?php echo $this->question->getIdentity() ?>" <?php echo Engine_Api::_()->question()->get_qvoted() === true ? 'class="voted"' : '' ?>>
					<span class="qa_like_btn Tips" title="<?php echo Engine_Api::_()->question()->getstatus_message($can_qvote_up) ?>"></span>
					<?php endif; ?>
				</li>
				<li id="questionvoite_down_<?php echo $this->question->getIdentity() ?>" <?php echo Engine_Api::_()->question()->get_qvoted() === false ? 'class="voted"' : '' ?>>
					<?php if (($can_qvote_down = Engine_Api::_()->question()->can_qvote_down()) === true): ?>
					<a href="javascript:void(0);" onclick="myquestion.question_voite('-');" class="qa_unlike_btn"></a>
					<?php else: ?>
					<span class="qa_unlike_btn Tips" title="<?php echo Engine_Api::_()->question()->getstatus_message($can_qvote_down) ?>"></span>
					<?php endif; ?>
				</li>
			</ul>
		</div>
	</div>
	<div class='qa_browse_info'>
		<?php if (trim($this->question->title)): ?>
			<p class="qa_title"><strong><?php echo $this->question->title ?></strong></p>
		<?php endif; ?>
		<p class='qa_browse_info_date qa_browse_info_date_top'>
			<?php echo $this->translate('by %s', $this->question->getOwnerUser()->toString()) ?>
			<?php
				if ($this->isEnabledCategories) {
				    $tmp_categories = $this->categories->getRowMatching('category_id', $this->question->category_id);
				    if (is_object($tmp_categories))
				       echo $this->translate('in %s ', $this->htmlLink(array('route' => 'default', 'module' => 'question', 'category' => $tmp_categories->url, 'reset' => true), $tmp_categories->category_name));
				}
				?>
			<?php echo $this->translate('about %s', $this->timestamp($this->question->creation_date)) ?>
			<span class="qa_question_status <?php if($this->question->status != 'open') {echo 'closed-quest';}?>"><?php echo $this->translate('%s', $this->translate($this->question->status))?></span>
			- <?php echo $this->htmlLink(Array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'route' => 'default', 'subject' => $this->question->getGuid(), 'format' => 'smoothbox'), $this->translate("report"), array('class' => 'smoothbox')); ?>
		</p>
		<span class='qa_title_descr'><?php echo $this->question->getQuestion() ?></span>
		<?php if (is_array($this->files)):
			$file_api = Engine_Api::_()->getApi('storage', 'storage');
			?>
		<div>
			<ul class="attached-images">
				<?php foreach($this->files as $data_file) :
					$file_thumb = $file_api->get($data_file, 'thumb.normal');
					$file = $file_api->get($data_file);
					if( !$file ) {continue; }
					?>
				<li>
					<a rel="boxed" href="<?php echo strtok($file->map(), '?'); ?>">
						<img src="<?php echo $file_thumb->map(); ?>" class="photo" />
					</a>
				</li>
				<?php endforeach;?>
			</ul>
		</div>
		<div style="clear: both;"></div>
		<?php endif; ?>
		<?php
			if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) :
			    $tags = $this->question->gettags();
			    if ($tags !== null and count($tags)):
			?>
		<div class='question-tags single-question'>
			<?php foreach ($tags as $tag): ?>
			<a href='javascript:void(0);' onclick='javascript:searchTagAction("<?php echo $tag->getTag()->text; ?>");'><?php echo $tag->getTag()->text?></a>
			<?php endforeach; ?>
		</div>
		<?php endif; ?>
		<?php endif; ?>   
		<?php if ($this->viewer()->getIdentity() > 0) : ?>
		<p class="subscr-btn">
			<button id="question_subscribe_toggle" onclick="javascript:myquestion.subscribertoggle();">
			<?php if( $this->question->isSubscriber($this->viewer())): ?>
			<?php echo $this->translate("Unsubscribe")?>
			<?php else: ?>
			<?php echo $this->translate("Subscribe")?>
			<?php endif; ?>
			</button>
		</p>
		<?php endif ?>
	</div>
</div>
<?php if( $this->message ): ?>
<div class='result_message'>
	<ul class="form-notices">
		<li><?php echo $this->message ?></li>
	</ul>
</div>
<br/>
<?php endif; ?>
<?php $count_answers = (isset ($this->best_answer)) ? $this->paginator->getTotalItemCount() + 1 : $this->paginator->getTotalItemCount();?>
<?php if( $count_answers > 0 ): ?>
<div class="qa_answers">
	<div class="qa_answers_list">
		<?php echo $this->translate(array("Answer: %d", "Answers: %d", $count_answers), $count_answers)?>
		&bull;
		<?php echo $this->translate('Views: %s', $this->question->question_views) ?>
	</div>
</div>
<ul class="qa_browse">
	<?php if( isset ($this->best_answer)): ?>
	<li id="<?php echo $this->best_answer->answer_id ?>" class="qa_best_a">
		<div class='qa_browse_photo'>
			<?php echo $this->htmlLink($this->best_answer->getOwnerUser()->getHref(), $this->itemPhoto($this->best_answer->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($this->question->getOwnerUser())))) ?>
			<span><span><em class="Tips" id="qa_user_id_<?php echo $this->best_answer->getOwner()->getIdentity() ?>" title="<?php echo $this->translate('User Points') ?>"><?php echo Engine_Api::_()->question()->get_user_points($this->best_answer->getOwner()->getIdentity()) ?></em></span></span>
			<div class="qa_votes">
				<ul>
					<li class="Tips" title="<?php echo $this->translate('Question was closed.') ?>"><span class="qa_like_btn"></span></li>
					<li class="Tips" title="<?php echo $this->translate('Question was closed.') ?>"><span class="qa_unlike_btn"></span></li>
				</ul>
			</div>
		</div>
		<div class='qa_browse_info'>
		<p class='qa_browse_info_date qa_browse_info_date_top'>
			<?php echo $this->translate('by %s about %s ', $this->best_answer->getOwnerUser()->toString(), $this->timestamp($this->best_answer->creation_date)) ?>
			<span class="qa_best_answer"><?php echo $this->translate("Best answer") ?></span>
		</p>
		<div class='qa_browse_info_blurb'><?php echo nl2br($this->best_answer->answer); ?></div>
		<div class="qa_votes">
			<ul>
				<li class="qtt_kudos">
					<span>
					<strong>
					<?php if ($this->best_answer->issetVotes()): ?>
					<a class="smoothbox" href="<?php echo $this->url(array('type' => 'answer', 'id' => $this->best_answer->getIdentity()), 'who_voted') ?>">
					<?php echo $this->translate("Score:") ?> 
					<span>
					<?php echo $this->best_answer->getVotes('all') ?>
					</span>
					</a>
					<?php else: ?>
					<?php echo $this->translate("Score:"); ?> 
					<span>0</span>
					<?php endif; ?>
					</strong>
					</span>
				</li>
			</ul>
		</div>
		<?php echo $this->RenderSimpleWidget('question.answer-comment', array('action' => 'list',"type"=>"answer", "id"=>$this->best_answer->answer_id)); ?>
	</li>
	<?php endif; ?>
	<?php foreach( $this->paginator as $answer ): ?>
	<li id="<?php echo $answer->answer_id ?>">
		<div class='qa_browse_photo'>
			<?php echo $this->htmlLink($answer->getOwnerUser()->getHref(), $this->itemPhoto($answer->getOwnerUser(), 'thumb.icon'), array('class' => strtolower('qa_ownerphoto_' . get_class($this->question->getOwnerUser())))) ?>
			<span><span><em class="Tips" id="qa_user_id_<?php echo $answer->getOwner()->getIdentity() ?>" title="<?php echo $this->translate('User Points') ?>"><?php echo Engine_Api::_()->question()->get_user_points($answer->getOwner()->getIdentity()) ?></em></span></span>
			<div id="answervoite_<?php echo $answer->answer_id ?>" class="qa_votes">
				<ul>
					<?php if (($can_vote_up = Engine_Api::_()->question()->can_vote_up($answer)) === true): ?>
					<li id="answervoite_up_<?php echo $answer->answer_id ?>">
						<a href="javascript:void(0);" onclick="myquestion.answer_voite(<?php echo $answer->answer_id ?>,'+');" class="qa_like_btn"></a>
						<?php else: ?>
					<li id="answervoite_up_<?php echo $answer->answer_id ?>" <?php echo Engine_Api::_()->question()->get_voted($answer) === true ? 'class="voted"' : '' ?>>
						<span class="qa_like_btn Tips" title="<?php echo Engine_Api::_()->question()->getstatus_message($can_vote_up) ?>"></span>
						<?php endif; ?>         
					</li>
					<li id="answervoite_down_<?php echo $answer->answer_id ?>" <?php echo Engine_Api::_()->question()->get_voted($answer) === false ? 'class="voted"' : '' ?>>
						<?php if (($can_vote_down = Engine_Api::_()->question()->can_vote_down($answer)) === true): ?>
						<a href="javascript:void(0);" onclick="myquestion.answer_voite(<?php echo $answer->answer_id ?>,'-');" class="qa_unlike_btn"></a>
						<?php else: ?>
						<span class="qa_unlike_btn Tips" title="<?php echo Engine_Api::_()->question()->getstatus_message($can_vote_down) ?>"></span>
						<?php endif; ?>         
					</li>
				</ul>
			</div>
		</div>
		<div class='qa_browse_info'>
			<div class='qa_browse_info_blurb'>
				<div class="manage_addition_menu">
					<div class="pulldown_contents_wrapper">
						<div class="pulldown_contents">
							<ul class="navigation">
								<?php if (Engine_Api::_()->question()->can_delete_answer($answer) === true): ?>
								<li>
									<?php echo $this->htmlLink(array('route' => 'default', 'module' => 'question', 'controller' => 'smoothbox', 'action' => 'delete', 'id' => $answer->answer_id), $this->translate("delete"), array('class' => 'smoothbox buttonlink icon_qa_delete')) ?>
								</li>
								<?php endif; ?>
								<li>
									<?php echo $this->htmlLink(Array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'route' => 'default', 'subject' => $answer->getGuid(), 'format' => 'smoothbox'), $this->translate("report"), array('class' => 'smoothbox buttonlink icon_qa_report')); ?>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<p class='qa_browse_info_date qa_browse_info_date_top'>
					<?php echo $this->translate('by %s about %s ', $answer->getOwnerUser()->toString(), $this->timestamp($answer->creation_date)) ?>
					<?php if ($this->can_choose_answer): ?>
					<?php echo $this->htmlLink(array('route' => 'choose', 'best_id' => $answer->answer_id), $this->translate('Choose as the best answer'), array('class' => 'qa_best_answer')) ?>
					<?php endif; ?>
				</p>
				<?php echo $answer->answer; ?>
			</div>
			<div id="answervoite_<?php echo $answer->answer_id ?>" class="qa_votes">
				<ul>
					<li class="qtt_kudos">
						<span>
						<strong>
						<?php if ($answer->issetVotes()): ?>
						<a class="smoothbox" href="<?php echo $this->url(array('type' => 'answer', 'id' => $answer->getIdentity()), 'who_voted') ?>">
						<?php echo $this->translate("Score:") ?> 
						<span id="answervoite_likes_<?php echo $answer->answer_id ?>">
						<?php echo $answer->getVotes('all') ?>
						</span>
						</a>
						<?php else: ?>
						<?php echo $this->translate("Score:"); ?>
						<span id="answervoite_likes_<?php echo $answer->answer_id ?>">0</span>
						<?php endif; ?>
						</strong>
						</span>
					</li>
				</ul>
			</div>
			<div style="clear:both;"></div>
			<?php echo $this->RenderSimpleWidget('question.answer-comment', array('action' => 'list',"type"=>"answer", "id"=>$answer->answer_id)); ?>
		</div>
	</li>
	<?php endforeach; ?>
</ul>
<?php if( $this->paginator->count() >= 1): ?>
<div style="margin-bottom:10px;">
	<?php echo $this->paginationControl($this->paginator, null, 'pagination/questionpagination.tpl'); ?>
</div>
<?php endif; ?>
<?php else:?>
<div class="tip">
	<span>
	<?php echo $this->translate('No answers yet. Be the first!'); ?>
	</span>
</div>
<?php endif; ?>
<div class="qa_create_answer">
	<?php if ($this->can_answer === 0) echo $this->createanswer->render($this);
		else echo '<div class="tip"><span>' . Engine_Api::_()->question()->getstatus_message($this->can_answer) . '</span></div>';
		
		?>
</div>