
import 'package:aimart/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> pages = [
    HomeView(),
    SearchView(),
    CartView(),
    OrderView(),
    ProfileView(),
  ];
  void onPageChange(int index) {
    currentIndex.value = index;
  }
}
