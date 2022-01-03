import 'package:flutter/material.dart';
import 'package:aimart/widgets/widgets.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
        centerTitle: true,
      ),
      body: MarkdownView(
        path: "assets/markDown/terms-of-service.md",
      ),
    );
  }
}


