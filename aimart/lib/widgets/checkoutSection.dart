
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutSection extends StatelessWidget {
  final double price;
  

  const CheckoutSection(
      {Key? key, required this.price,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: Text(
            //   "Checkout Price: Rs. ${price.toStringAsFixed(0)}",
            //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            // ),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                style: TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: "Subtotal: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: " Rs. ${price.toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          AlignedButton(
            btnName: "Checkout",
            onPressed: () {
              Get.toNamed("/checkout", arguments: {'subTotal': price});
            },
          ),
        ],
      ),
    );
  }
}
