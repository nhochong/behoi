<div id="file_content" padding-left:10px;">
    <div id="uploadform" >
        <?php $session = new Zend_Session_Namespace('mobile');?>
        <form method="post" action="<?php echo $this->url(); ?><?php if(!$session->mobile) echo "?format=smoothbox"?>"  class="global_form_popup" enctype="multipart/form-data" onsubmit="sending_request();">
            <h3><?php echo $this->translate("Import Classified");?></h3>
            <?php echo $this->translate('File to upload:'); ?> <br><input type='file' name='FileUpload' class='text'>
            <br>
            <br>
            <button type="submit" name="submit_button"><?php echo $this->translate('Import'); ?></button>
            <input type="hidden" name="xls_upload" value="xls"/>
        </form>
    </div>
</div>
