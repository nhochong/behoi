<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developmentsedsafd
 * @license    http://www.socialengine.com/license/
 */
 class Classified_Api_Core extends Core_Api_Abstract
 {

   const IMAGE_WIDTH = 720;
   const IMAGE_HEIGHT = 720;

   const THUMB_WIDTH = 140;
   const THUMB_HEIGHT = 160;

   public function createPhoto($params, $file)
   {
     if( $file instanceof Storage_Model_File )
     {
       $params['file_id'] = $file->getIdentity();
     }

     else
     {
       // Get image info and resize
       $name = basename($file['tmp_name']);
       $path = dirname($file['tmp_name']);
       $extension = ltrim(strrchr($file['name'], '.'), '.');

       $mainName = $path.'/m_'.$name . '.' . $extension;
       $thumbName = $path.'/t_'.$name . '.' . $extension;

       $image = Engine_Image::factory();
       $image->open($file['tmp_name'])
           ->resize(self::IMAGE_WIDTH, self::IMAGE_HEIGHT)
           ->write($mainName)
           ->destroy();

       $image = Engine_Image::factory();
       $image->open($file['tmp_name'])
           ->resize(self::THUMB_WIDTH, self::THUMB_HEIGHT)
           ->write($thumbName)
           ->destroy();

       // Store photos
       $photo_params = array(
         'parent_id' => $params['classified_id'],
         'parent_type' => 'classified',
       );

       $photoFile = Engine_Api::_()->storage()->create($mainName, $photo_params);
       $thumbFile = Engine_Api::_()->storage()->create($thumbName, $photo_params);
       $photoFile->bridge($thumbFile, 'thumb.normal');

       $params['file_id'] = $photoFile->file_id; // This might be wrong
       $params['photo_id'] = $photoFile->file_id;

       // Remove temp files
       @unlink($mainName);
       @unlink($thumbName);

       /*
       $param['owner_type'] = $params['parent_type'];
       $param['owner_id'] = $params['parent_id'];
       unset($params['parent_type']);
       unset($params['parent_id']);
       */
     }

     $row = Engine_Api::_()->getDbtable('photos', 'classified')->createRow();
     $row->setFromArray($params);
     $row->save();
     return $row;
   }
   
	public function subPhrase($string, $length = 0) {
		if (strlen ( $string ) <= $length)
			return $string;
		$pos = $length;
		for($i = $length - 1; $i >= 0; $i --) {
			if ($string [$i] == " ") {
				$pos = $i + 1;
				break;
			}
		}
		return substr ( $string, 0, $pos ) . "...";
	}
	
	public function uploadImportFile() {		
		require_once APPLICATION_PATH . '/application/libraries/Libs/PHPExcel.php';
		require_once APPLICATION_PATH . '/application/libraries/Libs/PHPExcel/IOFactory.php';
        // Get the library file
        include_once 'VcardReader.php';
        include_once 'vcard.php';
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $contacts = array();
        $friends = array();

        $is_error = 0;
        $message = '';
        $ci_contacts = array();

        // list the permitted file type
        $permit_file_types = array(
            'text/xls' => 'xls',
            'text/xlsx' => 'xlsx',
        );

        for (;;) {
            $uploaded_file = $_FILES ['FileUpload'] ['tmp_name'];
            $filetype = $_FILES ['FileUpload'] ["type"];
            $filename = $_FILES ['FileUpload'] ['name'];
            // Check file types
            $v = strpos($filename, '.ldif');

            if (!array_key_exists($filetype, $permit_file_types) && $v < 0) {
                $is_error = 1;
                $message = "Invalid file type!";
                break;
            }
            if (is_uploaded_file($uploaded_file)) {
                $fh = fopen($uploaded_file, "r");
                if ($this->EndsWith(mb_strtolower($filename), 'xls')) {
					$data = "";
					$objReader = PHPExcel_IOFactory::createReader('Excel5');
					$objReader->setLoadAllSheets();
					$objPHPExcel = $objReader->load($uploaded_file);
					$loadedSheetNames = $objPHPExcel->getSheetNames();

					if(count($loadedSheetNames)) {
						foreach ($loadedSheetNames as $sheetIndex => $loadedSheetName) {
							$sheetData = $objPHPExcel->getSheet($sheetIndex)->toArray(null, true, true, true);
							return $sheetData;
						}
					}
                } elseif ($this->EndsWith(mb_strtolower($filename), 'xlsx')) { // thunderbirth
                    $data = "";
                    $objReader = PHPExcel_IOFactory::createReader('Excel2007');
                    $objReader->setLoadAllSheets();
                    $objPHPExcel = $objReader->load($uploaded_file);
                    $loadedSheetNames = $objPHPExcel->getSheetNames();
                    if (count($loadedSheetNames)) {
                        foreach ($loadedSheetNames as $sheetIndex => $loadedSheetName) {
                            $sheetData = $objPHPExcel->getSheet($sheetIndex)->toArray(null, true, true, true);
                            return $sheetData;
                        }
                    }
                    $file_contents = $data;
                } else{
                    // not support format
                    $is_error = 1;
                    $message = "Unknown file type!";
                }
            }

            if (empty($contacts)) {
                $is_error = 1;
                $message = "There is no contact in your address book";
                break;
            }

            foreach ($contacts as $value) {
                $ci_contacts ["{$value["email"]}"] = $value ["name"];
            }
            break;
        }

        $returns ['contacts'] = $ci_contacts;
        $returns ['is_error'] = $is_error;
        $returns ['error_message'] = $message;

        return $returns;
    }
	
    function endsWith($FullStr, $EndStr) {
		// Get the length of the end string
		$StrLen = strlen ( $EndStr );

		// Look at the end of FullStr for the substring the size of EndStr

		$FullStrEnd = substr ( $FullStr, strlen ( $FullStr ) - $StrLen );
		// If it matches, it does end with EndStr
		return $FullStrEnd == $EndStr;
	}
	
	public function setPhoto($parent, $photo) {
		if ($photo instanceof Zend_Form_Element_File) {
			$file = $photo -> getFileName();
			$fileName = $file;
		} else if ($photo instanceof Storage_Model_File) {
			$file = $photo -> temporary();
			$fileName = $photo -> name;
		} else if ($photo instanceof Core_Model_Item_Abstract && !empty($photo -> file_id)) {
			$tmpRow = Engine_Api::_() -> getItem('storage_file', $photo -> file_id);
			$file = $tmpRow -> temporary();
			$fileName = $tmpRow -> name;
		} else if (is_array($photo) && !empty($photo['tmp_name'])) {
			$file = $photo['tmp_name'];
			$fileName = $photo['name'];
		} else if (is_string($photo) && file_exists($photo)) {
			$file = $photo;
			$fileName = $photo;
		} else {
			throw new User_Model_Exception('invalid argument passed to setPhoto');
		}

		if (!$fileName) {
			$fileName = $file;
		}

		$name = basename($file);
		$extension = ltrim(strrchr($fileName, '.'), '.');
		$base = rtrim(substr(basename($fileName), 0, strrpos(basename($fileName), '.')), '.');
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array('parent_type' => $parent -> getType(), 
						'parent_id' => $parent -> getIdentity(), 
						'user_id' => $parent -> owner_id, 
						'name' => $fileName, );

		// Save
		$filesTable = Engine_Api::_() -> getDbtable('files', 'storage');

		// Resize image (main)
		$mainPath = $path . DIRECTORY_SEPARATOR . $base . '_m.' . $extension;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(720, 720) -> write($mainPath) -> destroy();

		// Resize image (normal)
		$normalPath = $path . DIRECTORY_SEPARATOR . $base . '_in.' . $extension;
		$image = Engine_Image::factory();
		$image -> open($file) -> resize(140, 160) -> write($normalPath) -> destroy();

		// Store
		try {
			$iMain = $filesTable -> createFile($mainPath, $params);
			$iIconNormal = $filesTable -> createFile($normalPath, $params);

			$iMain -> bridge($iIconNormal, 'thumb.normal');
		} catch( Exception $e ) {
			// Remove temp files
			@unlink($mainPath);
			@unlink($normalPath);
			// Throw
			if ($e -> getCode() == Storage_Model_DbTable_Files::SPACE_LIMIT_REACHED_CODE) {
				throw new Album_Model_Exception($e -> getMessage(), $e -> getCode());
			} else {
				throw $e;
			}
		}

		// Remove temp files
		@unlink($mainPath);
		@unlink($normalPath);

		// Update row
		$parent -> modified_date = date('Y-m-d H:i:s');
		$parent -> file_id = $iMain -> file_id;
		$parent -> save();

		// Delete the old file?
		if (!empty($tmpRow)) {
			$tmpRow -> delete();
		}

		return $parent;
	}
 }