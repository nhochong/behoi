<?php

/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Album
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: Photo.php 9071 2011-07-20 23:43:30Z john $
 * @author     Sami
 */

/**
 * @category   Application_Extensions
 * @package    Album
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 */
class Ynforum_Model_Photo extends Core_Model_Item_Abstract {

    protected function _postDelete() {
        $mainPhoto = Engine_Api::_()->getItemTable('storage_file')->getFile($this->file_id);
        $thumbPhoto = Engine_Api::_()->getItemTable('storage_file')->getFile($this->file_id, 'thumb.normal');

        // Delete thumb
        if ($thumbPhoto && $thumbPhoto->getIdentity()) {
            try {
                $thumbPhoto->delete();
            } catch (Exception $e) {
                
            }
        }

        // Delete main
        if ($mainPhoto && $mainPhoto->getIdentity()) {
            try {
                $mainPhoto->delete();
            } catch (Exception $e) {
                
            }
        }

        // Change album cover if applicable
        try {
            if (!empty($this->album_id) && !$this->skipAlbumDeleteHook) {
                $album = $this->getAlbum();
                $nextPhoto = $this->getNextPhoto();
                if (($album instanceof Album_Model_Album) &&
                        ($nextPhoto instanceof Album_Model_Photo) &&
                        (int) $album->photo_id == (int) $this->getIdentity()) {
                    $album->photo_id = $nextPhoto->getIdentity();
                    $album->save();
                }
            }
        } catch (Exception $e) {
            
        }
        parent::_postDelete();
    }

    public function setPhoto($photo) {
        if ($photo instanceof Zend_Form_Element_File) {
            $file = $photo->getFileName();
            $fileName = $file;
        } else if ($photo instanceof Storage_Model_File) {
            $file = $photo->temporary();
            $fileName = $photo->name;
        } else if ($photo instanceof Core_Model_Item_Abstract && !empty($photo->file_id)) {
            $tmpRow = Engine_Api::_()->getItem('storage_file', $photo->file_id);
            $file = $tmpRow->temporary();
            $fileName = $tmpRow->name;
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
        $params = array(
            'parent_type' => $this->getType(),
            'parent_id' => $this->getIdentity(),
            'user_id' => $this->owner_id,
            'name' => $fileName,
        );

        // Save
        $filesTable = Engine_Api::_()->getDbtable('files', 'storage');

        // Resize image (main)
        $mainPath = $path . DIRECTORY_SEPARATOR . $base . '_m.' . $extension;
        $image = Engine_Image::factory();
        $image->open($file)
                ->resize(720, 720)
                ->write($mainPath)
                ->destroy();

        // Resize image (normal)
        $normalPath = $path . DIRECTORY_SEPARATOR . $base . '_in.' . $extension;
        $image = Engine_Image::factory();
        $image->open($file)
                ->resize(140, 160)
                ->write($normalPath)
                ->destroy();

        // Store
        try {
            $iMain = $filesTable->createFile($mainPath, $params);
            $iIconNormal = $filesTable->createFile($normalPath, $params);

            $iMain->bridge($iIconNormal, 'thumb.normal');
        } catch (Exception $e) {
            // Remove temp files
            @unlink($mainPath);
            @unlink($normalPath);
            // Throw
            if ($e->getCode() == Storage_Model_DbTable_Files::SPACE_LIMIT_REACHED_CODE) {
                throw new Ynforum_Model_Exception($e->getMessage(), $e->getCode());
            } else {
                throw $e;
            }
        }

        // Remove temp files
        @unlink($mainPath);
        @unlink($normalPath);

        // Update row
        $this->modified_date = date('Y-m-d H:i:s');
        $this->file_id = $iMain->file_id;
        $this->save();

        // Delete the old file?
        if (!empty($tmpRow)) {
            $tmpRow->delete();
        }

        return $this;
    }

    /**
     * Gets a url to the current photo representing this item. Return null if none
     * set
     *
     * @param string The photo type (null -> main, thumb, icon, etc);
     * @return string The photo url
     */
    public function getPhotoUrl($type = null) {
        if (empty($this->file_id)) {
            return null;
        }

        $file = Engine_Api::_()->getItemTable('storage_file')->getFile($this->file_id, $type);
        if (!$file) {
            return null;
        }

        return $file->map();
    }
}