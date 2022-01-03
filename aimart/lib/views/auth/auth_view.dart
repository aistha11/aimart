
import 'package:aimart/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'signIn_view.dart';
import 'signUp_view.dart';

class AuthView extends GetView<FirebaseAuthController> {
  final AuthController authController = Get.put(AuthController());

  AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.isSignIn.value
          ? SignInView(
              handleSignIn: (email, password) async {
                await controller.signIn(email, password);
              },
            )
          : SignupView(
              handleSignUp: (name, email, password) async {
                await controller.signUp(name, email, password);
              },
            ),
    );
  }
}
