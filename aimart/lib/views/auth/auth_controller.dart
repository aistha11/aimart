import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Mode? Sign In  or Sign Up
  RxBool isSignIn = true.obs;

  // Sign In
  var signInFormKey = GlobalKey<FormState>().obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  var showPassword = false.obs;

  Future<void> signIn(void Function(String, String)? handler) async {
    if (signInFormKey.value.currentState!.validate()) {
      handler!(email.value.text, password.value.text);
      clear();
    }
  }

  // SignUp
  var signUpFormKey = GlobalKey<FormState>().obs;
  final TextEditingController email1 = TextEditingController();
  final TextEditingController password1 = TextEditingController();
  var showPassword1 = false.obs;
  final TextEditingController confirmPassword = TextEditingController();
  var showConfirmPassword = false.obs;
  final TextEditingController name = TextEditingController();

  // forgot password email editing controller
  final TextEditingController resndEmail = TextEditingController();

  // toggle modes
  toggleModes() {
    isSignIn.value = !isSignIn.value;
    update();
  }

  // toggle signIn password visibility
  toggleShowPassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  // toggle signUp password visibility
  toggleShowPassword1() {
    showPassword1.value = !showPassword1.value;
    update();
  }

  // toggle signIn password visibility
  toggleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
    update();
  }

  Future<void> signUp(void Function(String, String, String)? handler) async {
    if (signUpFormKey.value.currentState!.validate()) {
      if (password1.value.text != confirmPassword.value.text) {
        Get.snackbar(
            "Error!!", "Your password and confirm password doesn't match");
        return;
      }
      handler!(name.value.text, email1.value.text, password1.value.text);
      clear();
    }
  }

  // Forgot Password
  final TextEditingController forgotEmail = TextEditingController();

  clear() {
    email.text = "";
    password.text = "";
    email1.text = "";
    password1.text = "";
    confirmPassword.text = "";
    name.text = "";
  }

  
}
