import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key, required this.heading}) : super(key: key);
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 20.0,
          top: 15.0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20.0)),
            width: 70.0,
            height: 20.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Text(
            heading,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
