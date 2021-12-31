import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends GetView<FirebaseAuthController> {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return HomeView();
      } else {
        return AuthView();
      }
    });
  }
}