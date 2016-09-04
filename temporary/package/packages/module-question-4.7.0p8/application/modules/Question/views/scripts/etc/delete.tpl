<?php if( @$this->messages ): ?>
<p><?php echo $this->translate($this->messages) ?></p>
 <?php else:?>
<form method="post" class="global_form_popup">
    <div>
      <h3><?php echo $this->translate($this->delete_title) ?></h3>
      <p>
        <?php echo $this->translate($this->delete_description) ?>
      </p>
      <br />
      <p>
        <input type="hidden" name="confirm" value="<?php echo $this->category_id?>"/>
        <button type='submit'><?php if (isset($this->button)) echo $this->translate($this->button); else echo $this->translate('Delete'); ?></button>
        <?php echo $this->translate('or') ?> <a href='javascript:void(0);' onclick='javascript:parent.Smoothbox.close()'><?php echo $this->translate('cancel') ?></a>
      </p>
    </div>
  </form>
<?php endif; ?>
<?php if( @$this->closeSmoothbox ): ?>
<script type="text/javascript">
  TB_close();
</script>
<?php endif; ?>
