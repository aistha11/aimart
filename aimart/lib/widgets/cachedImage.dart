import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final bool isRound;
  final double radius;
  final double? height;
  final double? width;

  final BoxFit fit;

  const CachedImage(
    this.imageUrl, {Key? key, 
    this.isRound = false,
    this.radius = 0,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        height: isRound ? radius : height,
        width: isRound ? radius : width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isRound ? 50 : radius),
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              // placeholder: (context, url) => MyShimmer.userCircle(radius),
              errorWidget: (context, url, error) {
                return SizedBox(
                  height: isRound ? radius : height,
                  width: isRound ? radius : width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isRound ? 50 : radius),
                  ),
                );
              }),
        ),
      );
    } catch (e) {
      return SizedBox(
        height: isRound ? radius : height,
        width: isRound ? radius : width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isRound ? 50 : radius),
        ),
      );
    }
  }
}