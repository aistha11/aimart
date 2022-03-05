import 'dart:developer';

import 'package:aimart/constants/constants.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'controllers.dart';

class CheckoutController extends GetxController {
  var currentStep = 0.obs;

  var paymentOption = 0.obs; // 0 for COD & 1 for khalti

  var subTotal = 0.0.obs;
  var totalAmt = 0.0.obs;

  var deliveryCharge = 10.0.obs;

  var vatAmt = 0.0.obs;

  var orderNote = TextEditingController().obs;

  var selectedAddress = 0.obs;

  @override
  onInit() {
    subTotal.value = Get.arguments["subTotal"];
    vatAmt.value = (13 / 100) * subTotal.value;
    totalAmt.value = subTotal.value + vatAmt.value + deliveryCharge.value;
    super.onInit();
  }

  onStepContinue() {
    if (currentStep.value != 3) {
      currentStep.value++;
    }
    update();
  }

  onStepCancel() {
    if (currentStep.value != 0) {
      currentStep.value--;
    }
    update();
  }

  onStepTapped(int index) {
    currentStep.value = index;
    update();
  }

  setPaymentOption(int val) {
    paymentOption.value = val;
    update();
  }

  setSelectedAddress(int val) {
    selectedAddress.value = val;
    update();
  }

  placeOrder() async {
    try {
      ConnectivityResult connectivity =
          await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        throw Exception("You are not connected to the internet");
      }

      Order order = Order(
        userId:
            Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!),
        totalAmount: totalAmt.value,
        orderState: "Pending",
        orderedItems: cartController.cartItemList.map((cartItem) {
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
      final payConfig = PaymentConfig(
        amount: order.totalAmount.toInt() * 100,
        productIdentity: order.orderedItems[0].productId,
        productName: order.orderedItems[0].name,
      );
      KhaltiScope.of(Get.context!).pay(
        config: payConfig,
        preferences: [
          PaymentPreference.khalti,
        ],
        onSuccess: (success) async {
          Get.snackbar("Success", "Payment succeded");
          await Get.find<OrderController>().submitOrder(order).then((value) {
            cartController.deleteCart();
            Utils.showSnackBar("Success", "Your order is placed successfully");
          });
        },
        onFailure: (failure) {
          log(failure.toString());
          Get.snackbar("Failed", "Payment failed");
        },
      );
    } catch (e) {
      Utils.showSnackBar("Sorry!!!", Utils.getExceptionMessage(e.toString()));
    }
  }
}
