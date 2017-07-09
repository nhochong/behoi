<?php
class HtmlCutString{
  function __construct($string, $limit){
    // create dom element using the html string
    $this->tempDiv = new DomDocument;
    $this->tempDiv->loadXML('<div>'.$string.'</div>');
    // keep the characters count till now
    $this->charCount = 0;
    $this->encoding = 'UTF-8';
    // character limit need to check
    $this->limit = $limit;
  }
  function cut(){
    // create empty document to store new html
    $this->newDiv = new DomDocument;
    // cut the string by parsing through each element
    $this->searchEnd($this->tempDiv->documentElement,$this->newDiv);
    $newhtml = $this->newDiv->saveHTML();
    return $newhtml;
  }

  function deleteChildren($node) {
    while (isset($node->firstChild)) {
      $this->deleteChildren($node->firstChild);
      $node->removeChild($node->firstChild);
    }
  } 
  function searchEnd($parseDiv, $newParent){
    foreach($parseDiv->childNodes as $ele){
	// not text node
	if($ele->nodeType != 3){
	  $newEle = $this->newDiv->importNode($ele,true);
	  if(count($ele->childNodes) === 0){
	    $newParent->appendChild($newEle);
	    continue;
	  }
	  $this->deleteChildren($newEle);
	  $newParent->appendChild($newEle);
	    $res = $this->searchEnd($ele,$newEle);
	    if($res)
		return $res;
	    else{
		continue;
	    }
	}

	// LONGL edited for unicode string
	// the limit of the char count reached
	if(mb_strlen($ele->nodeValue,$this->encoding) + $this->charCount >= $this->limit){
	  	$newEle = $this->newDiv->importNode($ele);
		$stop = 0;
	    do {
			$stop++;
			$tmpnewEle = mb_substr($newEle->nodeValue,0, $this->limit - $this->charCount, $this->encoding);
			if (strlen(rtrim($tmpnewEle))<strlen($tmpnewEle))
			{
				$newEle->nodeValue = rtrim(mb_substr($newEle->nodeValue,0, $this->limit - $this->charCount, $this->encoding));
				break;
			}
			$this->limit++;
		} while($stop < strlen($ele->nodeValue));
	    $newParent->appendChild($newEle);
	    return true;
	}
	$newEle = $this->newDiv->importNode($ele);
	$newParent->appendChild($newEle);
	$this->charCount += mb_strlen($newEle->nodeValue,$this->encoding);
    }
    return false;
  }
}

function cut_html_string($string, $limit){
  $output = new HtmlCutString($string, $limit);
  return $output->cut();
}

?>