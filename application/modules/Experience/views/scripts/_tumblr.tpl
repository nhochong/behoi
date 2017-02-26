<?php echo '<?xml version="1.0" encoding="UTF-8"?>' ?>
<rss version="2.0">
    <channel>
        <atom:link rel="hub" href="http://tumblr.superfeedr.com/" xmlns:atom="http://www.w3.org/2005/Atom"/>
        <description></description>
        <title><?php echo $this->experiences[0] -> getOwner() -> getTitle()?></title>
        <generator>Tumblr (3.0; @<?php echo $this->experiences[0]-> getOwner() -> getTitle()?>)</generator>
        <link><?php echo "//".$_SERVER['HTTP_HOST'].$this->experiences[0] -> getOwner() -> getHref()?></link>
        <?php foreach ($this->experiences as $experience): ?>
        <item>
            <title><?php echo $experience->getTitle() ?></title>
            <description>&lt;p&gt;<?php echo $experience->body ?>&lt;/p&gt;</description>
            <link><?php echo "//".$_SERVER['HTTP_HOST']. $experience -> getHref(); ?></link>
            <guid><?php echo "//".$_SERVER['HTTP_HOST']. $experience -> getHref(); ?></guid>
            <pubDate><?php echo $experience->creation_date ?></pubDate>
        </item>
        <?php endforeach;?>
    </channel>
</rss>