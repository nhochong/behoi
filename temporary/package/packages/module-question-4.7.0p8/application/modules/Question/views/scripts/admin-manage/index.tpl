<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<p>
  <?php echo $this->translate('This page lists all of the questions your users have posted. You can use this page to monitor these questions and delete offensive material if necessary. Entering criteria into the filter fields will help you find specific questions. Leaving the filter fields blank will show all the questions on your social network.'); ?>
</p>
<div class="search">
    <?php echo $this->form->render($this) ?>
</div>
<br />
    <?php if( count($this->paginator) ): ?>

<table class='admin_table' style="float:left;">
<thead>

  <tr>
    <th class='admin_table_short'>ID</th>
    <th>Title</th>
    <th>Owner</th>
    <th>Views</th>
    <th>Answers</th>
    <th>Date</th>
    <th>Status</th>
    <th>Options</th>
  </tr>

</thead>
<tbody>
        <?php foreach ($this->paginator as $item): ?>

          <tr>           
            <td><?php echo $item->question_id ?></td>
            <td><?php echo $this->htmlLink($item->getHref(), $item->getTitle()); ?></td>
            <td><?php echo $this->user($item->user_id)->username ?></td>
            <td><?php echo $item->question_views ?></td>
            <td><?php echo $item->count_answers ?></td>
            <td><?php echo $item->creation_date ?></td>
            <td><?php echo $item->status ?></td>
            <td>
                  <?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'question', 'controller' => 'manage', 'action' => 'delete', 'id' => $item->question_id), $this->translate ('delete'), array('class' => 'smoothbox')) ?>
                  |
                  <?php if ($item->status == 'open') echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'question', 'controller' => 'manage', 'action' => 'cancel', 'id' => $item->question_id), $this->translate ('cancel'), array('class' => 'smoothbox')) ?>
            </td>
          </tr>

            <?php endforeach; ?>
</tbody>
</table>
<br/>

<div class='browse_nextlast'>
  <?php echo $this->paginationControl($this->paginator, null, 'pagination/questionpagination.tpl'); ?>
</div>

<?php else:?>
  <?php echo $this->translate ("There are no question entries by your members yet.") ?>
<?php endif; ?>
