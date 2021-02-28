<?php if (count($languages) > 1) { ?>
<?php 
  $tmp = array();
  foreach( $languages as $language ){
    if( $language['code'] == $code ){
      $tmp = $language;
      break;
    }
  } 
?>
<div class="language-wrapper pull-right">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <button type="button" class="form-control" data-toggle="dropdown">
      <?php if( !empty($tmp) ) { ?>
      <span>      
        <img src="image/flags/<?php echo $tmp['image']; ?>" alt="<?php echo $tmp['name']; ?>" title="<?php echo $tmp['name']; ?>" />
        <?php echo $language['name']; ?>        
      </span>   
      <?php } ?>
      <i class="fa fa-angle-down"></i>
    </button>

    <div class="dropdown-menu dropdown">
      <?php foreach ($languages as $language) { ?>
      <div>
        <a href="<?php echo $language['code']; ?>" class="list-item">
          <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> 
          <span class="item-name"><?php echo $language['name']; ?></span> 
        </a>
      </div>
      <?php } ?>
    </div>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
