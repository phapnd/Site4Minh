<?php $objlang = $this->registry->get('language');  $ourl = $this->registry->get('url');?>
<div class="product-block item-default" itemtype="http://schema.org/Product" itemscope>

	<?php if ($product['thumb']) {    ?>
		 <div class="image">
		 	<!-- text sale-->
			<?php if( $product['special'] ) {   ?>
	    	<span class="product-label-special product-label"><span class="special"><?php echo $objlang->get( 'Sale' ); ?></span></span>
	    	<?php } ?>

			<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive" /></a>

			<!-- zoom image-->
			<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
				<a href="<?php echo $zimage;?>" class="info-view product-zoom" title="<?php echo $product['name']; ?>"><i class="fa fa-search-plus"></i></a>
			<?php } ?>
			<!-- quickview-->
			<?php if ( isset($quickview) && $quickview ) { ?>
				<a class="pav-colorbox btn btn-theme-default iframe-link cboxElement" href="<?php echo $ourl->link("themecontrol/product",'product_id='.$product['product_id'] );?>" title="<?php echo $objlang->get('quick_view'); ?>">
					<i class='fa fa-eye'></i><span><?php echo $objlang->get('quick_view'); ?></span>
				</a>
			<?php } ?>
		</div>
	<?php } ?>
	
	<div class="product-meta">
		<div class="left">
			<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>

			<?php if ($product['price']) { ?>
			<div class="price" itemtype="http://schema.org/Offer" itemscope itemprop="offers">
				<?php if (!$product['special']) {  ?>
					<span class="special-price"><?php echo $product['price']; ?></span>
					<?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?> 
					<meta content="<?php echo $p[0]; ?>" itemprop="price">
					<?php } ?>
				<?php } else { ?>
					<span class="price-new"><?php echo $product['special']; ?></span>
					<span class="price-old"><?php echo $product['price']; ?></span> 
					<?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?> 
					<meta content="<?php echo $p[0]; ?>" itemprop="price">
					<?php } ?>
				<?php } ?>
				<meta content="<?php // echo $this->currency->getCode(); ?>" itemprop="priceCurrency">
			</div>
			<?php } ?>
		</div>

		<div class="right">
			<?php if ( isset($product['rating']) ) { ?>
	          <div class="rating">
	            <?php for ($is = 1; $is <= 5; $is++) { ?>
	            <?php if ($product['rating'] < $is) { ?>
	            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
	            <?php } else { ?>
	            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i>
	            </span>
	            <?php } ?>
	            <?php } ?>
	          </div>
	         <?php } ?>

	         <?php if( isset($product['description']) ){ ?> 
				<div class="description" itemprop="description"><?php echo utf8_substr( strip_tags($product['description']),0,220);?>...</div>
			<?php } ?>

			<div class="action"> 
			    <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
					<div class="cart">
						<button onclick="cart.addcart('<?php echo $product['product_id']; ?>');" class="btn btn-shopping-cart" value="<?php echo $button_cart; ?>"> 
							<i class="fa fa-shopping-cart"></i>
							<span><?php echo $button_cart; ?></span>
						</button>		
					</div>
				<?php } ?>

			    <div class="button-group">
				  	<div class="wishlist">
						<a onclick="wishlist.addwishlist('<?php echo $product['product_id']; ?>');" title="<?php echo $objlang->get('button_wishlist'); ?>" class="fa fa-heart product-icon">
							<span><?php echo $objlang->get('button_wishlist'); ?></span>
						</a>	
					</div>
					
				  	<div class="compare">			
						<a onclick="compare.addcompare('<?php echo $product['product_id']; ?>');" title="<?php echo $objlang->get('button_compare'); ?>" class="fa fa-refresh product-icon">
							<span><?php echo $objlang->get('button_compare'); ?></span>
						</a>	
					</div>
				</div>
			</div>
		</div>

	</div>

</div>