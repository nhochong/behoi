<rss version="2.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <channel>
        <title>
              <?php echo $this->translate('Experiences'); ?>
              &#187;
              <?php echo $this->pro_type_name ?>
        </title>
        <description>
              <?php echo $this->translate('RSS Experiences');?>
        </description>
        <link>
              <?php echo "http://".$_SERVER['HTTP_HOST'].$this->url(array('action' => 'listing'), 'experience_general');?>
        </link>
         <?php foreach($this->experiences as $row):
        $description = strip_tags($row->body);
        $description = Engine_Api::_()->experience()->subPhrase($description,300);?>
        <item>
            <title><![CDATA[
            <?php echo $row->title ?>
            ]]></title>
            <link>
            <?php echo "http://".$_SERVER['HTTP_HOST'].$row->getHref()?>
            </link>
            <description><![CDATA[
            <?php echo $description;?>
            ]]></description>
            <pubDate> <?php echo $row->creation_date ?></pubDate>
        </item>
<?php endforeach; ?>   
   </channel>
</rss>

