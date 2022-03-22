import 'package:flutter/material.dart';

class ResPrice extends StatelessWidget {
  const ResPrice(
      {Key? key, required this.price, this.mini = false, this.large = false})
      : super(key: key);
  final double price;
  final bool mini;
  final bool large;
  @override
  Widget build(BuildContext context) {
    // return Text(
    //   price.toStringAsFixed(0),
    //   style: TextStyle(
    //       color: Colors.black,
    // fontSize: mini
    //     ? 12
    //     : large
    //         ? 26
    //         : 18,
    // fontWeight: mini
    //     ? FontWeight.w100
    //     : large
    //         ? FontWeight.w400
    //         : FontWeight.w200),
    // );
    return RichText(
      text: TextSpan(
        style: TextStyle(
            color: Colors.black,
            fontWeight: mini
                ? FontWeight.w400
                : large
                    ? FontWeight.w600
                    : FontWeight.w400),
        children: [
          TextSpan(
            text: "Rs. ",
            style: TextStyle(
              fontSize: mini
                  ? 12
                  : large
                      ? 19
                      : 14,
            ),
          ),
          TextSpan(
            text: price.toStringAsFixed(0),
            style: TextStyle(
              fontSize: mini
                  ? 16
                  : large
                      ? 26
                      : 18,
            ),
          ),
        ],
      ),
    );
  }
}
