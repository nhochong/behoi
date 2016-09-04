<div class="quicklinks">
    <ul>
      <li>
        <?php $settings = Engine_Api::_()->getApi('settings', 'core');
              if (time() - $settings->getSetting('time_qarating_update', 0) > 120): ?>
            <?php echo $this->htmlLink(array('action' => 'updateur', 'reset' => false), $this->translate('Refresh Ratings'), array('class' => 'buttonlink icon_refresh')) ?>
        <?php else: ?>
          <?php echo $this->translate('Ratings are being recalculated. Please wait a few minutes.') ?>
        <?php  endif;?>
      </li>
      <li>
          <?php echo $this->translate('Use this button if you think ratings need to be re-calculated.') ?>
      </li>
    </ul>
</div>