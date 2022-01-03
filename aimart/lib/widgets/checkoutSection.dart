import 'package:aimart/config/config.dart';
import 'package:flutter/material.dart';

class CheckoutSection extends StatelessWidget {
  final double price;
  final Function onCheckout;

  const CheckoutSection(
      {Key? key, required this.price, required this.onCheckout})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Checkout Price:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    price.toStringAsFixed(2),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: Pallete.primaryCol,
              elevation: 1.0,
              child: InkWell(
                splashColor: Colors.cyanAccent,
                onTap: () {
                  onCheckout();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Checkout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
