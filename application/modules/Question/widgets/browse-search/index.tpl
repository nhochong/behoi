<?php if (Engine_Api::_()->getApi('settings', 'core')->getSetting('question_tags', 0)) :?>
    <?php

        $this->headScript()
          ->appendFile($this->baseUrl().'/externals/autocompleter/Observer.js')
          ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.js')
          ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.Local.js')
          ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.Request.js');

    ?>
    <script type="text/javascript">
        en4.core.runonce.add(function()
                        {
                          new Autocompleter.Request.JSON('tags', '<?php echo $this->url(array('controller' => 'tag', 'action' => 'suggest'), 'default', true)?>', {
                            'postVar' : 'text',
                            'customChoices' : true,
                            'minLength': 1,
                            'selectMode': 'pick',
                            'autocompleteType': 'tag',
                            'className': 'tag-autosuggest',
                            'filterSubset' : true,
                            'multiple' : true,
                            'injectChoice': function(token){
                              var choice = new Element('li', {'class': 'autocompleter-choices', 'value':token.label, 'id':token.id});
                              new Element('div', {'html': this.markQueryValue(token.label),'class': 'autocompleter-choice'}).inject(choice);
                              choice.inputValue = token;
                              this.addChoiceEvents(choice).inject(this.choices);
                              choice.store('autocompleteChoice', token);
                            }
                          });
                        });
    </script>
<?php endif ?>
<?php if( $this->form ): ?>
  <?php echo $this->form->render($this) ?>
<?php endif ?>
