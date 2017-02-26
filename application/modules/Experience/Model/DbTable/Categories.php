<?php
class Experience_Model_DbTable_Categories extends Engine_Db_Table
{
  /*----- Properties -----*/
  protected $_rowClass = 'Experience_Model_Category';
  protected $_type = 'experience_category';
  
  /*----- Get Category Function -----*/
  public function getCategory($category_id){
    return $this->find($category_id)->current();
  }
  /*----- Get Category List Function -----*/
  public function getCategories(){
    $select = $this->select()->order('category_name ASC');
    $result = $this->fetchAll($select);
    return $result;
  }
  /*----- Get Categories Array -----*/
  public function getCategoriesAssoc(){
    $categories = $this->getCategories();
    $data = array();
    $data[0] ="";
    foreach($categories as $category){
      $data[$category->category_id] = $category->category_name;
    }
    return $data;
  }
  /*----- Get User Categories List -----*/
  public function getUserCategories($user_id = 0){
    //Get table name
    $experience_table_name = Engine_Api::_()->getItemTable('experience')->info('name');
    $cat_table_name = $this->info('name');

    // Query
    $select = $this->select()
        ->setIntegrityCheck(false)
        ->from($cat_table_name, array('category_name'))
        ->joinLeft($experience_table_name, "$experience_table_name.category_id = $cat_table_name.category_id")
        ->group("$cat_table_name.category_id")
        ->where($experience_table_name.'.owner_id = ?', $user_id)
        ->where($experience_table_name.'.draft = ?', "0")
        ->where($experience_table_name.'.search = ?',"1")
        ->where($experience_table_name.'.is_approved = ?',"1");

    return $this->fetchAll($select);
  }
}
?>
