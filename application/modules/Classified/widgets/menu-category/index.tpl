
<ul class="dropdown-menu">
	<?php foreach($this->categories as $category):?>
	<li>
		<?php echo $this->htmlLink($category->getHref(),  $category->getTitle(), array()); ?>
		<?php $childs = $category->getSubCategory();?>
		<?php if(count($childs)):?>
			<ul class="dropdown-menu-level-2">
			<?php foreach($childs as $child):?>
				<li><?php echo $this->htmlLink($child->getHref(),  $child->getTitle()); ?></li>
			<?php endforeach;?>
			</ul>
		<?php endif;?>
	</li>
	<?php endforeach;?>
</ul>