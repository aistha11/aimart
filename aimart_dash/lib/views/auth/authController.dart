import 'package:aimart_dash/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // For sign in
  var signInFormKey = GlobalKey<FormState>().obs;
  var email1 = TextEditingController(text: "aimart11@gmail.com").obs;
  var password1 = TextEditingController().obs; // @Aimart11

  Future<void> signIn() async {
    if (signInFormKey.value.currentState!.validate()) {
      await Get.find<FirebaseAuthController>()
          .signIn(email1.value.text, password1.value.text);
      clear();
    }
  }

  // Clear the fields
  clear() {
    password1.value.text = "";
  }
}
