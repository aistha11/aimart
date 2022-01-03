import 'package:aimart/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownView extends StatelessWidget {
  final String path;

  const MarkdownView({required this.path});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(path),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Markdown(data: snapshot.data!, selectable: true, onTapLink: (a,b,c){
            Utils.launchUrl(a);
          },);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}