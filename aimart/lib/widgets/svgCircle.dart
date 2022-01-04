import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGCircle extends StatelessWidget {
  final String svgImage;
  final double radius;

  const SVGCircle({Key? key, required this.svgImage, this.radius = 18,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: SvgPicture.asset(
        svgImage,
      ),
      backgroundColor: Colors.white,
    );
  }
}
