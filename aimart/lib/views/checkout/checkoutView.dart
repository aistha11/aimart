import 'package:aimart/constants/constants.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            AppHeader(heading: "Checkout"),
            const SizedBox(height: 10.0),
            GetX<CheckoutController>(
              builder: (controller) {
                return Stepper(
                  currentStep: controller.currentStep.value,
                  onStepContinue: () {
                    controller.onStepContinue();
                  },
                  onStepCancel: () {
                    controller.onStepCancel();
                  },
                  controlsBuilder: (_, details) {
                    return Row(
                      children: <Widget>[
                        Visibility(
                          visible: details.stepIndex != 3,
                          child: OutlinedButton(
                            onPressed: details.onStepContinue,
                            child: Text('Next'),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Visibility(
                          visible: details.stepIndex != 0,
                          child: OutlinedButton(
                            onPressed: details.onStepCancel,
                            child: Text('Back'),
                          ),
                        ),
                      ],
                    );
                  },
                  steps: [
                    Step(
                      isActive: controller.currentStep.value >= 0,
                      title: Text("Other charges and total amount"),
                      content: buildTotal(
                        controller.subTotal.value,
                        controller.deliveryCharge.value,
                        controller.vatAmt.value,
                        controller.totalAmt.value,
                      ),
                    ),
                    Step(
                      isActive: controller.currentStep.value >= 1,
                      title: Text("Shipping Address"),
                      subtitle: Text("Provide your exact shipping address"),
                      content: GetX<ProfileController>(builder: (profileContr){
                        return buildShipping(
                        addresses: profileContr
                            .dbUser
                            .value
                            .shippingAddresses,
                        onChanged: (val) {
                          if (val == null) return;
                          controller.setSelectedAddress(
                            val,
                          );
                        },
                      );
                      }),
                    ),
                    Step(
                      isActive: controller.currentStep.value >= 2,
                      title: Text("Order Note"),
                      subtitle: Text("Mention specific notes for us"),
                      content: buildOrderNote(controller.orderNote.value),
                    ),
                    Step(
                      isActive: controller.currentStep.value >= 3,
                      title: Text("Payment Method"),
                      subtitle: Text("Choose your payment method"),
                      content: SizedBox(
                        child: Row(children: [
                          Radio<int>(
                            value: 0,
                            groupValue: controller.paymentOption,
                            onChanged: (val) {
                              controller.setPaymentOption(0);
                            },
                          ),
                          Text("Cash on Delivery"),
                          Radio<int>(
                            value: 1,
                            groupValue: controller.paymentOption,
                            onChanged: (val) {
                              controller.setPaymentOption(1);
                            },
                          ),
                          Text("Khalti"),
                        ]),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.placeOrder();
                  Get.back();
                },
                child: Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTotal(
      double subtotal, double delivery, double vatAmt, double total) {
    Widget buildRow(String title, double amount) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(title),
            Spacer(),
            Text("Rs. ${amount.toStringAsFixed(0)}"),
          ],
        ),
      );
    }

    return SizedBox(
      child: Column(
        children: [
          buildRow("Subtotal", subtotal),
          buildRow("Delivery", delivery),
          buildRow("13% VAT", vatAmt),
          buildRow("Total", total),
        ],
      ),
    );
  }

  Widget buildShipping(
      {required List addresses, Function(String?)? onChanged}) {
    return SizedBox(
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            items: addresses
                .map(
                  (address) => DropdownMenuItem<String>(
                    value: address,
                    child: Text(
                      address,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            isExpanded: true,
          ),
          OutlinedButton.icon(
            onPressed: () {
              var newAddress = TextEditingController(text: "");
              Get.defaultDialog(
                title: "",
                content: SizedBox(
                  child: Column(
                    children: [
                      TextField(
                        controller: newAddress,
                        decoration: InputDecoration(
                          hintText: "Enter New Address",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ),
                cancel: OutlinedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.cancel),
                  label: Text(""),
                ),
                confirm: OutlinedButton.icon(
                  onPressed: () {
                    if(newAddress.text == ""){
                      return;
                    }
                    profileController.addShippingAddress(newAddress.text);
                    Get.back();
                  },
                  icon: Icon(Icons.done),
                  label: Text(""),
                ),
              );
            },
            label: Text("Add New address"),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildOrderNote(TextEditingController ordNote) {
    return SizedBox(
      child: TextField(
        controller: ordNote,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: "Enter Order Note",
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[350],
        ),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
