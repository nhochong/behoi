<ul class="experience-statistic">
   <li class="experience-statistic-item">
      <i class="fa fa-files-o"></i>
      
      <div>
         <div class="experience_statistic_info">
            <?php echo $this->count_experiences; ?>
         </div>
         <div class="experience_statistic_field">
            <?php echo $this->translate(array('experience', 'Experiences', $this->count_experiences), $this->count_experiences);?>
         </div>
      </div>
   </li>

   <li class="experience-statistic-item">
      <i class="fa fa-users"></i>
   
      <div>
         <div class="experience_statistic_info">
            <?php echo $this->count_bloggers ?>
         </div>

         <div class="experience_statistic_field">
            <?php echo $this->translate(array('Active Blogger', 'Active Bloggers', $this->count_bloggers), $this->count_bloggers);?>
         </div>
      </div>
   </li>
</ul>