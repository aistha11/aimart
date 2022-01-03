
import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/views/home/navScreen.dart';
import 'package:aimart/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Wrapper extends GetView<FirebaseAuthController> {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return NavView();
      } else {
        return AuthView(); 
      }
    });
  }
}
