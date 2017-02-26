<?php
// wget -O - "http://<yoursite>/application/lite.php?module=experience&name=task"

$application -> getBootstrap() -> bootstrap('translate');
$application -> getBootstrap() -> bootstrap('locale');
$application -> getBootstrap() -> bootstrap('hooks');

$allowCron = Engine_Api::_()->getApi('settings', 'core')->getSetting('experience.cron', 1);

if($allowCron)
{
    //log
    $strLog = "";
    $strLog .= "\n###############################################\n";
    $strLog .= "Start get data\n";
    $linkTbl = Engine_Api::_()->getDbTable('links', 'experience');
    $links = $linkTbl -> getLinksPaginator(array('limit' => 2, 'orderby' => 'last_run', 'direction' => 'ASC', 'enable' => 1));
    if($links -> getTotalItemCount())
    {
        require_once (APPLICATION_PATH.'/application/modules/Experience/controllers/YnsRSSFeed/YnsRSS.php');
        set_time_limit(0);
        $rss = new YnsRSS ();
        $is_approved = Engine_Api::_ ()->getApi ( 'settings', 'core' )->getSetting ( 'experience.moderation', 0 ) ? 0 : 1;
        foreach ($links as $link) 
        {
            $user = Engine_Api::_ ()-> getItem('user', $link -> user_id);
            if(!$user)
            {
                continue;
            }
            $user_id = $link -> user_id;
            $max_experiences = Engine_Api::_ ()->getItemTable ( 'experience' )->checkMaxExperiences($user);
            $experience_number = Engine_Api::_ ()->getItemTable ( 'experience' )->getCountExperience ($user);
            
            $link -> last_run = new Zend_Db_Expr('NOW()');
            $link->save();
            
            $feed = $rss->getParse ( null, $link -> link_url, null );
            if (empty ( $feed ['entries'] )) 
            {
                continue;
            }
            $feeds = array_reverse ( $feed ['entries'] );
            // count experiences
            $count = $experience_number;
            foreach ( $feeds as $entry ) 
            {
                $a = date ( 'Y-m-d', $entry ['pubDate'] );
                $pubdate = strtotime ( $a );
                // insert data to database
                $db = Engine_Api::_ ()->getItemTable ( 'experience' )->getAdapter();
                $db->beginTransaction ();
    
                try {
                    // check news exist by link
                    $experience_table = Engine_Api::_ ()->getItemTable ( 'experience' );
                    $experience_select = $experience_table->select ()->where ( 'link_detail = ?', $entry ['link_detail'] );
                    $experience = $experience_table->fetchRow ( $experience_select );
                    if ($experience) 
                    {
                        $experience->title = $entry ['title'];
                        $experience->pub_date = $pubdate;
                        $experience->modified_date = date ( 'Y-m-d H:i:s' );
                        if (! empty ( $entry ['content'] )) {
                            $experience->body = $entry ['content'];
                        } else {
                            $experience->body = $entry ['description'];
                        }
                        $experience->is_approved = $is_approved;
                        $experience->save ();
                    } 
                    else 
                    {
                        if ($max_experiences != 0 && $count >= $max_experiences) 
                        {
                            break;
                        }
                        $experience = $experience_table->createRow ();
                        $experience->owner_type = "user";
                        $experience->owner_id = $user_id;
                        $experience->category_id = 0;
                        $experience->creation_date = date ( 'Y-m-d H:i:s' );
                        $experience->modified_date = date ( 'Y-m-d H:i:s' );
                        $experience->pub_date = $pubdate;
                        $experience->link_detail = $entry ['link_detail'];
                        if (! empty ( $entry ['title'] )) {
                            $experience->title = $entry ['title'];
                        } else {
                            $experience->title = 'Untitled Experience';
                        }
                        if (! empty ( $entry ['content'] )) {
                            $experience->body = $entry ['content'];
                        } else {
                            $experience->body = $entry ['description'];
                        }
                        $experience->is_approved = $is_approved;
                        if ($experience->is_approved) {
                            $experience->add_activity = 1;
                        }
    
                        $experience->save ();
                        $count ++;
    
                        // set auth
                        $auth = Engine_Api::_ ()->authorization ()->context;
                        $roles = array (
                                'owner',
                                'owner_member',
                                'owner_member_member',
                                'owner_network',
                                'everyone'
                        );
                        $auth_view = "everyone";
                        $auth_comment = "everyone";
                        $viewMax = array_search ( $auth_view, $roles );
                        $commentMax = array_search ( $auth_comment, $roles );
                        foreach ( $roles as $i => $role )
                            $auth->setAllowed ( $experience, $role, 'view', ($i <= $viewMax) );
                        $auth->setAllowed ( $experience, $role, 'comment', ($i <= $commentMax) );
    
                        if ($experience->is_approved) {
                            $owner = $experience->getParent ();
                            $action = Engine_Api::_ ()->getDbtable ( 'actions', 'activity' )->addActivity ( $owner, $experience, 'experience_import' );
    
                            // Make sure action exists before attaching the experience
                            // to the activity
                            if ($action) {
                                Engine_Api::_ ()->getDbtable ( 'actions', 'activity' )->attachActivity ( $action, $experience );
                            }
    
                            // Send notifications for subscribers
                            Engine_Api::_ ()->getDbtable ( 'subscriptions', 'experience' )->sendNotifications ( $experience );
    
                        }
                    }
                    $db->commit ();
                } catch ( Exception $e ) {
                    throw $e;
                    $db->rollBack ();
                }
            }
           
        }
    }
    $strLog .= "End get data\n";
    $resource_path = APPLICATION_PATH . "/temporary/log/experience.cronjob.log";
    $writer = new Zend_Log_Writer_Stream($resource_path);
    $logger = new Zend_Log($writer);
    $logger->info($strLog);
    exit;
}
?>
