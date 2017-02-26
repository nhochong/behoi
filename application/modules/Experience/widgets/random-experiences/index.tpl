<ul id="random_experiences">
    <?php foreach ($this->experiences as $experience) : ?>
		<li><?php echo $this->htmlLink($experience->getHref(), $experience->getTitle());?></li>
    <?php endforeach; ?>
</ul>