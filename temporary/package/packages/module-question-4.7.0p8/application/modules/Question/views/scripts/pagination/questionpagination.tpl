<div class="pages">
<?php if ($this->pageCount > 1): ?>
<?php $this->headScript()->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/question_core.js') ?>
	<ul class="paginationControl">
<!-- Previous page link -->
<?php if (isset($this->previous)): ?>
  <li><a href="javascript:void(0)" onclick="javascript:pageAction(<?php echo $this->previous;?>)">
    &laquo; <?php echo $this->translate('Previous')?>
  </a></li>
<?php endif; ?>

<!-- Numbered page links -->

<?php foreach ($this->pagesInRange as $page): ?>


  <?php if ($page != $this->current): ?>
    <li><a href="javascript:void(0)" onclick="javascript:pageAction(<?php echo $page; ?>)">
        <?php echo $page; ?>
    </a></li>
  <?php else: ?>
    <li class="selected"><span><?php echo $page; ?></span></li>
  <?php endif; ?>
<?php endforeach; ?>

<!-- Next page link -->
<?php if (isset($this->next)): ?>
  <li><a href="javascript:void(0)" onclick="javascript:pageAction(<?php echo $this->next; ?>)">
    <?php echo $this->translate('Next')?> &raquo;
  </a></li>
<?php endif; ?>
</div>

	

<?php endif; ?></ul>
</div>