import 'dart:developer';

import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var username = "".obs;

  final Rx<List<CartItem>> _cartItemList = Rx<List<CartItem>>([]);

  List<CartItem> get cartItemList => _cartItemList.value;

  double get totalPrice {
    double totalPrice = 0.0;
    for (var item in _cartItemList.value) {
      totalPrice += (item.price * item.quantity);
    }
    return totalPrice;
  }

  @override
  void onInit() {
    username.value =
        Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    _cartItemList.bindStream(FirebaseService.getAllCartItem(username.value));
    log(username.value);
    super.onInit();
  }

  

  bool isInCart(String productId) {
    for (var item in _cartItemList.value) {
      if (item.productId == productId) return true;
    }
    return false;
  }

  Future<void> addToCart(Product product, 
      [int quantity = 1, ]) async {
    if (!isInCart(product.id!)) {
      CartItem cartItem = CartItem(
          name: product.name,
          imageUrl: product.imageUrl,
          price: product.price,
          productId: product.id!,
          quantity: quantity,
          userId: username.value,
         );
      await FirebaseService.createCartItem(username.value, cartItem);
      // Utils.showSnackBar("Added to cart", "");
    } else {
      Utils.showSnackBar("Already Added", "Sorry!!! product already added");
    }
  }

  Future<void> deleteCartItem(String id) async {
    await FirebaseService.deleteCartItem(username.value, id);
    // Utils.showSnackBar("Removed from cart", "");
  }

  Future<void> deleteCart() async {
    for (var item in _cartItemList.value) {
      await FirebaseService.deleteCartItem(username.value, item.id!);
    }
  }

  Future<void> incrementCartItem(CartItem cartItem) async {
    CartItem upCartItem = CartItem(
      id: cartItem.id,
      name: cartItem.name,
      imageUrl: cartItem.imageUrl,
      userId: cartItem.userId,
      price: cartItem.price,
      quantity: cartItem.quantity + 1,
      productId: cartItem.productId,
      
    );
    await FirebaseService.updateCartItem(username.value, upCartItem);
  }

  Future<void> decrementCartItem(CartItem cartItem) async {
    if (cartItem.quantity > 1) {
      CartItem upCartItem = CartItem(
        id: cartItem.id,
        name: cartItem.name,
        imageUrl: cartItem.imageUrl,
        userId: cartItem.userId,
        price: cartItem.price,
        quantity: cartItem.quantity - 1,
        productId: cartItem.productId,
        
      );
      await FirebaseService.updateCartItem(username.value, upCartItem);
    } else {
      deleteCartItem(cartItem.id!);
    }
  }
}
