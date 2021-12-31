import 'package:aimart_dash/config/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authController.dart';

const TextStyle boldText = TextStyle(
  fontWeight: FontWeight.bold,
);

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<AuthController>(
        builder: (controller) {
          return Form(
            key: controller.signInFormKey.value,
            child: Column(
              children: <Widget>[
                TextFormField(
                  enabled: false,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "*Email is required";
                    }
                    if (!GetUtils.isEmail(val)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  controller: controller.email1.value,
                  onFieldSubmitted: (val) {
                    controller.email1.value.text = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(
                      16.0,
                    ),
                    hintText: "Email",
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controller.password1.value,
                  onFieldSubmitted: (val) {
                    controller.password1.value.text = val;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    contentPadding: const EdgeInsets.all(
                      16.0,
                    ),
                    prefixStyle: boldText.copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Pallete.primaryCol,
                    ),
                    onPressed: () async {
                      await controller.signIn();
                    },
                    child: Text("Sign In"),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          );
        },
      ),
    );
  }
}