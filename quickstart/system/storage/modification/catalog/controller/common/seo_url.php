<?php
class ControllerCommonSeoUrl extends Controller {
	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}

		// Decode URL
		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);

			// remove any empty arrays from trailing
			if (utf8_strlen(end($parts)) == 0) {
				array_pop($parts);
			}

			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");

				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);

					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}

					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}

					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}

					if ($query->row['query'] && $url[0] != 'information_id' && $url[0] != 'manufacturer_id' && $url[0] != 'category_id' && $url[0] != 'product_id') {
						$this->request->get['route'] = $query->row['query'];
					}
				} else {
					$this->request->get['route'] = 'error/not_found';

					break;
				}
			}

			
					if (!isset($this->request->get['route']) || $this->request->get['route'] == 'error/not_found') {
				
				if (isset($this->request->get['product_id'])) {
					$this->request->get['route'] = 'product/product';
				
					} elseif ($this->request->get['_route_'] ==  'wishlist') {
					$this->request->get['route'] =  'account/wishlist';
					} elseif ($this->request->get['_route_'] ==  'contact') {
					$this->request->get['route'] =  'information/contact';
					} elseif ($this->request->get['_route_'] ==  'account') {
					$this->request->get['route'] =  'account/account';
					} elseif ($this->request->get['_route_'] ==  'sitemap') {
					$this->request->get['route'] =  'information/sitemap';
					} elseif ($this->request->get['_route_'] ==  'tellafriend') {
					$this->request->get['route'] =  'information/tellafriend';
					} elseif ($this->request->get['_route_'] ==  'brands') {
					$this->request->get['route'] =  'product/manufacturer';
					} elseif ($this->request->get['_route_'] ==  'affiliates') {
					$this->request->get['route'] =  'affiliate/account';
					} elseif ($this->request->get['_route_'] ==  'specials') {
					$this->request->get['route'] =  'product/special';
					} elseif ($this->request->get['_route_'] ==  'latest') {
					$this->request->get['route'] =  'product/latest';
					} elseif ($this->request->get['_route_'] ==  'blogs') {
					$this->request->get['route'] =  'pavblog/blogs';
					} elseif ($this->request->get['_route_'] ==  'login') {
					$this->request->get['route'] =  'account/login';
					} elseif ($this->request->get['_route_'] ==  'logout') {
					$this->request->get['route'] =  'account/logout';
					} elseif ($this->request->get['_route_'] ==  'register') {
					$this->request->get['route'] =  'account/register';
					} elseif ($this->request->get['_route_'] ==  'cart') {
					$this->request->get['route'] =  'checkout/cart';
					} elseif ($this->request->get['_route_'] ==  'checkout') {
					$this->request->get['route'] =  'checkout/checkout';
					} elseif ($this->request->get['_route_'] ==  'returns') {
					$this->request->get['route'] =  'account/return/add';
					} elseif ($this->request->get['_route_'] ==  'vouchers') {
					$this->request->get['route'] =  'account/voucher';
					} elseif ($this->request->get['_route_'] ==  'newsletter') {
					$this->request->get['route'] =  'account/newsletter';
					} elseif ($this->request->get['_route_'] ==  'order-history') {
					$this->request->get['route'] =  'account/order';
					} elseif ($this->request->get['_route_'] ==  'forgotten-password') {
					$this->request->get['route'] =  'account/forgotten';
					} elseif ($this->request->get['_route_'] ==  'your-downloads') {
					$this->request->get['route'] =  'account/download';
					} elseif ($this->request->get['_route_'] ==  'transactions') {
					$this->request->get['route'] =  'account/transaction';
					} elseif ($this->request->get['_route_'] ==  'returned') {
					$this->request->get['route'] =  'account/return';
					} elseif ($this->request->get['_route_'] ==  'your-reward') {
					$this->request->get['route'] =  'account/reward';
					} elseif ($this->request->get['_route_'] ==  'address-book') {
					$this->request->get['route'] =  'account/address';
					} elseif ($this->request->get['_route_'] ==  'password') {
					$this->request->get['route'] =  'account/edit';
					} elseif ($this->request->get['_route_'] ==  'account-edit') {
					$this->request->get['route'] =  'account/password';
					} elseif (isset($this->request->get['path'])) {
				
					$this->request->get['route'] = 'product/category';
				} elseif (isset($this->request->get['manufacturer_id'])) {
					$this->request->get['route'] = 'product/manufacturer/info';
				} elseif (isset($this->request->get['information_id'])) {
					$this->request->get['route'] = 'information/information';
				}
			}

			if (isset($this->request->get['route'])) {
				return new Action($this->request->get['route']);
			}
		}
	}

	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));

		$url = '';

		$data = array();

		parse_str($url_info['query'], $data);

		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

					if ($query->num_rows && $query->row['keyword']) {
						
					$url = '/' . $query->row['keyword'];
				

						unset($data[$key]);
					}
				
					} elseif (isset($data['route']) && $data['route'] ==   'common/home') {
					$url .=  '/';
					} elseif (isset($data['route']) && $data['route'] ==   'account/wishlist' && $key != 'remove') {
					$url .=  '/wishlist';
					} elseif (isset($data['route']) && $data['route'] ==   'information/contact') {
					$url .=  '/contact';
					} elseif (isset($data['route']) && $data['route'] ==   'account/account') {
					$url .=  '/account';
					} elseif (isset($data['route']) && $data['route'] ==   'information/sitemap') {
					$url .=  '/sitemap';
					} elseif (isset($data['route']) && $data['route'] ==   'information/tellafriend') {
					$url .=  '/tellafriend';
					} elseif (isset($data['route']) && $data['route'] ==   'product/manufacturer') {
					$url .=  '/brands';
					} elseif (isset($data['route']) && $data['route'] ==   'affiliate/account') {
					$url .=  '/affiliates';
					} elseif (isset($data['route']) && $data['route'] ==   'product/special' && $key != 'page' && $key != 'sort' && $key != 'limit' && $key != 'order') {
					$url .=  '/specials';
					} elseif (isset($data['route']) && $data['route'] ==   'product/latest' && $key != 'page' && $key != 'sort' && $key != 'limit' && $key != 'order') {
					$url .=  '/latest';
					} elseif (isset($data['route']) && $data['route'] ==   'pavblog/blogs' && $key != 'page' && $key != 'sort' && $key != 'limit' && $key != 'order') {
					$url .=  '/blogs';
					} elseif (isset($data['route']) && $data['route'] ==   'account/login') {
					$url .=  '/login';
					} elseif (isset($data['route']) && $data['route'] ==   'account/logout') {
					$url .=  '/logout';
					} elseif (isset($data['route']) && $data['route'] ==   'account/register') {
					$url .=  '/register';
					} elseif (isset($data['route']) && $data['route'] ==   'checkout/cart' && $key != 'remove') {
					$url .=  '/cart';
					} elseif (isset($data['route']) && $data['route'] ==   'checkout/checkout') {
					$url .=  '/checkout';
					} elseif (isset($data['route']) && $data['route'] ==   'account/return/add') {
					$url .=  '/returns';
					} elseif (isset($data['route']) && $data['route'] ==   'account/voucher') {
					$url .=  '/vouchers';
					} elseif (isset($data['route']) && $data['route'] ==   'account/newsletter') {
					$url .=  '/newsletter';
					} elseif (isset($data['route']) && $data['route'] ==   'account/order' && $key != 'order_id') {
					$url .=  '/order-history';
					} elseif (isset($data['route']) && $data['route'] ==   'account/forgotten') {
					$url .=  '/forgotten-password';
					} elseif (isset($data['route']) && $data['route'] ==   'account/download') {
					$url .=  '/your-downloads';
					} elseif (isset($data['route']) && $data['route'] ==   'account/transaction') {
					$url .=  '/transactions';
					} elseif (isset($data['route']) && $data['route'] ==   'account/return') {
					$url .=  '/returned';
					} elseif (isset($data['route']) && $data['route'] ==   'account/reward') {
					$url .=  '/your-reward';
					} elseif (isset($data['route']) && $data['route'] ==   'account/address') {
					$url .=  '/address-book';
					} elseif (isset($data['route']) && $data['route'] ==   'account/password') { 
					$url .=  '/password';
					} elseif (isset($data['route']) && $data['route'] ==   'account/edit') { 
					$url .=  '/account-edit';
					} elseif ($key == 'path') {
				
					$categories = explode('_', $value);

					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							
					$url = '/' . $query->row['keyword'];
				
						} else {
							$url = '';

							break;
						}
					}

					unset($data[$key]);
				}
			}
		}

		if ($url) {
			unset($data['route']);

			$query = '';

			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . rawurlencode((string)$key) . '=' . rawurlencode((string)$value);
				}

				if ($query) {
					$query = '?' . str_replace('&', '&amp;', trim($query, '&'));
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {
			return $link;
		}
	}
}

