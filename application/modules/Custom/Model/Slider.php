<?php
class Custom_Model_Slider extends Core_Model_Item_Abstract{
	
	public function getPhotoUrl($type = null)
	{
		if( empty($this->photo_id) ) {
			return 'externals/custom-slider/default_slider.jpg';
		}
		$file = Engine_Api::_()->getItemTable('storage_file')->getFile($this->photo_id, $type);
		if( !$file ) {
			return 'externals/custom-slider/default_slider.jpg';
		}
		return $file->map();
	}
	
	public function getLinkUrl(){
        return $this->links_url;
	}
     
	public function setPhoto($photo)
	{
		if ($photo instanceof Zend_Form_Element_File)
		{
			$file = $photo -> getFileName();
		}
		else
		if (is_array($photo) && !empty($photo['tmp_name']))
		{
			$file = $photo['tmp_name'];
		}
		else
		if (is_string($photo) && file_exists($photo))
		{
			$file = $photo;
		}
		else
		{
			throw new Group_Model_Exception('invalid argument passed to setPhoto');
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'custom',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();

		// Resize image (main)
		$image = Engine_Image::factory();
		$image -> open($file) -> write($path . '/m_' . $name) -> destroy();
      
		// Resize image (icon)
		$image = Engine_Image::factory();
		$image -> open($file);

		$size = min($image -> height, $image -> width);
		$x = ($image -> width - $size) / 2;
		$y = ($image -> height - $size) / 2;

		$image -> resample($x, $y, $size, $size, 48, 48) -> write($path . '/is_' . $name) -> destroy();

		$iMain = $storage -> create($path . '/m_' . $name, $params);
		$iSquare = $storage->create($path . '/is_' . $name, $params);
		
		$iMain->bridge($iSquare, 'thumb.icon');

		// Remove temp files
		@unlink($path . '/m_' . $name);
		@unlink($path . '/is_' . $name);
		
		// Update row
		$this -> modified_date = date('Y-m-d H:i:s');
		$this -> photo_id = $iMain -> file_id;

		$this -> save();
		return $this;
	}

	
}