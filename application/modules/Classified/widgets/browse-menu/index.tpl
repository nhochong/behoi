
<div class="headline">
  <h1>
    <?php echo $this->translate('Classified Listings') ?>
  </h1>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
