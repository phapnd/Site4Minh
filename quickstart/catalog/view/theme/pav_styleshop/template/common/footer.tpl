<?php 
  /*
  * @package Framework for Opencart 2.0
  * @version 2.0
  * @author http://www.pavothemes.com
  * @copyright Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
  * @license   GNU General Public License version 2
  */
  require_once(DIR_SYSTEM . 'pavothemes/loader.php');
  $config = $this->registry->get('config'); 
  $helper = ThemeControlHelper::getInstance( $this->registry, $config->get('config_template') );
  $layoutID = 1 ;
  $helper->loadFooterModules();
?>
 
<!-- 
  $ospans: allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
 -->

<?php if( !($helper->getConfig('enable_pagebuilder') && $helper->isHomepage())  ){ ?>

<?php
  $blockid = 'mass_bottom';
  $blockcls = '';
  $ospans = array();
  require( ThemeControlHelper::getLayoutPath( 'common/block-cols.tpl' ) );
?>

<?php } ?>
 
<footer id="footer">

  <?php
    $blockid = 'footer_top';
    $blockcls = '';
    $ospans = array(1=>4,2=>2,3=>2,4=>2,5=>2);
    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );
  ?>
  <?php if( count($modules) <=0 ) { ?>
  <div class="footer-top">
    <div class="container">
        <div class="custom">
          <div class="row">
            <?php if ($informations) { ?>
            <div class="col-md-3 col-sm-6 col-xs-12 box">
              <div class="box-heading"><span><?php echo $text_information; ?></span></div>
              <ul class="list-unstyled">
                <?php foreach ($informations as $information) { ?>
                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php } ?>
              </ul>
            </div>
            <?php } ?>

            <div class="col-md-3 col-sm-6 col-xs-12 box">
              <div class="box-heading"><span><?php echo $text_service; ?></span></div>
              <ul class="list-unstyled">
                <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              </ul>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12 box">
              <div class="box-heading"><span><?php echo $text_extra; ?></span></div>
              <ul class="list-unstyled">
                <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
              </ul>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12 box">
              <div class="box-heading"><span><?php echo $text_account; ?></span></div>
              <ul class="list-unstyled">
                <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  <?php } ?> 

  <?php
    $blockid = 'footer_center';
    $blockcls = '';
    $ospans = array(1=>3,2=>6,3=>3);
    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );
  ?>
  <div class="footer-center">
    <div class="container">
      <div class="row">
        <?php if( $content=$helper->getLangConfig('widget_contact_us') ) {?>
          <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <?php echo $content; ?>
          </div>
        <?php } ?>

        <?php if( $content=$helper->getLangConfig('widget_banner_ft') ) {?>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
          <?php echo $content; ?>
        </div>
        <?php } ?>

        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
          <?php 
            $module = $helper->renderModule('pavnewsletter'); 
            if (count($module) && !empty($module)) { ?>
              <?php echo $module; ?>
          <?php } ?>
        </div>
      </div>
    </div>      
  </div>

  <?php
    $blockid = 'footer_bottom';
    $blockcls = '';
    $ospans = array();
    require( ThemeControlHelper::getLayoutPath( 'common/block-footcols.tpl' ) );
  ?>

  <div id="powered">
    <div class="container">
      <div id="top"><a class="scrollup" href="#"><i class="fa fa-angle-up"></i>Top</a></div>
      <div class="copyright pull-left">
      <?php if( $helper->getConfig('enable_custom_copyright', 0) ) { ?>
        <?php echo $helper->getConfig('copyright'); ?>
      <?php } else { ?>
        <?php echo $powered; ?>. 
      <?php } ?>
      <!--Designed by <a href="http://www.pavothemes.com" title="pavothemes - opencart themes clubs">SkypePavo</a>-->
	      	<p>Công Ty Cổ Phần Đầu Tư Thương Mại SEN NÚI.</br>
		Số 11, ngách 406/51 Âu Cơ, Phường Nhật Tân, Quận Tây Hồ, Thành phố Hà Nội</br>
		Email: duocthaosennui@gmail.com - Điện thoại: 098 129 1282</br>
		Số ĐKKD 0109295168 do Sở Kế hoạch và Đầu tư Tp.Hà Nội cấp ngày 05/08/2011</p>
	</a>
      </div>  

      <?php if( $content=$helper->getLangConfig('widget_paypal_data') ) {?>
        <div class="paypal pull-right">
          <?php echo $content; ?>
        </div>
      <?php } ?>
    </div>
  </div>

</footer>

<?php if( $helper->getConfig('enable_paneltool',0) ){  ?>
  <?php  echo $helper->renderAddon( 'panel' );?>
<?php } ?>

<script type="text/javascript">
  $(document).ready(function() {
    $("li:first-child").addClass('first');
    $("li:last-child").addClass('last');  
    $(".box-product .row:last-child").addClass('last');       
    $("#image-additional a:last-child").addClass('last');
    $(".product-items:last-child").addClass('last');
    $('.product-cols:last-child').addClass('last'); 
    $(".product-cols:first-child").addClass('first');   
    $(".product-grid div[class^='col-']:last-child").addClass('last');
    $(".product-grid .row:last-child").addClass('last');
    $(function(){
      $('#header .links li').last().addClass('last');
      $('.breadcrumb a').last().addClass('last');
      $('.cart tr').eq(0).addClass('first');                                                    
    });               
  });
</script>

</div>
 </section>
</body></html>
