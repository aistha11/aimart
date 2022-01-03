import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RefundPolicy extends StatelessWidget {
  const RefundPolicy({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Policy"),
        centerTitle: true,
      ),
      body: MarkdownView(
        path: "assets/markDown/refund-policy.md",
      ),
    );
  }
}


