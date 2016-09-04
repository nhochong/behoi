<?php
class Ynlistings_Form_Admin_Settings_Global extends Engine_Form {
    public function init() {
        $this
        ->setTitle('Global Settings')
        
        ->setDescription('YNLISTINGS_GLOBAL_SETTINGS_DESCRIPTION');
        
        $settings = Engine_Api::_()->getApi('settings', 'core');
        
        $videoTypeOptions = array();
        $video_enable = Engine_Api::_() -> ynlistings() -> checkYouNetPlugin('video');
        $ynvideo_enable = Engine_Api::_() -> ynlistings() -> checkYouNetPlugin('ynvideo');
        $ynultimatevideo_enable = Engine_Api::_() -> ynlistings() -> checkYouNetPlugin('ynultimatevideo');
        if ($video_enable || $ynvideo_enable)
            $videoTypeOptions['video'] = $ynvideo_enable ? 'Advanced Videos' : 'Video';
        if ($ynultimatevideo_enable)
            $videoTypeOptions['ynultimatevideo_video'] = 'Ultimate Videos';
        $this->addElement('Integer', 'max_listings', array(
            'label' => 'Maximum listings can be imported each time',
            'value' => $settings->getSetting('ynlistings_max_listings', 100),
            'validators' => array(
                new Engine_Validate_AtLeast(0),
            ),
        ));
        
        $this->addElement('Integer', 'new_days', array(
            'label' => 'Mark a listing as "New Listing" within ? day(s) after getting approval.',
            'value' => $settings->getSetting('ynlistings_new_days', 3),
            'validators' => array(
                new Engine_Validate_AtLeast(1),
            ),
        ));
        
        if (count($videoTypeOptions) > 1)
        $this->addElement('Radio', 'video_type', array(
            'label' => 'Which video module will be used for listing',
            'description' => 'This selection will be effected to all listings in the Listing module. Users can have the auto-suggested videos while adding / editing listing based on the selected video module. This is also applied to the listing detail in case your users want to add more videos as listing\'s materials',
            'multiOptions' => $videoTypeOptions,
            'value' => $settings->getSetting('ynlistings_video_type', 'video'),
        ));
        $this->addElement('Button', 'submit', array(
          'label' => 'Save Changes',
          'type' => 'submit',
          'ignore' => true
        ));
    }
}