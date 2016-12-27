<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: search.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php
  // Parse query and remove page
  if( !empty($this->query) && ( is_string($this->query) || is_array($this->query)) ) {
    $query = $this->query;
    if( is_string($query) ) $query = parse_str(trim($query, '?'));
    unset($query['page']);
    $p = Zend_Controller_Front::getInstance()->getRequest()->getParams();
    unset($p['controller']);
    unset($p['action']);
    if (count($p) > 0) {
        $this->pageAsQuery = true;    
    }
    $query = array_merge($query, $p);
    $query = http_build_query($query);
    if( $query ) $query = '?' . $query;
  } else {
    $query = '';
  }
  // Add params
  $params = ( !empty($this->params) && is_array($this->params) ? $this->params : array() );
  unset($params['page']);
  // $p = Zend_Controller_Front::getInstance()->getRequest()->getParams();
  // unset($p['controller']);
  // unset($p['action']);
  // $params = array_merge($params, $p);
?>


<?php if( $this->pageCount > 1 ): ?>
  <div class="pages">
    <ul class="paginationControl">
      <?php if( isset($this->previous) ): ?>
      <li>
          <?php echo $this->htmlLink(array_merge($params, array(
            'reset' => false,
            'page' => ( $this->pageAsQuery ? null : $this->first ),
            'QUERY' => $query . ( $this->pageAsQuery ? '&page=' . $this->first : '' ),
          )), $this->translate('&#171;')) ?>
      </li>
        <li>
          <?php echo $this->htmlLink(array_merge($params, array(
            'reset' => false,
            'page' => ( $this->pageAsQuery ? null : $this->previous ),
            'QUERY' => $query . ( $this->pageAsQuery ? '&page=' . $this->previous : '' ),
          )), $this->translate('&#8249;')) ?>
        </li>
      <?php endif; ?>
      <?php foreach ($this->pagesInRange as $page): ?>
        <?php if ($page != $this->current): ?>
          <li>
            <?php echo $this->htmlLink(array_merge($params, array(
              'reset' => false,
              'page' => ( $this->pageAsQuery ? null : $page ),
              'QUERY' => $query . ( $this->pageAsQuery ? '&page=' . $page : '' ),
            )), $page) ?>
          </li>
        <?php else: ?>
          <li class="selected">
            <a href='<?php echo $this->escape($this->url()) ?>'><?php echo $page; ?></a>
          </li>
        <?php endif; ?>
      <?php endforeach; ?>
      <?php if (isset($this->next)): ?>
        <li>
          <?php echo $this->htmlLink(array_merge($params, array(
            'reset' => false,
            'page' => ( $this->pageAsQuery ? null : $this->next ),
            'QUERY' => $query . ( $this->pageAsQuery ? '&page=' . $this->next : '' ),
          )), $this->translate('&#8250;')) ?>
        </li>
        <li>
          <?php echo $this->htmlLink(array_merge($params, array(
            'reset' => false,
            'page' => ( $this->pageAsQuery ? null : $this->last ),
            'QUERY' => $query . ( $this->pageAsQuery ? '&page=' . $this->last : '' ),
          )), $this->translate('&#187;')) ?>
        </li>
      <?php endif; ?>
    </ul>
  </div>
<?php endif; ?>

