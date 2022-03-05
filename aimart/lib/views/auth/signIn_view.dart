import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';
import 'forgotPassword_view.dart';
import 'widgets/authButton.dart';
import 'widgets/authPasswordFormField.dart';
import 'widgets/authSubmitButton.dart';
import 'widgets/authTextFormField.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key, required this.handleSignIn}) : super(key: key);
  final void Function(String email, String password)? handleSignIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: GetBuilder<AuthController>(builder: (controller) {
        return Form(
          key: controller.signInFormKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              AppHeader(heading: "Sign In"),
              const SizedBox(height: 30.0),
              AuthTextFormField(
                controller: controller.email,
                onFieldSubmitted: (val) {
                  controller.email.text = val;
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
                controller: controller.password,
                onFieldSubmitted: (val) {
                  controller.password.text = val;
                },
                obscureText: !controller.showPassword.value,
                labelText: "Password",
                suffxIcon: Obx(() => !controller.showPassword.value
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility)),
                handleObscure: controller.toggleShowPassword,
              ),
              Container(
                padding: const EdgeInsets.only(right: 16.0, top: 16),
                alignment: Alignment.centerRight,
                child: Text.rich(
                  TextSpan(
                    text: "Forgot your password?",
                    style: TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Get.to(ForgotPasswordView());
                        Get.to(() => ForgotPasswordView());
                      },
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Obx(() => Get.find<FirebaseAuthController>().status ==
                      Status.AUTHENTICATING
                  ? Center(child: CircularProgressIndicator())
                  : AuthSubmitButton(
                      onPressed: () async {
                        await controller.signIn(handleSignIn);
                      },
                      icon: FontAwesomeIcons.thumbsUp,
                      name: "Sign In")),
              const SizedBox(height: 50.0),
              Center(child: Text("Or continue with")),
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
                  const SizedBox(width: 10.0),
                ],
              ),
              const SizedBox(height: 50.0),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                  color: Colors.yellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0))),
                  onPressed: () {
                    controller.toggleModes();
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
                        FontAwesomeIcons.handPointRight,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      })),
    );
  }
}
