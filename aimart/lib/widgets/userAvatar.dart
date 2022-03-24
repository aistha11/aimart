import 'package:aimart/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {Key? key,
      required this.profileUrl,
      required this.name,
      this.isRound = true,
      this.radius = 40})
      : super(key: key);
  final String profileUrl;
  final String name;
  final bool isRound;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return profileUrl != ""
        ? isRound
            ? CircleAvatar(
                radius: radius,
                foregroundImage: CachedNetworkImageProvider(profileUrl),
              )
            : Container(
                height: radius * 2,
                width: radius * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.yellowAccent,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(profileUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )
        : Container(
            height: radius * 2,
            width: radius * 2,
            decoration: BoxDecoration(
              shape: isRound ? BoxShape.circle : BoxShape.rectangle,
              color: Colors.yellowAccent,
            ),
            child: Center(
              child: Text(
                Utils.getInitials(name),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: UniversalVariables.lightBlueColor,
                  fontSize: 20,
                ),
              ),
            ),
          );
  }
}
