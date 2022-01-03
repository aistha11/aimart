import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: GetX<CartController>(
              builder: (controller) {
                if (controller.cartItemList.isEmpty) {
                  return Center(
                    child: Text("Your cart is empty"),
                  );
                }
                return ListView.builder(
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
              return CheckoutSection(
                price: controller.totalPrice,
                onCheckout: () async {
                  try {
                    if(controller.cartItemList.isEmpty){
                      throw Exception("Your cart is empty. Add some for checkout");
                    }
                    ConnectivityResult connectivity =
                        await Connectivity().checkConnectivity();
                    if (connectivity == ConnectivityResult.none) {
                      throw Exception("You are not connected to the internet");
                    }
                    

                    Order order = Order(
                      userId: Utils.getUsername(
                          Get.find<FirebaseAuthController>().user!.email!),
                      totalAmount: controller.totalPrice,
                      orderState: "Pending",
                      orderedItems: controller.cartItemList.map((cartItem) {
                        OrderedItem orderedItem = OrderedItem(
                          name: cartItem.name,
                          imageUrl: cartItem.imageUrl,
                          price: cartItem.price,
                          productId: cartItem.productId,
                          quantity: cartItem.quantity,
                        );
                        return orderedItem;
                      }).toList(),
                      orderDate: DateTime.now(),
                    );
                    await Get.find<OrderController>()
                        .submitOrder(order)
                        .then((value) {
                      controller.deleteCart();
                      Utils.showSnackBar("Success", "Your order is placed successfully");
                    });
                  } catch (e) {
                    Utils.showSnackBar("Sorry!!!", Utils.getExceptionMessage(e.toString()));
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
