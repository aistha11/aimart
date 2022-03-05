
import 'dart:developer';

import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'widgets/authPasswordFormField.dart';
import 'widgets/authButton.dart';
import 'widgets/authTextFormField.dart';

class SignupView extends StatelessWidget {
  final void Function(String name, String email, String password)? handleSignUp;

  const SignupView({Key? key, this.handleSignUp}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (controller) {
          return Form(
            key: controller.signUpFormKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100.0),
                AppHeader(heading: "Sign Up"),
                const SizedBox(height: 30.0),
                AuthTextFormField(
                  controller: controller.name,
                  onFieldSubmitted: (val) {
                    controller.name.text = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "*Name is required";
                    }
                    if (val.length < 4) {
                      return "Your name is too short";
                    }
                    return null;
                  },
                  labelText: "Full Name",
                ),
                AuthTextFormField(
                  controller: controller.email1,
                  onFieldSubmitted: (val) {
                    controller.email1.text = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "*Email is required";
                    }
                    if (!GetUtils.isEmail(val)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  labelText: "Email",
                ),
                AuthTPasswordFormField(
                  controller: controller.password1,
                  onFieldSubmitted: (val) {
                    controller.password1.text = val;
                  },
                  obscureText: !controller.showPassword1.value,
                  labelText: "Password",
                  suffxIcon: Obx(() => !controller.showPassword1.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility)),
                  handleObscure: controller.toggleShowPassword1,
                ),
                AuthTPasswordFormField(
                  controller: controller.confirmPassword,
                  onFieldSubmitted: (val) {
                    controller.confirmPassword.text = val;
                  },
                  obscureText: !controller.showConfirmPassword.value,
                  labelText: "Confirm Password",
                  suffxIcon: Obx(() => !controller.showConfirmPassword.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility)),
                  handleObscure: controller.toggleShowConfirmPassword,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text:
                              "By clicking Sign Up you agree to the following "),
                      TextSpan(
                          text: "Terms and Conditions",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              log("Open Terms and Condition Page");
                            },
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                      TextSpan(text: " withour reservations."),
                    ]),
                  ),
                ),
                const SizedBox(height: 60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MaterialButton(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 16.0, 30.0, 16.0),
                        color: Colors.yellow,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0))),
                        onPressed: () {
                          controller.toggleModes();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.handPointLeft,
                              size: 18.0,
                            ),
                            const SizedBox(width: 20.0),
                            Text(
                              "Sign In".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        padding:
                            const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                        color: Colors.yellow,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0))),
                        onPressed: ()async {
                          await controller.signUp(handleSignUp);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Sign up".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                            const SizedBox(width: 20.0),
                            Icon(
                              FontAwesomeIcons.thumbsUp,
                              size: 18.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AuthButton(
                      onPressed: () {
                        Get.find<FirebaseAuthController>().loginGoogle();
                      },
                      name: "Google",
                      color: Colors.red,
                      icon: FontAwesomeIcons.googlePlusG,
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
