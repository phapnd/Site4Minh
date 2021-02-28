<?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
<?php echo $header; ?>
<?php require( PAVO_THEME_DIR."/template/common/breadcrumb.tpl" );  ?>

<div class="container">
  <div class="row">
    <?php if( $SPAN[0] ): ?>
			<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</aside>	
		<?php endif; ?> 

    <?php $class_3cols = (!empty($column_left) && !empty($column_left))?'three-columns':''; ?>
    <section class="col-md-<?php echo $SPAN[1];?> <?php echo $class_3cols;?> "> 
      <div id="content">
        <?php echo $content_top; ?>
        <div class="search">
          <h1><?php echo $heading_title; ?></h1>
          <label for="input-search" class="control-label"><?php echo $entry_search; ?></label>
          <div class="content">
            <div class="wrapper">
              <div class="row">
                <!-- ===================== -->
                <div class="col-md-4">
                  <div class="form-horizontal">
                    <div class="form-group">
                      <label for="search" class="col-md-3 hidden-xs hidden-sm"><?php echo $entry_search; ?></label>
                      <div class="col-md-9">
                        <?php if ($search) { ?>
                        <input type="text" name="search" value="<?php echo $search; ?>" class="input-text form-control" />
                        <?php } else { ?>
                        <input type="text" name="search" value="<?php echo $search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;"  class="input-text form-control" />
                        <?php } ?>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- ===================== -->
                <div class="col-md-4">
                  <select name="category_id" class="form-control">
                    <option value="0"><?php echo $text_category; ?></option>
                    <?php foreach ($categories as $category_1) { ?>
                    <?php if ($category_1['category_id'] == $category_id) { ?>
                    <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                    <?php } ?>
                    <?php foreach ($category_1['children'] as $category_2) { ?>
                    <?php if ($category_2['category_id'] == $category_id) { ?>
                    <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                    <?php } ?>
                    <?php foreach ($category_2['children'] as $category_3) { ?>
                    <?php if ($category_3['category_id'] == $category_id) { ?>
                    <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
                <!-- ===================== -->
                <div class="col-md-4">
                  <label for="sub_category" class="checkbox">
                    <?php if ($sub_category) { ?>
                    <input type="checkbox" name="sub_category" value="1" id="sub_category" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="sub_category" value="1" id="sub_category" />
                    <?php } ?>
                    <?php echo $text_sub_category; ?>
                  </label>
                </div>
              </div> 
              <!-- ========= End Row ============ -->
              <p>
                <label for="description" class="checkbox">
                  <?php if ($description) { ?>
                  <input type="checkbox" name="description" value="1" id="description" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="description" value="1" id="description" />
                  <?php } ?>
                  <?php echo $entry_description; ?></label>
              </p>
            </div>
            <!-- ===================== -->
          </div>
          
          <div class="buttons">
            <div class="left">
              <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="button btn btn-theme-default" />
            </div>
          </div>

          <h2><?php echo $text_search; ?></h2>

          <?php if ($products) { ?>
           <?php require( ThemeControlHelper::getLayoutPath( 'common/product_collection.tpl' ) );  ?> 
          <?php } else { ?>
          <div class="content"><div class="wrapper"><?php echo $text_empty; ?></div></div>
          <?php } ?>

        <?php echo $content_bottom; ?>
        </div>
      </div>
      </div>
      <!-- ==========  End Content =========== -->

    </section>
    <?php if( $SPAN[2] ): ?>
    	<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
    		<?php echo $column_right; ?>
    	</aside>
    <?php endif; ?>
  </div>
</div>
<?php echo $footer; ?> 


<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
  url = 'index.php?route=product/search';
  
  var search = $('#content input[name=\'search\']').prop('value');
  
  if (search) {
    url += '&search=' + encodeURIComponent(search);
  }

  var category_id = $('#content select[name=\'category_id\']').prop('value');
  
  if (category_id > 0) {
    url += '&category_id=' + encodeURIComponent(category_id);
  }
  
  var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');
  
  if (sub_category) {
    url += '&sub_category=true';
  }
    
  var filter_description = $('#content input[name=\'description\']:checked').prop('value');
  
  if (filter_description) {
    url += '&description=true';
  }

  location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
  if (e.keyCode == 13) {
    $('#button-search').trigger('click');
  }
});

$('select[name=\'category_id\']').on('change', function() {
  if (this.value == '0') {
    $('input[name=\'sub_category\']').prop('disabled', true);
  } else {
    $('input[name=\'sub_category\']').prop('disabled', false);
  }
});

$('select[name=\'category_id\']').trigger('change');
--></script>