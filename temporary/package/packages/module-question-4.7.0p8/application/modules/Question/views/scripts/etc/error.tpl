<div>

  <h2><?php echo $this->translate('Whoops!') ?></h2>

  <?php echo $this->translate('An error has occurred.') ?>

  <?php if( isset($this->error) ): ?>
    <br />
    <br />
    <pre><?php echo $this->translate($this->error); ?></pre>
  <?php endif; ?>

</div>