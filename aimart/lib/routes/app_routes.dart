part of 'app_pages.dart';

abstract class Routes {
  static const WRAPPER = '/';
  static const CATEGORIES = "/category";
  static const SINGLECATEGORY = '/category/:catId';  
  static const PRODUCTS = '/product';  
  static const SINGLEPRODUCT = '/product/:id';
  static const FEATUREDPRODUCTS = '/product/featured';
  static const LATESTPRODUCTS = '/product/latest';
  static const CHECKOUT = '/checkout';
  static const CONTACTUS = '/contact';
  
}
