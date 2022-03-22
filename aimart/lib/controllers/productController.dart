import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  
  Rx<TextEditingController> searchController = Rx<TextEditingController>(TextEditingController(text: ""));
  
  var query = "".obs;

  final Rx<List<Product>> _productList = Rx<List<Product>>([]);

  List<Product> get featuredProducts => _productList.value.where((e) => e.featured == true).toList();

  List<Product> get latestProducts => _productList.value.where((e) => (DateTime.now().difference(e.updateDate).inDays)<3).toList();

  List<Product> get productList => _productList.value.where((e){
    return e.name.toLowerCase().contains(query.value.toLowerCase());
  }).toList();

  @override
  void onInit() {
    _productList.bindStream(FirebaseService.getProducts());

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