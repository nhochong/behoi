<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Classified
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: content.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
return array(
  array(
    'title' => 'Profile Classifieds',
    'description' => 'Displays a member\'s classifieds on their profile.',
    'category' => 'Classifieds',
    'type' => 'widget',
    'name' => 'classified.profile-classifieds',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Classifieds',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Popular Classifieds',
    'description' => 'Displays a list of most viewed classifieds.',
    'category' => 'Classifieds',
    'type' => 'widget',
    'name' => 'classified.list-popular-classifieds',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Popular Classifieds',
    ),
    'requirements' => array(
      'no-subject',
    ),
    'adminForm' => array(
      'elements' => array(
        array(
          'Radio',
          'popularType',
          array(
            'label' => 'Popular Type',
            'multiOptions' => array(
              'view' => 'Views',
              'comment' => 'Comments',
            ),
            'value' => 'view',
          )
        ),
      )
    ),
  ),
  array(
    'title' => 'Recent Classifieds',
    'description' => 'Displays a list of recently posted classifieds.',
    'category' => 'Classifieds',
    'type' => 'widget',
    'name' => 'classified.list-recent-classifieds',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Recent Classifieds',
    ),
    'requirements' => array(
      'no-subject',
    ),
    'adminForm' => array(
      'elements' => array(
        array(
          'Radio',
          'recentType',
          array(
            'label' => 'Recent Type',
            'multiOptions' => array(
              'creation' => 'Creation Date',
              'modified' => 'Modified Date',
            ),
            'value' => 'creation',
          )
        ),
      )
    ),
  ),
  
  array(
    'title' => 'Classified Browse Search',
    'description' => 'Displays a search form in the poll browse page.',
    'category' => 'Classifieds',
    'type' => 'widget',
    'name' => 'classified.browse-search',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Classified Browse Menu',
    'description' => 'Displays a menu in the poll browse page.',
    'category' => 'Classifieds',
    'type' => 'widget',
    'name' => 'classified.browse-menu',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Classified Browse Quick Menu',
    'description' => 'Displays a small menu in the poll browse page.',
    'category' => 'Classifieds',
    'type' => 'widget',
    'name' => 'classified.browse-menu-quick',
    'requirements' => array(
      'no-subject',
    ),
  ),
	array(
        'title' => 'Browse Categories',
        'description' => 'Displays categories level 1 and child.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.browse-category',
        'defaultParams' => array(
          'title' => 'Browse Categories',
        ),
        'requirements' => array(
            'no-subject',
        ),
    ),
	array(
        'title' => 'List Categories',
        'description' => 'Displays a list of categories.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.list-categories',
        'defaultParams' => array(
            'title' => 'Categories',
        ),
    ),
	array(
        'title' => 'Browse Classifieds',
        'description' => 'Displays a list of Classifieds.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.browse-classifieds',
		'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Browse Classifieds',
        ),
        'requirements' => array(
            'no-subject',
        ),
    ),
	array(
        'title' => 'Hot Classifieds',
        'description' => 'Displays a list of Classifieds.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.hot-classifieds',
		'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Hot Classifieds',
        ),
        'requirements' => array(
            'no-subject',
        ),
    ),
	array(
        'title' => 'Menu Categories',
        'description' => 'Displays menu categories level 1 and child.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.menu-category'
    ),
	array(
        'title' => 'Related Classifieds',
        'description' => 'Displays a list of other listings that has the same category to the current Classified.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.related-classifieds',
		'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Related Classifieds',
        ),
		'requirements' => array(
            'subject' => 'classified',
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
                    'num_of_classifieds',
                    array(
                        'label' => 'Number of classifieds will show?',
                        'value' => 3,
                    ),
                ),
            ),
        ),
    ),
	array(
        'title' => 'Browse Categories Slide',
        'description' => 'Displays Slide categories.',
        'category' => 'Classifieds',
        'type' => 'widget',
        'name' => 'classified.browse-category-slide',
        'defaultParams' => array(
          'title' => 'Browse Categories',
        ),
        'requirements' => array(
            'no-subject',
        ),
    ),
) ?>