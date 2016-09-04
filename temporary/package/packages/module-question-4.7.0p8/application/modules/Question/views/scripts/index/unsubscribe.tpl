<div class="overdel">
    <h3><?php echo $this->translate("Unsubscribe from question notification"); ?></h3>
    <?php if ($this->status): ?>
        <p><?php echo $this->translate("Are you sure want to unsubscribe from question '%s'?", $this->htmlLink($this->question->getHref(), $this->question->getTitle(), array('target' => '_blank'))); ?></p>
        <form action="" method="post">
            <input type="hidden" name="task" value="do_unsubscribe">
            <button type="submit"> <?php echo $this->translate("Yes, unsubscribe me."); ?> </button>
            <?php echo $this->translate('or'); ?>
            <a href="<?php echo $this->url(array(), 'home', true); ?>"><?php echo $this->translate('Cancel'); ?></a>
        </form>
    <?php else:?>
        <p><?php echo $this->translate("You successfully unsubscribed from question '%s'.", $this->htmlLink($this->question->getHref(), $this->question->getTitle(), array('target' => '_blank'))); ?></p>
    <?php endif;?>
</div>