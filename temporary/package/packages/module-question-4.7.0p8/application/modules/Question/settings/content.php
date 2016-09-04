<?php
$form_recent = array(
                array(
                        'Text',
                        'title',
                        array(
                          'label' => 'Title'
                        )
                      ),
                array(
                        'Select',
                        'show_num_r_q',
                        array(
                          'label' => 'Questions to output',
                          'value' => 5,
                          'multiOptions' => array(
                            1 => 1,
                            2 => 2,
                            3 => 3,
                            4 => 4,
                            5 => 5,
                            6 => 6,
                            7 => 7,
                            8 => 8,
                            9 => 9,
                            10 => 10,
                            11 => 11,
                            12 => 12,
                            13 => 13,
                            14 => 14,
                            15 => 15,
                            16 => 16,
                            17 => 17,
                            18 => 18,
                            19 => 19,
                            20 => 20
                          )
                        )
                    ));
        
if (($cats_on = Engine_Api::_()->getApi('settings', 'core')->getSetting('question_category', 1))) {
    $categories = Engine_Api::_()->question()->getCategories();
    $categoriesMultiOption = array('' => 'All');
    foreach( $categories as $category )
    {
      $categoriesMultiOption[$category->category_id] = $category->category_name;
    }
    $form_recent[] = array(
          'Select',
          'category',
          array(
            'label' => 'Questions to output',
            'value' => 5,
            'multiOptions' => $categoriesMultiOption
          )
        );
}
return array(
    array(
    'title' => 'Profile Questions & Answers',
    'description' => 'Displays member\'s Question & Answer entries on their profile.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.profile-questions',
    'defaultParams' => array(
      'title' => 'Q&A',
      'titleCount' => false,
    ),
  ),
  array(
    'title' => 'Recent Questions',
    'description' => 'Displays recent questions.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.list-recent-questions',
    'adminForm' => array(
      'elements' => $form_recent
    ),
    'defaultParams' => array(
      'title' => 'Recent Questions'
    )
  ),
  array(
    'title' => 'Popular Questions',
    'description' => 'Displays most popular questions.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.list-most-popular-questions',
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
          'Select',
          'show_num_pop_q',
          array(
            'label' => 'Questions to Output',
            'value' => 5,
            'multiOptions' => array(
              1 => 1,
              2 => 2,
              3 => 3,
              4 => 4,
              5 => 5,
              6 => 6,
              7 => 7,
              8 => 8,
              9 => 9,
              10 => 10,
              11 => 11,
              12 => 12,
              13 => 13,
              14 => 14,
              15 => 15,
              16 => 16,
              17 => 17,
              18 => 18,
              19 => 19,
              20 => 20
            )
          )
        ),
      )
    ),
    'defaultParams' => array(
      'title' => 'Most Popular Questions'
    )
  ),
  array(
    'title' => 'Most Answered Questions',
    'description' => 'Displays most answered questions.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.list-most-answered-questions',
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
          'Select',
          'show_num_ans_q',
          array(
            'label' => 'Questions to Output',
            'value' => 5,
            'multiOptions' => array(
              1 => 1,
              2 => 2,
              3 => 3,
              4 => 4,
              5 => 5,
              6 => 6,
              7 => 7,
              8 => 8,
              9 => 9,
              10 => 10,
              11 => 11,
              12 => 12,
              13 => 13,
              14 => 14,
              15 => 15,
              16 => 16,
              17 => 17,
              18 => 18,
              19 => 19,
              20 => 20
            )
          )
        ),
      )
    ),
    'defaultParams' => array(
      'title' => 'Most Answered Questions'
    )
  ),
  array(
    'title' => 'Recent Answers',
    'description' => 'Displays recent questions on home page.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.list-recent-answers',
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
          'Select',
          'show_num_r_a',
          array(
            'label' => 'Answers',
            'value' => 5,
            'multiOptions' => array(
              1 => 1,
              2 => 2,
              3 => 3,
              4 => 4,
              5 => 5,
              6 => 6,
              7 => 7,
              8 => 8,
              9 => 9,
              10 => 10,
              11 => 11,
              12 => 12,
              13 => 13,
              14 => 14,
              15 => 15,
              16 => 16,
              17 => 17,
              18 => 18,
              19 => 19,
              20 => 20
            )
          )
        ),
      )
    ),
    'defaultParams' => array(
      'title' => 'Recent Answers'
    )
  ),
 array(
    'title' => 'Top Rated Users',
    'description' => 'Displays most helpful users on Q&A section.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.list-top-users',
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
          'Select',
          'num_items',
          array(
            'label' => 'Users',
            'value' => 4,
            'multiOptions' => array(
              1 => 1,
              2 => 2,
              3 => 3,
              4 => 4,
              5 => 5,
              6 => 6,
              7 => 7,
              8 => 8,
              9 => 9,
              10 => 10,
              11 => 11,
              12 => 12,
              13 => 13,
              14 => 14,
              15 => 15,
              16 => 16,
              17 => 17,
              18 => 18,
              19 => 19,
              20 => 20
            )
          )
        ),
        array(
          'Radio',
          'top_period',
          array(
            'label' => 'Top Period',
            'value' => 'all',
            'multiOptions' => array(
              'month' => 'Past month.',
              'all' => 'All Time'
            )
          )
        ),
      )
    ),
    'defaultParams' => array(
      'title' => 'Top Q&A Users Ratings',
      'num_items' => 4,
      'top_period' => 'all'
    ),
  ),
 array(
    'title' => 'Questions by Relevance',
    'description' => 'Displays questions by relevance.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.list-relevance-questions',
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
          'Select',
          'per_page',
          array(
            'label' => 'Questions to Output',
            'multiOptions' => array(
              1 => 1,
              2 => 2,
              3 => 3,
              4 => 4,
              5 => 5,
              6 => 6,
              7 => 7,
              8 => 8,
              9 => 9,
              10 => 10,
              11 => 11,
              12 => 12,
              13 => 13,
              14 => 14,
              15 => 15,
              16 => 16,
              17 => 17,
              18 => 18,
              19 => 19,
              20 => 20
            )
          )
        ),
        array(
          'Text',
          'hours_new_label',
          array(
            'label' => 'Hours New Label',
            'validators' => array('Digits', array('validator' => 'GreaterThan', 'options' => array(0)))  
          )
        )  
      )
    ),
    'defaultParams' => array(
      'title' => 'Questions by relevance',
      'per_page' => 5,
      'hours_new_label' => 24  
    )
  ),
  array(
    'title' => 'Q&A Browse Menu',
    'description' => 'Displays a menu in the Q&A browse page.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.browse-menu',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Q&A Browse Search',
    'description' => 'Displays a search form in the Q&A browse page.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.browse-search',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'How do I collect points?',
    'description' => 'Show info how members to collect points.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.how-collect-points',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Ask a Question',
    'description' => 'Show link "Ask a Question".',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.ask-question',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Rating User Search',
    'description' => 'Displays a search form in the rating page.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.rating-user-search',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Update Ratings',
    'description' => 'Show link for update rating.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.update-ratings',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Profile Q&A Info',
    'description' => 'Displays a member\'s info (points, questions, answers and best answers) on their profile.',
    'category' => 'Questions',
    'type' => 'widget',
    'name' => 'question.profile-info',
    'defaultParams' => array(
      'title' => 'Q&A Info',
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
        'title' => "Social Sharing" ,
        'description' => 'Displays Facebook, twitter, g+ buttons.',
        'category' => 'Questions',
        'type' => 'widget',
        'name' => 'question.share-social',

        'defaultParams' => array(
            'title' => "Social Sharing"
        )
    )
) ?>
