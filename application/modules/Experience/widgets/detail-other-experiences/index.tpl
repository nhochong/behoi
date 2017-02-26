<ul class="experience-mode-views experience-other-experiences">
  <?php 
  	foreach( $this->experiences as $item )
    {
  		if ($item->checkPermission())
		{
			echo $this->partial('_listItem.tpl', 'experience', array('item' => $item, 'type' => 'new'));
		}
	}
  	?>
</ul>
