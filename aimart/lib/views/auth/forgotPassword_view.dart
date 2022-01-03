import 'package:aimart/controllers/controllers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'widgets/authTextFormField.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/images/forgot-password.png",
              height: 300,
              width: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "Forgot your password?\n\n",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: "That's Ok...\n\n",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      )),
                  TextSpan(
                      text:
                          "Just enter the email address you've used to register with us and we'll send you a reset link!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      )),
                ]),
                textAlign: TextAlign.center,
              ),
            ),
            AuthTextFormField(
              controller: controller.forgotEmail,
              onFieldSubmitted: (val) {
                controller.forgotEmail.text = val;
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "Email must be provided";
                }
                return null;
              },
              labelText: "Email",
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0)),
                  backgroundColor: MaterialStateProperty.all(Colors.yellow),
                  elevation: MaterialStateProperty.all(0.0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.find<FirebaseAuthController>()
                      .sendPasswordResetEmail(controller.forgotEmail.text);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black),
                    ),
                    const SizedBox(width: 20.0),
                    Icon(
                      FontAwesomeIcons.thumbsUp,
                      size: 18.0,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text.rich(
              TextSpan(
                  text: "Go Back".toUpperCase(),
                  style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.back();
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
