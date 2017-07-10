<ul>
<?php 
      foreach($this->categories as $cat): ?>
			<?php $category = Engine_Api::_()->getItem('ultimatenews_categoryparent', $cat->category_id);?>
            <li style="font-weight:bolder; padding: 5px;" title="<?php //echo $cat->category_name; ?>">
	            <a href="<?php echo $category->getHref()?>">
	            <?php echo strlen($this->translate($cat->category_name))>22?substr($this->translate($cat->category_name),0,19).'...':$this->translate($cat->category_name); ?>
	            </a>
            </li>
      <?php endforeach;?>
	   		<li style="font-weight:bolder; padding: 5px;" title="<?php echo $this->translate("Other") ?>">
	            <a  href="<?php echo $this->url(array('controller' => 'index', 'action'=>'contents', 'categoryparent'=> 0, 'slug' => 'khac'),'ultimatenews_categoryparent')?>">
	            	<?php echo $this->translate('Other');?>
	            </a>
	        </li>
</ul>