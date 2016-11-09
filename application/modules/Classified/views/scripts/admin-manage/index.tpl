<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */
?>
<script type="text/javascript">
	function classified_enable(classified_id){
            var element = document.getElementById('classified_content_'+classified_id);
            var checkbox = document.getElementById('classified_'+classified_id);
            var status = 0;
            
            if(checkbox.checked==true) status = 1;
            else status = 0;
            var content = element.innerHTML;
            element.innerHTML= "<img style='margin-top:4px;' src='application/modules/Classified/externals/images/loading.gif'></img>";
            new Request.JSON({
              'format': 'json',
              'url' : '<?php echo $this->url(array('module' => 'classified', 'controller' => 'manage', 'action' => 'enable'), 'admin_default') ?>',
              'data' : {
                'format' : 'json',
                'classified_id' : classified_id,
                'status' : status
              },
              'onRequest' : function(){
              },
              'onSuccess' : function(responseJSON, responseText)
              {
                element.innerHTML = content;
                checkbox = document.getElementById('classified_'+classified_id);
                if( status == 1) checkbox.checked=true;
                else checkbox.checked=false;
              }
            }).send();
            
    }
</script>
<script type="text/javascript">

function multiDelete()
{
  return confirm("<?php echo $this->translate('Are you sure you want to delete the selected classified listings?');?>");
}

function selectAll()
{
  var i;
  var multidelete_form = $('multidelete_form');
  var inputs = multidelete_form.elements;
  for (i = 1; i < inputs.length; i++) {
    if (!inputs[i].disabled) {
      inputs[i].checked = inputs[0].checked;
    }
  }
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

<p>
  <?php echo $this->translate("CLASSIFIEDS_VIEWS_SCRIPTS_ADMINMANAGE_INDEX_DESCRIPTION") ?>
</p>
<?php
$settings = Engine_Api::_()->getApi('settings', 'core');
if( $settings->getSetting('user.support.links', 0) == 1 ) {
	echo '     More info: <a href="http://support.socialengine.com/questions/196/Admin-Panel-Plugins-Classifieds" target="_blank">See KB article</a>.';	
} 
?>		
<br />
<br />
<?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'classified', 'controller' => 'manage', 'action' => 'import'), $this->translate('Import Classified'), array(
          'class' => 'buttonlink smoothbox', 'style' => 'background-image: url(' . $this->layout()->staticBaseUrl . 'application/modules/Core/externals/images/admin/new_category.png);')) ?>
<br />
<br />

<?php if( count($this->paginator) ): ?>
<form id='multidelete_form' method="post" action="<?php echo $this->url();?>" onSubmit="return multiDelete()">
<table class='admin_table'>
  <thead>
    <tr>
      <th class='admin_table_short'><input onclick='selectAll();' type='checkbox' class='checkbox' /></th>
      <th class='admin_table_short'>ID</th>
      <th><?php echo $this->translate("Title") ?></th>
      <th><?php echo $this->translate("Category") ?></th>
      <th><?php echo $this->translate("Enabled") ?></th>
      <th><?php echo $this->translate("Views") ?></th>
      <th><?php echo $this->translate("Options") ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($this->paginator as $item): ?>
      <tr>
        <td><input type='checkbox' class='checkbox' name='delete_<?php echo $item->classified_id;?>' value="<?php echo $item->classified_id; ?>" /></td>
        <td><?php echo $item->classified_id ?></td>
        <td><?php echo $item->getTitle() ?></td>
        <td><?php echo Engine_Api::_()->getItem('classified_category', $item->category_id)->getTitle() ?></td>
		<td>
			<div id='classified_content_<?php echo $item->getIdentity(); ?>' style ="text-align: center;" >
				<?php if($item->enabled): ?>
					<input type="checkbox" id='classified_<?php echo $item->getIdentity(); ?>' onclick="classified_enable(<?php echo $item->getIdentity(); ?>,this)" checked />
				<?php else: ?>
				   <input type="checkbox" id='classified_<?php echo $item->getIdentity(); ?>' onclick="classified_enable(<?php echo $item->getIdentity(); ?>,this)" />
				<?php endif; ?>
			</div>
		</td>
        <td><?php echo $this->locale()->toNumber($item->view_count) ?></td>
        <td>
          <a href="<?php echo $this->url(array('user_id' => $item->owner_id, 'classified_id' => $item->classified_id), 'classified_entry_view') ?>">
            <?php echo $this->translate("view") ?>
          </a>
		  |
          <?php echo $this->htmlLink(
            array('route' => 'classified_specific', 'action' => 'edit', 'classified_id' => $item->classified_id),
            $this->translate("edit"),
            array('target' => '_blank')) ?>
          |
          <?php echo $this->htmlLink(
            array('route' => 'default', 'module' => 'classified', 'controller' => 'admin-manage', 'action' => 'delete', 'id' => $item->classified_id),
            $this->translate("delete"),
            array('class' => 'smoothbox')) ?>
        </td>
      </tr>
    <?php endforeach; ?>
  </tbody>
</table>

<br />

<div class='buttons'>
  <button type='submit'><?php echo $this->translate("Delete Selected") ?></button>
</div>
</form>

<br/>
<div>
  <?php echo $this->paginationControl($this->paginator); ?>
</div>

<?php else:?>
  <div class="tip">
    <span>
      <?php echo $this->translate("There are no classified listings by your members yet.") ?>
    </span>
  </div>
<?php endif; ?>
