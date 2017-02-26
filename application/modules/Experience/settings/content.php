<?php

return array(

  // Profile Experiences Widget
  array(
    'title' => 'Experience - Profile Experiences',
    'description' => 'Displays a member\'s experience entries on their profile.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.profile-experiences',
    'defaultParams' => array(
        'title' => 'Experiences',
        'titleCount' => true,
    ),
        'adminForm' => array(
            'elements' => array(
                array(
                    'Heading',
                    'mode_enabled',
                    array(
                        'label' => 'Which view modes are enabled?'
                    )
  ),
                array(
                    'Radio',
                    'mode_list',
                    array(
                        'label' => 'List view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'mode_grid',
                    array(
                        'label' => 'Grid view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'view_mode',
                    array(
                        'label' => 'Which view mode is default?',
                        'multiOptions' => array(
                            'list' => 'List view',
                            'grid' => 'Grid view',
                        ),
                        'value' => 'list',
                    )
                ),
            )
        ),
    ),

  //Experiences Menu Widget
  array(
    'title' => 'Experience - Menu',
    'description' => 'Displays menu experiences on Experience Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experiences-menu',
  ),
  
  // Top Experiences (Most Liked Experiences) Widget
  array(
    'title' => 'Experience - Top Experiences',
    'description' => 'Displays most liked experiences on Experience Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.top-experiences',
    'defaultParams' => array(
      'title' => 'Top Experiences',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array( 'label' => 'Title')),
          array('Text', 'max', array('label' => 'Number of Experiences show on page.',
                                     'value' => 6)),
                array(
                    'Heading',
                    'mode_enabled',
                    array(
                        'label' => 'Which view modes are enabled?'
        )
    ),
                array(
                    'Radio',
                    'mode_list',
                    array(
                        'label' => 'List view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
  ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'mode_grid',
                    array(
                        'label' => 'Grid view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'view_mode',
                    array(
                        'label' => 'Which view mode is default?',
                        'multiOptions' => array(
                            'list' => 'List view',
                            'grid' => 'Grid view',
                        ),
                        'value' => 'list',
                    )
                ),
            )
        ),
    ),

  // New Experiences Widget
   array(
    'title' => 'Experience - New Experiences',
    'description' => 'Displays new experiences on Experience Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.new-experiences',
    'defaultParams' => array(
      'title' => 'New Experiences',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array('label' => 'Title')),
          array('Text', 'max', array( 'label' => 'Number of Experiences show on page.',
                                      'value' => 6)),
                array(
                    'Heading',
                    'mode_enabled',
                    array(
                        'label' => 'Which view modes are enabled?'
        )
     ),
                array(
                    'Radio',
                    'mode_list',
                    array(
                        'label' => 'List view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'mode_grid',
                    array(
                        'label' => 'Grid view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'view_mode',
                    array(
                        'label' => 'Which view mode is default?',
                        'multiOptions' => array(
                            'list' => 'List view',
                            'grid' => 'Grid view',
                        ),
                        'value' => 'list',
                    )
                ),
            )
        ),
    ),

   //Most Viewed Experiences Widget
   array(
    'title' => 'YN- Experience - Most Viewed Experiences',
    'description' => 'Displays most viewed experiences on Experience Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.most-viewed-experiences',
    'defaultParams' => array(
      'title' => 'Most Viewed Experiences',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array( 'label' => 'Title')),
          array('Text', 'max',array( 'label' => 'Number of Experiences show on page.',
                                     'value' => 6)),
                array(
                    'Heading',
                    'mode_enabled',
                    array(
                        'label' => 'Which view modes are enabled?'
        )
     ),
                array(
                    'Radio',
                    'mode_list',
                    array(
                        'label' => 'List view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
   ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'mode_grid',
                    array(
                        'label' => 'Grid view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'view_mode',
                    array(
                        'label' => 'Which view mode is default?',
                        'multiOptions' => array(
                            'list' => 'List view',
                            'grid' => 'Grid view',
                        ),
                        'value' => 'list',
                    )
                ),
            )
        ),
    ),

   //Most Commented Experiences Widget
   array(
    'title' => 'Experience - Most Commented Experiences',
    'description' => 'Displays most commented experiences on Experience Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.most-commented-experiences',
    'defaultParams' => array(
      'title' => 'Most Commented Experiences',
    ),
    'adminForm' => array(
        'elements' => array(
            array('Text', 'title', array('label' => 'Title')),
            array('Text', 'max', array('label' => 'Number of Experiences show on page.',
                                       'value' => 6)),
                array(
                    'Heading',
                    'mode_enabled',
                    array(
                        'label' => 'Which view modes are enabled?'
        )
     ),
                array(
                    'Radio',
                    'mode_list',
                    array(
                        'label' => 'List view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
  ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'mode_grid',
                    array(
                        'label' => 'Grid view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'view_mode',
                    array(
                        'label' => 'Which view mode is default?',
                        'multiOptions' => array(
                            'list' => 'List view',
                            'grid' => 'Grid view',
                        ),
                        'value' => 'list',
                    )
                ),
            )
        ),
    ),
  
  // Related Experiences Widget
   array(
    'title' => 'Experience - Related Experiences',
    'description' => 'Displays related experiences on Experience View Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.detail-related-experiences',
    'defaultParams' => array(
      'title' => 'Related Experiences',
    ),
    'requirements' => array(
						'subject' => 'experience',
				),
    'adminForm' => array(
        'elements' => array(
            array('Text', 'title', array('label' => 'Title')),
            array('Text', 'max', array('label' => 'Number of Experiences show on page.',
                                       'value' => 4)),
        )
     ),
  ),
  
  // Other Experiences Widget
   array(
    'title' => 'Experience - Other Experiences',
    'description' => 'Displays other experiences on Experience View Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.detail-other-experiences',
    'defaultParams' => array(
      'title' => 'Other Experiences',
    ),
    'requirements' => array(
						'subject' => 'experience',
				),
    'adminForm' => array(
        'elements' => array(
            array('Text', 'title', array('label' => 'Title')),
            array('Text', 'max', array('label' => 'Number of Experiences show on page.',
                                       'value' => 4)),
        )
     ),
  ),

  //Featured Experiences Widget
  array(
    'title' => 'Experience - Featured Experiences',
    'description' => 'Displays featured experiences on Experience Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.featured-experiences',
      'defaultParams' => array(
      'title' => 'Featured Experiences',
    ),
  ),
  
  //Featured Experiences Widget - Landing Page
  array(
    'title' => 'Experience - Featured Experiences Landing Page',
    'description' => 'Displays featured experiences on Landing Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.featured-experiences-landing',
      'defaultParams' => array(
      'title' => 'Experiences',
    ),
  ),

  //Experience Categories Widget
  array(
    'title' => 'Experience - Experience Categories',
    'description' => 'Displays experience categories on browse experiences page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experience-categories',
  ),

  //Experience Search Widget
  array(
    'title' => 'Experience - Experiences Search',
    'description' => 'Displays experience search box on browse experiences page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experiences-search',
  ),
  
  //Experience Listing Widget
  array(
    'title' => 'Experience - Experiences Listing',
    'description' => 'Displays list of experiences on Listing Experiences Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experiences-listing',
        'adminForm' => array(
            'elements' => array(
                array('Text', 'max', array('label' => 'Number of Experiences show on page.',
                    'value' => 6)),
                array(
                    'Heading',
                    'mode_enabled',
                    array(
                        'label' => 'Which view modes are enabled?'
                    )
  ),
                array(
                    'Radio',
                    'mode_list',
                    array(
                        'label' => 'List view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'mode_grid',
                    array(
                        'label' => 'Grid view',
                        'multiOptions' => array(
                            1 => 'Yes',
                            0 => 'No',
                        ),
                        'value' => 1,
                    )
                ),
                array(
                    'Radio',
                    'view_mode',
                    array(
                        'label' => 'Which view mode is default?',
                        'multiOptions' => array(
                            'list' => 'List view',
                            'grid' => 'Grid view',
                        ),
                        'value' => 'list',
                    )
                ),
            )
        ),
    ),

  //Experience Statistics
   array(
    'title' => 'Experience - Experience Statistics',
    'description' => 'Displays experience statistics on Experiences Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experiences-statistic',
  ),
  
  //Top Bloggers Widget
  array(
    'title' => 'Experience - Top Bloggers',
    'description' => 'Displays top bloggers on Experiences Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.top-bloggers',
    'defaultParams' => array(
      'title' => 'Top Bloggers',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array('label' => 'Title')),
          array('Text', 'max', array( 'label' => 'Number of Bloggers show on page.',
                                      'value' => 6)),
        )
     ),
   ),

  //View By Date Experiences Widget
  array(
    'title' => 'Experience - View By Date',
    'description' => 'Displays view by date on Experiences Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.view-by-date-experiences',
  ),

  //Experience Tags Widget
  array(
    'title' => 'Experience - Tags',
    'description' => 'Displays tags on Experiences Browse Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experiences-tags',
      'adminForm' => array(
          'elements' => array(
              array('Text', 'max', array('label' => 'Number of items',
                  'value' => 20)),
          )
      ),
  ),

  // Experience Owner Photo Widget
   array(
    'title' => 'Experience - Owner Photo',
    'description' => 'Displays experience owner photo on User Experience List Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.owner-photo',
  ),

    // Experience Gluter Menu Widget
   array(
    'title' => 'Experience - Side Menu',
    'description' => 'Displays experience side menu on User Experience List Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.experiences-side-menu',
   ),

     // Experience User Archieves Widget
   array(
    'title' => 'Experience - User Archive',
    'description' => 'Displays user\'s experience archives Experience List Page.',
    'category' => 'Experiences',
    'type' => 'widget',
    'name' => 'experience.user-experience-archives',
   ),
   
   array(
        'title' => 'Experience - Random Experiences',
        'description' => 'Displays a random list of experiences.',
        'category' => 'Experiences',
        'type' => 'widget',
        'name' => 'experience.random-experiences',
        'defaultParams' => array(
            'title' => 'Experiences',
        ),
        'adminForm' => array(
            'elements' => array(
                array(
                    'Text',
                    'title',
                    array(
                        'label' => 'Title'
                    )
                ),
                array(
                    'Integer',
                    'num_of_experiences',
                    array(
                        'label' => 'Number of experiences will show?',
                        'value' => 3,
                    ),
                ),
            ),
        ),
    ),
)?>