<ul id="random_blogs">
    <?php foreach ($this->blogs as $blog) : ?>
		<li><?php echo $this->htmlLink($blog->getHref(), $blog->getTitle());?></li>
    <?php endforeach; ?>
</ul>