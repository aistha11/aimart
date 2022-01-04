import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  
  Rx<TextEditingController> searchController = Rx<TextEditingController>(TextEditingController(text: ""));
  
  var query = "".obs;

  final Rx<List<Product>> _productList = Rx<List<Product>>([]);

  final Rx<List<Product>> _featuredProducts = Rx<List<Product>>([]);

  List<Product> get featuredProducts => _featuredProducts.value;

  final Rx<List<Product>> _latestProducts = Rx<List<Product>>([]);

  List<Product> get latestProducts => _latestProducts.value;

  List<Product> get productList => _productList.value.where((e){
    return e.name.toLowerCase().contains(query.value.toLowerCase());
  }).toList();

  @override
  void onInit() {
    _productList.bindStream(FirebaseService.getProducts());
    _featuredProducts.bindStream(FirebaseService.getFeaturedProducts(10));
    _latestProducts.bindStream(FirebaseService.getLatestProducts(10));
    super.onInit();
  }

  void setQuery(String val){
    query.value = val;
    update();
  }

  Product getProductById(String id) {
    return _productList.value.where((e) {
      return e.id == id;
    }).toList()[0];
  }

  List<Product> getProductByCatId(String catId) {
    return _productList.value.where((e) {
      return e.categoryId == catId;
    }).toList();
  }

}