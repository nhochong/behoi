<div class="headline">
  <h2>
    <?php echo $this->translate('Questions and Answers');?>
  </h2>
  <?php if( count($this->navigation) > 0 ): ?>
    <div class="tabs">
      <?php
        // Render the menu
        echo $this->navigation()
          ->menu()
          ->setContainer($this->navigation)
          ->setPartial(null)
          ->render();
      ?>
    </div>
  <?php endif; ?>
</div>
