<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Install
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */

return array(
  // Package -------------------------------------------------------------------
  'package' => array(
    'type' => 'core',
    'name' => 'install',
    'version' => '4.8.11',
    'revision' => '$Revision: 10271 $',
    'path' => '/',
    'repository' => 'socialengine.com',
    'title' => 'Package Manager',
    'description' => 'Package Manager',
    'author' => 'Webligo Developments',
    'changeLog' => array(
      '4.8.11' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/forms/Account.php' => 'Removed TLD validation from email field in admin account creation form',
        'install/controllers/InstallController.php' => 'Updated text for APCu Extension',
      ),
      '4.8.10' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/import/Ning/ForumPosts.php' => 'Fixed an issue with Ning Importer where forum\'s id was not getting set for posts',
        'install/import/Ning/ForumTopics.php' => 'Fixed an issue with Ning Importer where privacy was not getting set for forums',
        'install/controllers/InstallController.php' => 'Added a check for exif extension, which is required for correct rotation of photos uploaded via mobile devices to the list of recommended PHP extensions'
      ),
      '4.8.9'  => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/import/JsonAbstract.php' => 'Reversing import data array',
        'install/import/Ning/*' => 'Updated code for fixing issues with importing',
        'install/import/Ning/Activities.php' => 'Added',
        'install/import/Ning/BlogComments.php' => 'Added',
        'install/import/Ning/CoreContent.php' => 'Added',
        'install/import/Ning/CorePages.php' => 'Added',
        'install/views/scripts/import/ning-instructions.tpl' => 'Updated URL of "Ning Archive Tool"'
      ),
      '4.8.8' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/InstallController.php' => 'Improved text to mark Multi-byte String (mbstring) extension check as required'
      ),
      '4.8.7' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/InstallController.php' => 'Updated code to change minimum PHP version requirement to "5.2.11"',
        'install/index.php' => 'Updated code to change minimum PHP version requirement to "5.2.11"'
      ),
      '4.8.6' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/import/Ning/ForumPosts.php' => 'Corrected order of forum posts imported by Ning Importer',
      ),
      '4.8.2' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/layouts/scripts/default.tpl' => 'Added check/uncheck all buttons',
      ),
      '4.8.1' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/layouts/scripts/default.tpl' => 'Package manager now does not break when viewed over SSL',
      ),
      '4.5.0' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/InstallController.php' => 'Admin now has default profile type',
      ),
      '4.3.0' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/externals/images/socialengine_logo_admin.png' => 'Changed logo',
        'install/externals/images/compat.css' => 'Changed styles',
        'install/externals/images/sdk.css' => 'Changed styles',
        'install/externals/images/styles.css' => 'Changed styles',
        'install/config/manifest.php' => 'Changed styles',
        'install/views/scripts/manage/index.tpl' => 'Changed styles',
      ),
      '4.2.2' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/SdkController.php' => 'Added replace param to headers',
        'install/layouts/scripts/default.tpl' => 'Upgraded to MooTools 1.4',
      ),
      '4.2.1'  => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/views/scripts/manage/prepare.tpl' => 'Fixed typo',
      ),
      '4.2.0'  => array(
        'install/controllers/InstallController.php' => 'Disable strict SQL mode for installation',
        'install/config/manifest.php' => 'Incremented version',
      ),
      '4.1.8p1'  => array(
        'install/Bootstrap.php' => 'Fixed issue with detecting invalid session configuration',
        'install/config/manifest.php' => 'Incremented version',
      ),
      '4.1.8'  => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/InstallController.php' => 'Added code to execute install hooks on main install',
        'install/controllers/ManageController.php' => 'Fixing notices',
        'install/data/skeletons/module/views/scripts/index\index.tpl.template' => 'Fixed typo that caused incorrect example output',
        'install/import/Ning/AlbumPhotos.php' => 'Fixed column to work with latest album changes',
        'install/import/Ning/ForumPosts.php' => 'Fixed issue with importing uncategorized forum topics and posts',
        'install/import/Ning/ForumTopics.php' => 'Fixed issue with importing uncategorized forum topics and posts',
        'install/import/Version3/AlbumPhotos.php' => 'Fixed column to work with latest album changes',
        'install/views/scripts/manage/select.tpl' => 'Fixed issue with upload timeouts',
        'install/views/scripts/sdk/manage.tpl' => 'Fixed typo in path in description',
      ),
      '4.1.7' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/layouts/scripts/default.tpl' => 'Upgraded MooTools to 1.3 (compat)',
      ),
      '4.1.6' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/import/Version3/ClassifiedClassifieds.php' => 'Fixed description import error',
      ),
      '4.1.5' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/views/helpers/PackageSelect.php' => 'Fixed issue with deleting uploaded packages',
        'install/views/scripts/manage/select.tpl' => 'Fixed issue with deleting uploaded packages',
      ),
      '4.1.4' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controller/InstallController.php' => 'Added optional opt-in branding check',
        'install/layouts/scripts/default.tpl' => 'Removed incorrect text and changed title during installation',
      ),
      '4.1.3' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/import/PollPolls.php' => 'Fixed error importing polls',
      ),
      '4.1.2' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/ManageController.php' => 'Fixed issue where missing files in the root directory would cause "parent path not found" error message',
        'install/controllers/SdkController.php' => 'Updated to reflect recent changes',
        'install/forms/Account.php' => 'Added trim to email',
        'install/import/Abstract.php' => 'Fixed error importing photos',
        'install/views/scripts/sdk/build.tpl' => 'Updated to reflect recent changes',
      ),
      '4.1.1' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/ToolsController.php' => 'PHP 5.1 compatibility',
        'install/import/Version3/AbstractFields.php' => 'Removed verbose logging',
        'install/import/Version3/Networks.php' => 'Fixed translation of network titles',
      ),
      '4.1.0' => array(
        'install/Bootstrap.php' => 'Moved log initialization earlier to catch more errors; added error messages when cache is not writable; added fix for weird server configurations; added check for bad session configurations (that were recommended by Drupal)',
        'install/index.php' => 'Improved rewrite detection',
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/BackupController.php' => 'Added silencing to failed set_time_limit() calls',
        'install/controllers/ErrorController.php' => 'Fixed typo that would cause a fatal error on an exception',
        'install/controllers/ImportController.php' => 'Added silencing to failed set_time_limit() calls',
        'install/controllers/InstallController.php' => 'Added payment to default installed modules',
        'install/controllers/ManageController.php' => 'Added silencing to failed set_time_limit() calls; speed improvements to permissions checking; added cache flushing on package operations',
        'install/controllers/ToolsController.php' => 'Logs are viewable from the installer; improved compare utility',
        'install/externals/styles/styles.css' => 'Added styles',
        'install/forms/Account.php' => 'Added timezone option to account creation form',
        'install/forms/Tools/LogFilter.php' => 'Added',
        'install/import/JsonAbstract.php' => 'Fixed issue caused by fubared JSON produced by the Ning export tool',
        'install/import/Version3/AbstractFields.php' => 'Fixed issue with importing profile fields in the correct order; fixed issue with importing radio options; fixed issue with importing some select values',
        'install/views/scripts/manage/prepare.tpl' => 'Fixed incorrect package version',
        'install/views/scripts/tools/compare.tpl' => 'Improved compare utility',
        'install/views/scripts/tools/index.tpl' => 'Added log browser',
        'install/views/scripts/tools/log.tpl' => 'Added',
      ),
      '4.0.7' => array(
        'install/.htaccess' => 'Added 404 and rewrite detection from main application',
        'install/Bootstrap.php' => 'Changed logging to only log critical errors when in production mode',
        'install/index.php' => 'Added 404 and rewrite detection from main application',
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/CompareController.php' => 'Moved to ToolsController.php',
        'install/controllers/ErrorController.php' => 'Changed logging to only log critical errors when in production mode',
        'install/controllers/ImportController.php' => 'Clears access token on completion',
        'install/controllers/InstallController.php' => 'Tweaked sanity check; will now log user into the package manager and admin panel on completion',
        'install/controllers/ManagerController.php' => 'Memory usage improvements; temporary path detection improvements; added handling for upgrading installer',
        'install/controllers/ToolsController.php' => 'Added',
        'install/controllers/UtilityController.php' => 'Added docblock',
        'install/controllers/VfsController.php' => 'Added docblock',
        'install/externals/styles/styles.css' => 'Added some styles',
        'install/import/DbAbstract.php' => 'Silencing notice',
        'install/import/Version3/Abstract.php' => 'Improving error handling',
        'install/import/Version3/BlogBlogs.php' => 'Improving error handling',
        'install/import/Version3/EventMembership.php' => 'Fixed import of RSVP value (see note in file for fixes)',
        'install/import/Version3/VideoVideos.php' => 'Fixed typo in video thumbnails',
        'install/views/scripts/_installerUpdated.tpl' => 'Added',
        'install/views/scripts/_rawError.tpl' => 'Added keywords',
        'install/views/scripts/compare/*' => 'Moved to tools',
        'install/views/scripts/manage/prepare.tpl' => 'Compatibility for memory usage improvements',
        'install/views/scripts/manage/select.tpl' => 'Compatibility for memory usage improvements',
        'install/views/scripts/tools/*' => 'Added',
      ),
      '4.0.6' => array(
        'install/Bootstrap.php' => 'Silence error messages on undefined UA key',
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/ImportController.php' => 'Increased cache lifetime; added new configuration options to migration; added email on completion of migration; added even better error handling',
        'install/controllers/ManageController.php' => 'Fixed weird problem with displaying log messages in query step',
        'install/forms/Import/Version3.php' => 'Added lots of new configuration options to migration',
        'install/import/Abstract.php' => 'Added new configuration options to migration',
        'install/import/DbAbstract.php' => 'Fixed memory problems when importing extremely large sites; added timeout detection',
        'install/import/Version3/AbstractFields.php' => 'Now utilizes batch mode',
        'install/import/Version3/MessagesConversations.php' => 'Added conversation title support; fixed recipient count',
        'install/import/Version3/MessagesMessages.php' => 'Removed untranslated "Re:" from message titles',
        'install/import/Version3/UserAdmins.php' => 'Fixed possible bug in batch mode',
        'install/layouts/scripts/default.tpl' => 'Updated mootools',
        'install/views/scripts/import/version3-split.tpl' => 'Improved progress reporting; got rid of that annoying javascript alert box on completion',
        'install/views/scripts/manage/complete.tpl' => 'Fixed incorrect admin link',
      ),
      '4.0.5' => array(
        'install/.htaccess' => 'Better handling of missing files',
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/ImportController.php' => 'Version 3 import supports splitting up into separate requests',
        'install/externals/styles/styles.css' => 'Style tweak',
        'install/forms/Import/Version3.php' => 'Various enhancements',
        'install/import/*' => 'Various enhancements; added search indexing; improved privacy import; better exception handling; supports splitting up into separate requests',
        'install/views/scripts/import/version3-split.tpl' => 'Version 3 import supports splitting up into separate requests',
        'install/views/scripts/manage/prepare.tpl' => 'Style tweak',
      ),
      '4.0.4' => array(
        'install/controllers/AuthController.php' => 'Removed var_dump on failed login',
        'install/controllers/ImportController.php' => 'Added missing authentication check',
        'install/controllers/SdkController.php' => 'Added missing authentication check',
        'install/controllers/UtilityController.php' => 'Added missing authentication check',
        'install/externals/images/package.png' => 'Added',
        'install/externals/styles/styles.css' => 'Style tweaks for importers',
        'install/import/Abstract.php' => 'Fixed logging bug',
        'install/import/Version3/AbstractComments.php' => 'Fixed incorrect type for self comments',
        'install/views/scripts/install/db-sanity.tpl' => 'Style tweak',
        'install/views/scripts/install/sanity.tpl' => 'Style tweak',
        'install/views/scripts/manage/prepare.tpl' => 'Style tweak',
      ),
      '4.0.3' => array(
        'install/config/manifest.php' => 'Incremented version',
        'install/controller/ImportController.php' => 'Added SE3 Importer',
        'install/controller/ManagerController.php' => 'Added backwards compatibility for unreleased library-engine-4.0.2 features',
        'install/externals/styles/*' => 'Added styles for importer',
        'install/import/Version3/*' => 'Added SE3 Importer',
      ),
      '4.0.2' => array(
        'install/Bootstrap.php' => 'Added main navigation',
        'install/config/manifest.php' => 'Incremented',
        'install/controllers/AuthController.php' => 'Logout now redirects to return url even if already logged out',
        'install/controllers/ImportController.php' => 'Added Ning Import Tool',
        'install/controllers/InstallController.php' => 'Added placeholder',
        'install/controllers/ManageController.php' => 'Moved main navigation',
        'install/data/skeletons/module/Bootstrap.php.template' => 'Fixed bug in skeleton module generation',
        'install/externals/styles/*' => 'Added styles for main navigation and import tools',
        'install/forms/Import/*' => 'Added Ning Import Tool',
        'install/import/*' => 'Added Ning Import Tool',
        'install/layouts/scripts/default.tpl' => 'Added main navigation',
        'install/views/scripts/_managerMenu.tpl' => 'Added main navigation',
        'install/views/scripts/import/*' => 'Added Ning Import Tool',
        'install/views/scripts/manage/*' => 'Moved main navigation to layout',
        'install/views/scripts/sdk/*' => 'Moved main navigation to layout',
        'install/views/scripts/settings/*' => 'Moved main navigation to layout',
      ),
      '4.0.1' => array(
        'install/.htaccess' => 'Added php_value for memory_limit and max_execution_time',
        'install/Bootstrap.php' => 'Added cache, logging, routes for SDK, (future) Ning importer, and (future) v3 migration',
        'install/index.php' => 'Modified handling of APPLICATION_ENV',
        'install/data/' => 'Data files for the SDK skeleton generator',
        'install/import/' => 'Importer classes for (future) Ning importer and (future) v3 migrator',
        'install/config/manifest.php' => 'Incremented version',
        'install/controllers/AuthController.php' => 'Fixed typo',
        'install/controllers/BackupController.php' => '(n/a)',
        'install/controllers/CompareController.php' => '(n/a)',
        'install/controllers/ImportController.php' => '(n/a)',
        'install/controllers/InstallController.php' => 'Optimized execution of sql queries',
        'install/controllers/MigrateController.php' => '(n/a)',
        'install/controllers/SdkController.php' => 'Added the Developer SDK',
        'install/controllers/UtilityController.php' => 'Added',
        'install/controllers/VfsController.php' => 'Added',
        'install/externals/*' => 'Added images and styles for the Developer SDK',
        'install/forms/Backup/*' => '(n/a)',
        'install/forms/Migrate/*' => '(n/a)',
        'install/forms/Sdk/*' => 'Added Developer SDK',
        'install/forms/VfsInfo.php' => 'Added return url parameter',
        'install/layouts/scripts/default.tpl' => 'Added Developer SDK',
        'install/views/helpers/PackageSelect.php' => 'Fixed bug on deleting mis-named packages',
        'install/views/scripts/backup/*' => '(n/a)',
        'install/views/scripts/compare/*' => '(n/a)',
        'install/views/scripts/install/license.tpl' => 'Incorrect link to client area',
        'install/views/scripts/install/sanity.tpl' => 'Added force',
        'install/views/scripts/migrate/*' => '(n/a)',
        'install/views/scripts/sdk/*' => 'Added Developer SDK',
        'install/views/scripts/utility/*' => '(n/a)',
        'install/views/scripts/vfs/*' => '(n/a)',
        'install/views/scripts/_rawError.tpl' => 'Error page for bootstrap errors',

        '/temporary/package/compare/' => '(n/a)',
        '/temporary/package/sdk/' => 'Added Developer SDK',
      ),
      '4.0.2' => array(
        'install/layouts/scripts/default.tpl' => 'Fixed SDK link',
      ),
    ),
    'dependencies' => array(
      array(
        'type' => 'library',
        'name' => 'engine',
      //'excludeExcept' => true,
        'required' => true,
        'minVersion' => '4.1.0',
      ),
    ),
    'actions' => array(
      'install',
      'upgrade',
      'refresh',
    ),
    'directories' => array(
      'install',
    ),
    'permissions' => array(
      array(
        'path' => 'install/config',
        'mode' => 0777,
        'inclusive' => true,
        'recursive' => true,
      ),
      array(
        'path' => 'temporary/package',
        'mode' => 0777,
        'inclusive' => true,
        'recursive' => true,
      ),
    ),
    'tests' => array(
      /*
      array(
        'type' => 'FilePermission',
        'name' => 'Install Permissions',
        'path' => 'install/config/auth.php',
        'value' => 7,
        'recursive' => false,
        'messages' => array(
          'insufficientPermissions' => 'Please log in over FTP and set CHMOD 0777 (recursive) on the install/config/ directory',
        ),
      ),
      */
    ),
  ),
); ?>
