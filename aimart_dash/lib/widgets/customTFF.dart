import 'package:flutter/material.dart';

class CustomTFF extends StatelessWidget {
  const CustomTFF({Key? key, this.controller, this.onFieldSubmitted, this.labelText, this.validator}) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final String? labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            labelText: labelText,
          ),
          onFieldSubmitted: onFieldSubmitted,
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
