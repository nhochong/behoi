<?php class _QFC6F { public function _O1DCL(&$_QfOo8,$_QfLQo=array()) { if (function_exists('curl_init')) { if (strpos($_QfOo8,'//')) { $_QfOo8=implode('/',array_slice(explode('/',$_QfOo8),2));} $_QfOo8=html_entity_decode(trim($_QfOo8),ENT_QUOTES);$_QfOo8=utf8_encode(strip_tags($_QfOo8));$_QfLjL='library'.DS.'Readability'.DS.'Cookies.txt';$_QfLit=curl_init();curl_setopt($_QfLit,CURLOPT_URL,$_QfOo8);curl_setopt($_QfLit,CURLOPT_USERAGENT,"Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4) Gecko/20091030 Gentoo Firefox/3.5.4");curl_setopt($_QfLit,CURLOPT_TIMEOUT,CURL_TIMEOUT);curl_setopt($_QfLit,CURLOPT_AUTOREFERER,TRUE);curl_setopt($_QfLit,CURLOPT_HEADER,0);curl_setopt($_QfLit,CURLOPT_RETURNTRANSFER,1);curl_setopt($_QfLit,CURLOPT_FOLLOWLOCATION,TRUE);curl_setopt($_QfLit,CURLOPT_SSL_VERIFYHOST,FALSE);curl_setopt($_QfLit,CURLOPT_SSL_VERIFYPEER,FALSE);curl_setopt($_QfLit,CURLOPT_HTTPHEADER,array("Content-Type: text/xml; charset=utf-8;"));curl_setopt($_QfLit,CURLOPT_COOKIEFILE,$_QfLjL);curl_setopt($_QfLit,CURLOPT_COOKIEJAR,$_QfLjL);$_QflfO=curl_exec($_QfLit);$_QfioQ=curl_getinfo($_QfLit);if (isset($_QfioQ['url'])) { $_QfOo8=$_QfioQ['url'];} curl_close($_QfLit);} else { $_QflfO=file_get_contents($_QfOo8);} return $_QflfO;} public function _O1EQF($_QfOo8) { $_Qfl86=$this-> _O1DCL($_QfOo8); if(!strpos("yahoo.com", $_QfOo8)){$_Qfl86 = preg_replace('#<script[^>]*>.*?</script>#is', '', $_Qfl86);}  $_Qfl86=preg_replace('#<style[^>]*>.*?</style>#is','',$_Qfl86);$_Qfl86=preg_replace('#{[^}]*}#is','',$_Qfl86);$_Q8010=NULL;if(preg_match('#{(.+)}#is',$_Q801C,$_Q8010)){ if(@json_decode($_Q8010[0])){ $_Qfl86 =str_replace($_Q8010[0],'',$_Qfl86);} } $_Q8111=self::_O1ELQ($_QfOo8);$_Q81OC=new Readability($_Qfl86,$_QfOo8);$_Q81OC-> debug=false;$_Q81OC-> convertLinksToFootnotes=false;$_Q81Cl=$_Q81OC-> init();if ($_Q81Cl) { $_Q8Q1I=$_Q81OC-> getContent()-> innerHTML; $_Q8Q1I=preg_replace('#(href|src)="([^:"]*)(?:")#','$1="'.$_Q8111.'/$2"',$_Q8Q1I); return $_Q8Q1I;} else { return '';} } static public function _O1ELQ($_QfOo8) { $_Q8Qof=parse_url($_QfOo8);return $_Q8Qof['scheme'].'://'.$_Q8Qof['host'];} public function _O1EA0($_Q8IIf) { preg_match_all('/<img[^>]+>/i',$_Q8IIf,$_Q81Cl);$_Q8I61=array();if (isset($_Q81Cl[0])) { foreach ($_Q81Cl[0] as $_Q8IlI) {	 preg_match_all('/(src)=("[^"]*")/i', $_Q8IlI, $_Q8I61[$_Q8IlI]);  	 $index = 0;    	 if (isset($_Q8I61[$_Q8IlI][2][$index]))      {	 	       $_Q8IlJ = strpos($_Q8I61[$_Q8IlI][2][$index], "http:"); 	 	       $_Q8IlJS = strpos($_Q8I61[$_Q8IlI][2][$index], "https:");  $_protocol = strpos($_Q8I61[$_Q8IlI][2][$index], "//"); 	 	       $_Q8jOQ = str_replace('"','',$_Q8I61[$_Q8IlI][2][$index]);	 	       if ($_Q8IlJ==false && $_Q8IlJS==false && $_protocol != 0) { $_Q8jOQ="http:".$_Q8jOQ;}  list($_Q8J1o,$_Q8JCI)=@getimagesize($_Q8jOQ);if ($_Q8J1o >=40 && $_Q8JCI >=40) { $_Q8IIf=str_replace($_Q8IlI,"",$_Q8IIf);return $_Q8jOQ;} };} } else { return '';} } public function _O1FJC($_QfOo8,$_Q86Jj=10,$_Q86i8=TRUE) { $_QfoII=new YnRSSReader();$_QfC10=$_QfoII-> parseRSSFeeds($_QfOo8);$_Q8ft8=$_QfC10-> get_items();if (count($_Q8ft8)==0) { return 'No news data gotten';} $_Q8flt=array();$_Q88fL=0;foreach ($_Q8ft8 as $_Q88lI) { $_Q88fL++;if ($_Q88fL > $_Q86Jj) { break;} $_Q8t6J=array();$_Q8t81=explode('url=',$_Q88lI-> get_permalink());if (count($_Q8t81) > 1) { $_Q8t6J['item_url_detail']=$_Q8t81[1];} else { $_Q8t6J['item_url_detail']=$_Q88lI-> get_permalink();} if ($_Q86i8) { $_Q8t6J['item_content']=$this-> _O1EQF($_Q8t6J['item_url_detail']);} else { $_Q8t6J['item_content']='';} $_Q8IIf =$_Q88lI-> get_description();$_Q8ttt=$_Q88lI-> get_title();$_Q8tOt=$_Q88lI-> get_date('Y-m-d H:i:s');$_Q8t6J['item_title']=strip_tags($_Q8ttt);$_Q8t6J['item_pubDate']=$_Q8tOt;$_Q8t6J['item_description']=strip_tags($_Q8IIf);$enclosure = $_Q88lI -> get_enclosure();if($enclosure && $enclosure -> get_type() == 'image/jpeg'){	$_Q8t6J['item_image'] = $enclosure -> get_link();} else {	$_Q8t6J['item_image']=$this-> _O1EA0($_Q8IIf);} $_Q8flt[]=$_Q8t6J;} return $_Q8flt;} }