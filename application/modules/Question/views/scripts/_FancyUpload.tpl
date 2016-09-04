<?php $data_files = (!empty($this->data['files']) and count($this->data['files'])) ? $this->data['files'] : array(); ?>

<div class="form-wrapper" id="uploaded_files" <?php if (!count($data_files)):?>style="display: none;"<?php endif;?>>
    <div class="form-label">
        <label><p><?php echo $this->translate('Uploaded Images'); ?></p></label>
    </div>
    <div class="form-element" id="uploaded_files_div">
        <?php if (count($data_files)):
                $file_api = Engine_Api::_()->getApi('storage', 'storage');
        ?>
        <?php foreach($data_files as $data_file) :
                $file = $file_api->get($data_file, 'thumb.normal');
                if( !$file ) {continue; }
        ?>
    <div id="upl_data_<?php echo $data_file; ?>">        
        <span class="delete_img">
            <a href="javascript:void(0);" onclick="javascript:rem_upl(<?php echo $data_file; ?>)" class="delete_button_link deleteicon"></a>
        </span>
        <img src="<?php echo $file->map(); ?>" alt="Uploaded Image"/>
    </div>
        <?php endforeach;?>
        <?php endif;?>
    </div>
</div>

<?php
$this->headScript()
    ->appendFile($this->baseUrl() . '/externals/fancyupload/Swiff.Uploader.js')
    ->appendFile($this->baseUrl() . '/externals/fancyupload/Fx.ProgressBar.js')
    ->appendFile($this->baseUrl() . '/externals/fancyupload/FancyUpload2.js');
  $this->headLink()
    ->appendStylesheet($this->baseUrl() . '/externals/fancyupload/fancyupload.css');
  $this->headTranslate(array(
    'Overall Progress ({total})', 'File Progress', 'Uploading "{name}"',
    'Upload: {bytesLoaded} with {rate}, {timeRemaining} remaining.', '{name}',
    'Remove', 'Click to remove this entry.', 'Upload failed',
    '{name} already added.',
    '{name} ({size}) is too small, the minimal file size is {fileSizeMin}.',
    '{name} ({size}) is too big, the maximal file size is {fileSizeMax}.',
    '{name} could not be added, amount of {fileListMax} files exceeded.',
    '{name} ({size}) is too big, overall filesize of {fileListSizeMax} exceeded.',
    'Server returned HTTP-Status <code>#{code}</code>',
    'Security error occurred ({text})',
    'Error caused a send or load operation to fail ({text})',
  ));
?>

<script type="text/javascript">
var uploadCount = 0;
var extraData = <?php echo $this->jsonInline($this->data); ?>;
var files_data = <?php echo $this->jsonInline($data_files); ?>;
var up;
function rem_upl(file_id) {
    $('tmp_datafile_' + file_id).dispose();
    $('upl_data_' + file_id).dispose();
    if (!($('uploaded_files').getElements("[id^='upl_data_']").length)) $('uploaded_files').setStyle('display', 'none');

    up.fileList.erase(up.findFile(file_id));
    uploadCount -= 1;
}
window.addEvent('domready', function() { // wait for the content
  // our uploader instance
files_data.each(function(file_data) {
        new Element('input', {
            type: 'hidden',
            value: file_data,
            name: 'files[]',
            id: 'tmp_datafile_' + file_data
        }).inject($('hidden_file_data'));
    });
    
  up = new FancyUpload2($('demo-status'), $('demo-list'), { // options object
    // we console.log infos, remove that in production!!
    verbose: false,
    multiple: true,
    appendCookieData: true,
    fileListMax: <?php echo $this->data['max_files'] ?>,
    // url is read from the form, so you just have to change one place
    url: '<?php echo $this->url(array('module' => 'question', 'controller' => 'ajax','action' => 'uploadimage'), 'default')?>',

    // path to the SWF file
    path: '<?php echo $this->baseUrl() . '/externals/fancyupload/Swiff.Uploader.swf';?>',

    // remove that line to select all files, or edit it, add more items
    typeFilter: {
      'Images (*.jpg, *.jpeg, *.gif, *.png)': '*.jpg; *.jpeg; *.gif; *.png'
    },

    // this is our browse button, *target* is overlayed with the Flash movie
    target: 'demo-browse',

                data: extraData,

    // graceful degradation, onLoad is only called if all went well with Flash
    onLoad: function() {
      $('demo-status').removeClass('hide'); // we show the actual UI
      $('demo-fallback').destroy(); // ... and hide the plain form

      // We relay the interactions with the overlayed flash to the link
      this.target.addEvents({
        click: function() {
          return false;
        },
        mouseenter: function() {
          this.addClass('hover');
        },
        mouseleave: function() {
          this.removeClass('hover');
          this.blur();
        },
        mousedown: function() {
          this.focus();
        }
      });
      
    },

    // Edit the following lines, it is your custom event handling

    /**
     * Is called when files were not added, "files" is an array of invalid File classes.
     *
     * This example creates a list of error elements directly in the file list, which
     * hide on click.
     */
    onSelectFail: function(files) {
      files.each(function(file) {
        new Element('li', {
          'class': 'validation-error',
          html: file.validationErrorMessage || file.validationError,
          title: MooTools.lang.get('FancyUpload', 'removeTitle'),
          events: {
            click: function() {
              this.destroy();
              if (!($('demo-list').getChildren("li").length)) $('demo-list').setStyle('display', 'none');
            }
          }
        }).inject(this.list, 'top');
      }, this);
      this.list.setStyle('display', 'block');
      var demostatuscurrent = document.getElementById("demo-status-current");
      var demostatusoverall = document.getElementById("demo-status-overall");

      demostatuscurrent.style.display = "none";
      demostatusoverall.style.display = "none";
    },

    onComplete: function hideProgress() {
      var demostatuscurrent = document.getElementById("demo-status-current");
      var demostatusoverall = document.getElementById("demo-status-overall");

      demostatuscurrent.style.display = "none";
      demostatusoverall.style.display = "none";
    },

    onFileStart: function() {
      uploadCount += 1;
                  $('demo-browse').style.display = "none";
                },
    onFileRemove: function(file) {
      uploadCount -= 1;
      file_id = file.image_id;
      if (uploadCount == 0)
      {
        var demolist = document.getElementById("demo-list");
        demolist.style.display = "none";
      }
      
    },
    onSelectSuccess: function(file) {
      $('demo-list').style.display = 'block';
      var demostatuscurrent = document.getElementById("demo-status-current");
      var demostatusoverall = document.getElementById("demo-status-overall");

      demostatuscurrent.style.display = "block";
      demostatusoverall.style.display = "block";
      up.start();
    } ,
    /**
     * This one was directly in FancyUpload2 before, the event makes it
     * easier for you, to add your own response handling (you probably want
     * to send something else than JSON or different items).
     */
    onFileSuccess: function(file, response) {
      var json = new Hash(JSON.decode(response, true) || {});
                        
      if (json.get('status') == '1') {
        $('demo-browse').style.display = "block";
        file.element.dispose();
        if (!($('demo-list').getChildren("li").length)) $('demo-list').setStyle('display', 'none');
        var div_thumb = new Element('div', {id : "upl_data_" + json.get('image_id')}).inject($('uploaded_files_div'));       
        var span_files = new Element('span', {'class': 'delete_img'}).inject(div_thumb);
        new Element('a', {href: 'javascript:void(0);',
                          'class': 'delete_button_link',
                          onclick: "javascript:rem_upl(" + json.get('image_id') + ")"
                          }).inject(span_files);
        new Element('img', {src: json.get('image_thumb'),
                            alt: 'Uploaded Image'
                           }).inject(div_thumb);
        $('uploaded_files').setStyle('display', 'block');
        new Element('input', {
            type: 'hidden',
            value: json.get('image_id'),
            name: 'files[]',
            id: 'tmp_datafile_' + json.get('image_id')
        }).inject($('hidden_file_data'));
        file.id = json.get('image_id');
      } else {
        $('demo-list').style.display = 'block';
        file.element.addClass('file-failed');
        file.info.set('html', '<span>An error occurred:</span> ' + (json.get('error') ? (json.get('error')) : response));
      }
    },

    /**
     * onFail is called when the Flash movie got bashed by some browser plugin
     * like Adblock or Flashblock.
     */
    onFail: function(error) {
      switch (error) {
        case 'hidden': // works after enabling the movie and clicking refresh
          alert('<?php echo $this->string()->escapeJavascript($this->translate("To enable the embedded uploader, unblock it in your browser and refresh (see Adblock).")) ?>');
          break;
        case 'blocked': // This no *full* fail, it works after the user clicks the button
          alert('<?php echo $this->string()->escapeJavascript($this->translate("To enable the embedded uploader, enable the blocked Flash movie (see Flashblock).")) ?>');
          break;
        case 'empty': // Oh oh, wrong path
          alert('<?php echo $this->string()->escapeJavascript($this->translate("A required file was not found, please be patient and we'll fix this.")) ?>');
          break;
        case 'flash': // no flash 9+
          alert('<?php echo $this->string()->escapeJavascript($this->translate("To enable the embedded uploader, install the latest Adobe Flash plugin.")) ?>');
      }
    }

  });
<?php if (count($data_files)):
                $file_api = Engine_Api::_()->getApi('storage', 'storage');
         foreach($data_files as $data_file) : ?>
         var tmp_file = new FancyUpload2.File();
         tmp_file.id = <?php echo $data_file ?>;
         up.fileList.push(tmp_file);
        <?php endforeach;
              endif; ?>
});
</script>
<div class="form-wrapper">
    <div class="form-label"></div>
    <div class="form-element">
        <fieldset id="demo-fallback">
          <label for="demo-photoupload">
            <?php echo $this->translate('Add Images');?>
            <input type="file" name="Filedata" />
          </label>
        </fieldset>

        <div id="demo-status" class="hide">
          <div>
            <?php echo $this->translate('QUESTION_VIEWS_SCRIPTS_FANCYUPLOAD_ADDPHOTOS');?>
          </div>
          <div>
            <a class="buttonlink icon_qa_new" href="javascript:void(0);" id="demo-browse"><?php echo $this->translate('Add Images');?></a>
          </div>
          <div class="demo-status-overall" id="demo-status-overall" style="display: none">
            <div class="overall-title"></div>
            <img src="<?php echo $this->baseUrl() . '/externals/fancyupload/assets/progress-bar/bar.gif';?>" class="progress overall-progress" />
          </div>
          <div class="demo-status-current" id="demo-status-current" style="display: none">
            <div class="current-title"></div>
            <img src="<?php echo $this->baseUrl() . '/externals/fancyupload/assets/progress-bar/bar.gif';?>" class="progress current-progress" />
          </div>
          <div class="current-text"></div>
        </div>
        <ul id="demo-list"></ul>
        <div id="hidden_file_data"></div>
    </div>
</div>
