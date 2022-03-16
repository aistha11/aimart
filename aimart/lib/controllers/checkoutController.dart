import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:aimart/constants/constants.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/utilities/utilities.dart';

import 'controllers.dart';

class CheckoutController extends GetxController {
  var currentStep = 0.obs;

  final _paymentOption = 0.obs; // 0 for COD & 1 for khalti
  int get paymentOption => _paymentOption.value;
  var subTotal = 0.0.obs;
  var totalAmt = 0.0.obs;

  var deliveryCharge = 10.0.obs;

  var vatAmt = 0.0.obs;

  var orderNote = TextEditingController().obs;


  var shippingAddress = "".obs;
  

  @override
  onInit() {
    subTotal.value = Get.arguments["subTotal"];
    vatAmt.value = (13 / 100) * subTotal.value;
    totalAmt.value = subTotal.value + vatAmt.value + deliveryCharge.value;
    _paymentOption.value = 0;
    super.onInit();
  }

  onStepContinue() {
    if(currentStep.value == 1 && shippingAddress.value == ""){
      Get.snackbar("Sorry", "Please select the address or add new");
      return;
    }
    if(currentStep.value == 2 && orderNote.value.text == ""){
      Get.snackbar("Sorry", "Please add something");
      return;
    }
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

  setPaymentOption(int val) {
    _paymentOption.value = val;
    log("Payment option: $paymentOption");
    update();
  }

  setSelectedAddress(String address) {
    shippingAddress.value = address;
    update();
  }

  Future<void> _payByKhalti(Order order) async{
    final payConfig = PaymentConfig(
      amount: order.totalAmount.toInt() * 100,
      productIdentity: order.orderedItems[0].productId,
      productName: order.orderedItems[0].name,
    );
    await KhaltiScope.of(Get.context!).pay(
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
        Get.snackbar("Failed", "Payment failed. Try Again");
      },
    );
  }

  Future<void> placeOrder() async {
    try {
      ConnectivityResult connectivity =
          await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        throw Exception("You are not connected to the internet");
      }

      Order order = Order(
        userId: Utils.getUsername(firebaseAuthController.user!.email!),
        totalAmount: totalAmt.value,
        orderState: "Pending",
        shippingAddress: shippingAddress.value,
        paymentMethod: paymentOption,
        orderNote: orderNote.value.text,
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
      log("Payment option: $paymentOption");
      if (paymentOption == 1) {
        await _payByKhalti(order);
         Get.back();
      } else {
        await orderController.submitOrder(order).then((value) {
          cartController.deleteCart();
          Utils.showSnackBar("Success", "Your order is placed successfully");
        });
         Get.back();
      }
     
    } catch (e) {
      Utils.showSnackBar("Sorry!!!", Utils.getExceptionMessage(e.toString()));
    }
  }
}
