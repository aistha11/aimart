import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'svgCircle.dart';

class DrawerListTile extends StatelessWidget {
  final String svgImage;
  final String title;
  final String route;

  const DrawerListTile(
      {Key? key,
      required this.svgImage,
      required this.title,
      required this.route})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SVGCircle(svgImage: svgImage,),
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Get.toNamed(route);
      },
    );
  }
}

