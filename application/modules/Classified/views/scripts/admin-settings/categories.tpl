<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: categories.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */
?>
<script type="text/javascript">

	function category_hot(category_id){
            var element = document.getElementById('category_content_'+category_id);
            var checkbox = document.getElementById('hotcategory_'+category_id);
            var status = 0;
            
            if(checkbox.checked==true) status = 1;
            else status = 0;
            var content = element.innerHTML;
            element.innerHTML= "<img style='margin-top:4px;' src='application/modules/Classified/externals/images/loading.gif'></img>";
            new Request.JSON({
              'format': 'json',
              'url' : '<?php echo $this->url(array('module' => 'classified', 'controller' => 'settings', 'action' => 'hot'), 'admin_default') ?>',
              'data' : {
                'format' : 'json',
                'category_id' : category_id,
                'hot' : status
              },
              'onRequest' : function(){
              },
              'onSuccess' : function(responseJSON, responseText)
              {
                element.innerHTML = content;
                checkbox = document.getElementById('hotcategory_'+category_id);
                if( status == 1) checkbox.checked=true;
                else checkbox.checked=false;
              }
            }).send();
            
    }
</script>
<h2><?php echo $this->translate("Classifieds Plugin") ?></h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      // Render the menu
      //->setUlClass()
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

  <div class='clear'>
    <div class='settings'>
    <form class="global_form">
      <div>
        <h3><?php echo $this->translate("Classified Listing Categories") ?> </h3>
        <p class="description">
          <?php echo $this->translate("CLASSIFIEDS_VIEWS_SCRIPTS_ADMINSETTINGS_CATEGORIES_DESCRIPTION") ?>
        </p>
		<?php 
			if(!empty($this->parent_id)):
			$parent = Engine_Api::_()->getItem('classified_category', $this->parent_id);
		?>
		<h3><?php echo $this->translate('Parent Category')?> : <?php echo $parent->getTitle()?></h3>
		<?php endif;?>
          <?php if(count($this->categories)>0):?>

         <table class='admin_table'>
          <thead>

            <tr>
              <th><?php echo $this->translate("Category Name") ?></th>
              <th><?php echo $this->translate("Category Code") ?></th>
              <th><?php echo $this->translate("Photo") ?></th>
			  <?php if(empty($this->parent_id)):?>
              <th><?php echo $this->translate("Number of Sub") ?></th>
			  <?php endif;?>
			  <th><?php echo $this->translate("Hot") ?></th>
              <th><?php echo $this->translate("Options") ?></th>
            </tr>

          </thead>
          <tbody>
            <?php foreach ($this->categories as $category): ?>
              <tr>
                <td><?php echo $category->category_name?></td>
                <td><?php echo $category->code?></td>
                <td><img style="max-width: 50px;max-height: 50px;" src="<?php echo $category->getPhotoUrl('thumb.icon')?>"/></td>
				<?php if(empty($this->parent_id)):?>
                <td><?php echo $category->getSubCategoryCount()?></td>
				<?php endif;?>
				<td>
				  <div id='category_content_<?php echo $category->getIdentity(); ?>' style ="text-align: center;" >
					  <?php if($category->is_hot): ?>
						<input type="checkbox" id='hotcategory_<?php echo $category->getIdentity(); ?>' onclick="category_hot(<?php echo $category->getIdentity(); ?>,this)" checked />
					  <?php else: ?>
					   <input type="checkbox" id='hotcategory_<?php echo $category->getIdentity(); ?>' onclick="category_hot(<?php echo $category->getIdentity(); ?>,this)" />
					  <?php endif; ?>
				  </div>
				</td>
                <td>
				  <?php if($category->parent_id == 0):?>
				  <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'settings', 'action' => 'add-category', 'parent_id' =>$category->category_id), $this->translate('Add sub-category'), array(
                    'class' => 'smoothbox',
                  )) ?>
                  |
				  <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'settings', 'action' => 'categories', 'parent_id' =>$category->category_id), $this->translate('View sub-category')) ?>
                  |
				  <?php endif;?>
                  <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'settings', 'action' => 'edit-category', 'id' =>$category->category_id), $this->translate('Edit'), array(
                    'class' => 'smoothbox',
                  )) ?>
                  |
                  <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'settings', 'action' => 'delete-category', 'id' =>$category->category_id), $this->translate('Delete'), array(
                    'class' => 'smoothbox',
                  )) ?>

                </td>
              </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
      <?php else:?>
      <br/>
      <div class="tip">
      <span><?php echo $this->translate("There are currently no categories.") ?></span>
      </div>
      <?php endif;?>
        <br/>
        <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'settings', 'action' => 'add-category', 'parent_id' => $this->parent_id), $this->translate('Add New Category'), array(
          'class' => 'smoothbox buttonlink',
          'style' => 'background-image: url(' . $this->layout()->staticBaseUrl . 'application/modules/Core/externals/images/admin/new_category.png);')) ?>
		<?php if(!empty($this->parent_id)):?>
		<?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'settings', 'action' => 'categories', 'parent_id' => 0), $this->translate('View Main Category'), array(
          'class' => 'buttonlink',
          'style' => 'background-image: url(' . $this->layout()->staticBaseUrl . 'application/modules/Classified/externals/images/allentries.png);')) ?>
		<?php endif;?>
    </div>
    </form>
    </div>
  </div>
     