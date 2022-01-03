import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();


  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  void onInit() {
   
    super.onInit();
  }
}
