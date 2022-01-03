import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key, required this.description, required this.textAlign}) : super(key: key);
  final String description;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Text(
          "$description",
          style: TextStyle(fontSize: 18),
          textAlign: textAlign),
    );
  }
}
