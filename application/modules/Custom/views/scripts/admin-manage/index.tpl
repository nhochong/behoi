
<h2>
  <?php echo $this->translate('Slider Plugin') ?>
</h2>

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
  <?php echo $this->translate("Slider Setting") ?>
</p>

<br />
<?php if( count($this->paginator) ): ?>
<form id='multidelete_form' method="post" parameter="del" action="<?php echo $this->url()?>" onSubmit="return multiDelete()">
<table class='admin_table'>
  <thead>
    <tr>
      <th class='admin_table_short'>ID</th>
      <th><?php echo $this->translate("Title") ?></th>
      <th><?php echo $this->translate("Description") ?></th>
      <th><?php echo $this->translate("Photo") ?></th>
      <th><?php echo $this->translate("Links_URL") ?></th>
      <th><?php echo $this->translate("Options") ?></th>
    </tr>
  </thead>
  <tbody>
    <?php foreach ($this->paginator as $item): ?>
      <tr>
        <td><?php echo $item->getIdentity() ?></td>
        <td><?php echo $item->getTitle() ?></td>
        <td><?php echo substr($item->getDescription(),0,50); ?></td>
        <td><img src="<?php echo $item->getPhotoUrl('thumb.icon') ?>" alt="photo" width= 40px; height = 40px;/></td>
        <td><?php echo $item->getLinkUrl(); ?></td>
        <td>
             <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'custom', 'controller' => 'manage', 'action' => 'edit', 'id' =>$item->getIdentity()), $this->translate('edit'), array(
                'class' => 'smoothbox',
              )) ?>
          |
          <?php echo $this->htmlLink(
                array('route' => 'default', 'module' => 'custom', 'controller' => 'admin-manage', 'action' => 'delete', 'id' => $item->slider_id),
                $this->translate("delete"),
                array('class' => 'smoothbox')) ?>
        </td>
      </tr>
    <?php endforeach; ?>
  </tbody>
</table>
</form>
  
<div>
  <?php echo $this->paginationControl($this->paginator); ?>
</div>

<?php else: ?>
  <div class="tip">
    <span>
      <?php echo $this->translate("There are no Slider entries a yet.") ?>
    </span>
  </div>
<?php endif; ?>

<br>
 <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'custom', 'controller' => 'manage', 'action' => 'sliders'), $this->translate('Add New Slider'), array(
    'class' => 'smoothbox buttonlink',
    'style' => 'background-image: url(' . $this->layout()->staticBaseUrl . 'application/modules/Core/externals/images/admin/new_category.png);')) ?>