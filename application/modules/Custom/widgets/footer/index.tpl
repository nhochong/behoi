<style type="text/css">
   .layout_custom_footer .footerLanding {
      padding-bottom: 40px;
   }
   .layout_custom_footer .footerLanding .main ul{
      float: left;
      padding: 0px;
      margin: 0px;
   }
   .layout_custom_footer span a img {
      max-width: 35px;
      height: auto;
   }
   .layout_custom_footer .menu-footer a{
      font-family: 'Futura_Medium';
      font-size: 14px;
      color: #595959;
      font-weight: 600;
      line-height: 30px;
   }
   .layout_custom_footer ul.xfooterLanding4 li{
      font-family: 'Futura_Medium';
      font-size: 14px;
      color: #787878;
      font-weight: 600;
      line-height: 30px;
   }
</style>
<div class= "footerLanding container">
   <div class="row">
      <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
         <div class="row">
            <ul class= " menu-footer col-md-4 col-sm-4 col-xs-4">
               <li><a href="#"><?php echo $this->translate('HOME');?></a></li>
               <li><a href="help/contact"><?php echo $this->translate('CONTACT US');?></a></li>
               <li><a href="#"><?php echo $this->translate('FAQ');?></a></li>
               <li><a href="#"><?php echo $this->translate('HELP');?></a></li>
            </ul>
            <ul class= "menu-footer col-md-4 col-sm-4 col-xs-4">
               <li><a href="#"><?php echo $this->translate('ABOUT');?></a></li>
               <li><a href="#"><?php echo $this->translate('NEW/INFO');?></a></li>
               <li><a href="#"><?php echo $this->translate('FEEDBACK');?></a></li>
               <li><a href="#"><?php echo $this->translate('BLOG');?></a></li>
            </ul>
            <ul class= " menu-footer col-md-4 col-sm-4 col-xs-4">
               <li><a href="<?php echo $this->url(array(), 'user_login', true); ?>"><?php echo $this->translate('SIGN IN');?></a></li>
               <li><a href="<?php echo $this->url(array(), 'user_signup', true); ?>"><?php echo $this->translate('SIGN UP');?></a></li>
               <li><a href="#"><?php echo $this->translate('REFER A FRIEND');?></a></li>
            </ul>
         </div>
      </div>
      <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
         <div class="row">
            <ul class= "xfooterLanding4 col-md-6 col-sm-6 col-xs-6">
               <li><?php echo $this->translate('UPDATED JANUARY 2017');?></li>
               <li><?php echo $this->translate('COPYRIGHT: &copy; FACELESS. ALL RIGHTS');?></li>
               <li><?php echo $this->translate('RESERVED. MARYLAND, USA');?></li>
            </ul>
            <div class= "footerLanding5 col-md-6 col-sm-6 col-xs-6">
               <span>
                  <a href="#">
                     <img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\face.png" alt="Facebook"/>
                  </a>
               </span>
               <span>
                  <a href="#">
                     <img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\google.png" alt="Google"/></a>
               </span>
               <span><a href="#"><img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\twitter.png" alt="Twitter"/></a></span>
               <span><a href="#"><img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\camera.png" alt="Camera"/></a></span>
               <span><a href="#"><img src="<?php echo $this->baseUrl(); ?>\application\themes\modern\images\print.png" alt="Printerests"/></a></span>
            </div>
         </div>
      </div>
   </div>
</div>