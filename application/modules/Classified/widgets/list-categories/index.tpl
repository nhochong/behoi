<?php
    $session = new Zend_Session_Namespace('mobile');
?>

<div class="generic_list_widget">
    <ul class="ymb_menuRight_wapper classifieds-category">
        <?php foreach ($this->categories as $category) : ?>
            <li value ='<?php echo $category->getIdentity() ?>' id="parent_<?php echo $category->getIdentity() ?>" class="classifieds-category_row">
                <div <?php  $request = Zend_Controller_Front::getInstance()->getRequest(); 
                if($request-> getParam('category') == $category -> category_id) echo 'class = "active"';?>>
				<?php $childs = $category->getSubCategory();?>
                    <?php if(count($childs) > 0 && !$session-> mobile) : ?>
                        <div class="classifieds-category-collapse-control classifieds-category-collapsed"></div>
                    <?php else : ?>
                        <div class="classifieds-category-collapse-nocontrol"></div>
                    <?php endif; ?>

                    <?php 
                        echo $this->htmlLink(
                                $category->getHref(), 
                                $category->getTitle(),
                                array('title' => $category->getTitle()));
                    ?>                    
                </div>
            </li>
			<?php if(count($childs) > 0):?>
				<?php foreach($childs as $child):?>
					<li value ='<?php echo $child->getIdentity() ?>' class="classifieds-category_row classifieds-category-sub-category child_<?php echo $category->getIdentity();?> level_2">
						<div <?php  $request = Zend_Controller_Front::getInstance()->getRequest(); 
						if($request-> getParam('category') == $child -> category_id) echo 'class = "active"';?>>
							<div class="classifieds-category-collapse-nocontrol"></div>
							<?php 
								echo $this->htmlLink(
										$child->getHref(), 
										$child->getTitle(),
										array('title' => $child->getTitle()));
							?>                    
						</div>
					</li>
				<?php endforeach; ?>
			<?php endif;?>
        <?php endforeach; ?>
    </ul>
</div>

<?php if($session -> mobile): ?>
<script type="text/javascript">
    var btn_mobile_category = new Element('div', {html:'<a onclick="toggleOpenMenuRight(this);" class="ynmb_openMenuRight_btn ynmb_sortBtn_btn ynmb_touchable ynmb_categories_icon ynmb_a_btnStyle" href="javascript: void(0);"><span class="ynmb_openMenuRight"><span><?php echo $this->translate("Categories")?></span></span></a>'}) ;
    btn_mobile_category.addClass('ynmb_sortBtn_actionSheet');
    $$('.ynmb_sortBtn_Wrapper')[0].grab( btn_mobile_category );
</script>
<?php endif; ?>

<script type="text/javascript">
	window.addEvent('domready', function(){
		<?php 
			if($request-> getParam('category', null) != null){
				$category = Engine_Api::_()->getItem('classified_category', $request-> getParam('category'));
				if($category && $category->parent_id > 0){
					echo "$$('#parent_" . $category->parent_id . " .classifieds-category-collapse-control').fireEvent('click');";
				}
			}
		?>
	})
</script>