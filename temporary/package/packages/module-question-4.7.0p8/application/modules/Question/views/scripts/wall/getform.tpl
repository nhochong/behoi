<?php
echo $this->form->render($this);
$config = $this->form->question->getAttribs();
$config = $config['editorOptions'];
?>
<script type="text/javascript">
    function wh_anonymous_hide(input) {
        $('auth_view-wrapper').setStyle('display', (input.checked) ? 'none' : '');
        $('auth_answer-wrapper').setStyle('display', (input.checked) ? 'none' : '');
        if (input.checked) {
            $('auth_answer').set('value', 'registered');
            $('auth_view').set('value', 'everyone');
        }
    }

    if ($('anonymous')) {
        wh_anonymous_hide($('anonymous'));
        $('anonymous').addEvent('change', function(event) {
            wh_anonymous_hide(event.target);
        });
    }
<?php $manifest = Zend_Registry::get('Engine_Manifest') ?>
<?php if (version_compare($manifest['core']['package']['version'], '4.7.0', '<')) : ?>
        Asset.javascript('<?php echo $this->layout()->staticBaseUrl ?>externals/tinymce/tiny_mce.js', {
            onLoad: function() {
                tinyMCE.dom.Event.domLoaded = true;
                tinyMCE.settings = {theme: "advanced",
                    theme_advanced_buttons1: "<?php echo implode(',', $config['theme_advanced_buttons1']) ?>",
                    theme_advanced_buttons2: "",
                    theme_advanced_buttons3: "",
                    plugins: "paste, media, inlinepopups",
                    theme_advanced_toolbar_align: "left",
                    theme_advanced_toolbar_location: "top",
                    element_format: "html",
                    height: "200px",
                    convert_urls: false,
                    media_strict: false,
                    directionality: "ltr",
                    mode: "specific_textareas",
                    editor_selector: "mceEditor",
                    language: "<?php echo Zend_Registry::get('Locale')->toString() ?>",
                    extended_valid_elements: 'a[href|rel=nofollow]'
                };

                tinyMCE.execCommand('mceAddControl', false, 'question');
            }
        });
<?php else : ?>
    <?php list($language) = explode('_', Zend_Registry::get('Locale')->toString()) ?>
        Asset.javascript('<?php echo $this->layout()->staticBaseUrl ?>externals/tinymce/tinymce.min.js', {
            onLoad: function() {
                tinyMCE.dom.Event.domLoaded = true;
                tinyMCE.settings = {theme: "modern",
                    toolbar1: "<?php echo implode(',', $config['toolbar1']) ?>",
                    toolbar2: "",
                    toolbar3: "",
                    plugins: "link, media, paste, code",
                    element_format: "html",
                    height: "200px",
                    convert_urls: false,
                    media_strict: false,
                    directionality: "ltr",
                    mode: "specific_textareas",
                    editor_selector: "mceEditor",
                    language: "<?php echo $language ?>",
                    extended_valid_elements: 'a[href|rel=nofollow]',
                    menubar: false,
                    statusbar: false
                };

                tinyMCE.execCommand('mceAddEditor', false, 'question');
            }
        });
<?php endif ?>
</script>
