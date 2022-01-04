import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: MarkdownView(
        path: "markDown/privacy-policy.md",
      ),
    );
  }
}


