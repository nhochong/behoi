<?php if (Engine_Api::_()->getApi('settings', 'core')->getSetting('wall_ask', 1)):?>
    <?php if (!Engine_Api::_()->core()->hasSubject() or (Engine_Api::_()->core()->hasSubject('group') or Engine_Api::_()->core()->hasSubject('event')) && Engine_Api::_()->getDbTable('modules', 'core')->isModuleEnabled('questiongeaddon')): ?>
        <?php
          $this->headScript()
            ->appendFile($this->baseUrl() . '/application/modules/Question/externals/scripts/composer_question.js')
        ;

        ?>

        <script type="text/javascript">
          en4.core.runonce.add(function() {
            if (composeInstance.options.type != 'message') {
                var type = 'wall';
                if (composeInstance.options.type) type = composeInstance.options.type;
                    composeInstance.addPlugin(new Composer.Plugin.Question({
                      title : '<?php echo $this->translate("Ask") ?>',
                      lang : {

                      }
                    }));
            }
          });
        </script>
    <?php endif;?>
<?php endif;?>