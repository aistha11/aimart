
import 'package:aimart/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> pages = [
    HomeView(),
    HomeView(),
    CartView(),
    OrderView(),
  ];
  void onPageChange(int index) {
    currentIndex.value = index;
  }
}
