<h2>
  <?php echo $this->translate("Score")?>
</h2>

<div class='tabs'>
    <?php $tm = $this->navigation()->menu()->setContainer($this->navigation);
            echo $tm->render(); ?>
</div>
<?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
    <ul class="qthumb">
        <?php foreach( $this->paginator as $item ): ?>
            <li>
                <?php echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('target' => '_blank')) ?>
                <?php echo $item->toString(array('target' => '_blank')) ?>
            </li>
        <?php if( $this->paginator->count() >= 1): ?>
            <div class="paginclear">
                <?php echo $this->paginationControl($this->paginator); ?>
            </div>
        <?php endif; ?>

        <?php endforeach; ?>
    </ul>
<?php else:?>
    <br/>
    <div class="tip">
        <span>
            <?php echo $this->translate('Votes are not found');?>
        </span>
    </div>
<?php endif; ?>