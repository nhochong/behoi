UPDATE `engine4_activity_notificationtypes` SET `body` = '{item:$subject} has commented an answer to the question {item:$object:$label}' WHERE `type` = 'answer_new_comment' AND `module` = 'question';

INSERT IGNORE into `engine4_activity_actiontypes`(`type`,`module`,`body`,`enabled`,`displayable`,`attachable`,`commentable`,`shareable`,`is_generated`)
                                          values
                                                 -- only answer is anonymous
                                                 ('answer_new_a_a','question','Somebody posted an anonymous reply to {item:$owner}\'s question:',1,5,1,0,0,1),
                                                 -- only question is anonymous
                                                 ('answer_new_q_a','question','{item:$subject} answered an anonymous question:',1,5,1,0,0,1),
                                                 -- question && answer are anonymous
                                                 ('answer_new_a_q','question','Somebody posted an anonymous reply to question:',1,5,1,0,0,1);

