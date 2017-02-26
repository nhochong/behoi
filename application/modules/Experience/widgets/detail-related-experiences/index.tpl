<ul class="experience-mode-views experience-related-experiences clearfix">
  <?php 
  	foreach( $this->experiences as $item )
    {
  		if ($item->checkPermission())
		{
			echo $this->partial('_gridItem.tpl', 'experience', array('item' => $item, 'type' => 'comment'));
		}
	}
  	?>
</ul>
