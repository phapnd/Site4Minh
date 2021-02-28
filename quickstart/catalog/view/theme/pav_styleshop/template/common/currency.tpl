<?php if (count($currencies) > 1) { ?>
<div class="currency-wrapper pull-right">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="currency">
    <div class="btn-group">
      <button type="button" class="form-control" data-toggle="dropdown">
        <?php foreach ($currencies as $currency) { ?>
          <?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
          <?php echo $currency['symbol_left']; ?>
          <?php echo $currency['title']; ?>
          <?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
          <?php echo $currency['symbol_right']; ?>
          <?php echo $currency['title']; ?>
          <?php } ?>
        <?php } ?>
        <span class="fa fa-caret-down"></span>
      </button> 
      <div class="dropdown-menu dropdown">
        <div class="box-currency">
          <?php foreach ($currencies as $currency) { ?>
          <?php if ($currency['symbol_left']) { ?>
          <a href="javascript:void(0);" class="currency-select list-item" data-name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?> <?php echo $currency['title']; ?></a>
          <?php } else { ?>
          <a href="javascript:void(0);" class="currency-select list-item" data-name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_right']; ?> <?php echo $currency['title']; ?></a>
          <?php } ?>
          <?php } ?>

          <input type="hidden" name="code" value="" />
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        </div>
      </div>
    </div>      
  </form>
</div>
<?php } ?>
