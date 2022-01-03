import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({Key? key, required this.title, required this.textAlign}) : super(key: key);
  final String title;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      child: Text(
        "$title",
        style: TextStyle(fontSize: 24),
        textAlign: textAlign,
      ),
    );
  }
}
