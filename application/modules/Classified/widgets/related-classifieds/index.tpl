<ul id="related_classifieds">
    <?php foreach ($this->classifieds as $classified) : ?>
		<li><?php echo $this->htmlLink($classified->getHref(), $classified->getTitle());?></li>
    <?php endforeach; ?>
</ul>