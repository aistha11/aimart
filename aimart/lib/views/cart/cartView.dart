import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50.0),
              AppHeader(heading: "Cart"),
          Flexible(
            child: GetX<CartController>(
              builder: (controller) {
                if (controller.cartItemList.isEmpty) {
                  return Center(
                    child: Text("Your cart is empty"),
                  );
                }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.cartItemList.length,
                  itemBuilder: (_, i) {
                    CartItem item = controller.cartItemList[i];
                    return CartItemTile(
                      key: Key(item.id.toString()),
                      cartItem: item,
                    );
                  },
                );
              },
            ),
          ),
          GetX<CartController>(
            builder: (controller) {
              return Visibility(
                visible: controller.cartItemList.isNotEmpty,
                child: CheckoutSection(
                  price: controller.totalPrice,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
