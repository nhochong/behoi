<?php
class Experience_Api_Session extends Core_Api_Abstract{

   /*----- Store Data Into Session Function -----*/
  public function setSession($input = array(),$name = ''){
    $experience_search = new Zend_Session_Namespace($name);
    $experience_search->session_array   = $input;
  }

  /*----- Get Data From Session Function -----*/
  public function getSession($params = null,$name = null){
    $experience_search = new Zend_Session_Namespace($name);

    if(isset( $experience_search->session_array )) {
      $params = $experience_search->session_array;
    }
    return $params;
  }

  /*----- Unset Session Function -----*/
  public function unsetSession($name = null){
    $experience_search = new Zend_Session_Namespace($name);
    // Search field
    if(isset( $experience_search->session_array )) {
      $experience_search->__unset('session_array');
    }
  }
}
?>
