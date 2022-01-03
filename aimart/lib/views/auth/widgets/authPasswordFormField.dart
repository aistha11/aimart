import 'package:flutter/material.dart';

class AuthTPasswordFormField extends StatelessWidget {
  const AuthTPasswordFormField({
    Key? key,
    required this.controller,
    required this.onFieldSubmitted,
    required this.obscureText,
    required this.labelText,
    required this.suffxIcon,
    required this.handleObscure,
  }) : super(key: key);
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final String? labelText;
  final bool obscureText;
  final void Function()? handleObscure;
  final Widget suffxIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (val) {
          if (val!.isEmpty) {
            return "*Password is required";
          }
          if (val.length < 8) {
            return "Password should be at least of 8 digit";
          }
          return null;
        },
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: IconButton(
            onPressed: handleObscure,
            icon: suffxIcon,
          ),
        ),
      ),
    );
  }
}
