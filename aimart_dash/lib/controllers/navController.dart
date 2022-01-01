import 'package:aimart_dash/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> pages = [
    ProductsView(),
    CategoriesView(),
    OrdersView(),
    ContactsView(),
    ChatView(),
  ];
  void onPageChange(int index) {
    currentIndex.value = index;
  }
}