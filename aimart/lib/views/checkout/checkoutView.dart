import 'package:aimart/constants/constants.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutView extends StatelessWidget {
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
                  onStepTapped: (index) {
                    controller.onStepTapped(index);
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
                      content: buildShipping(
                        addresses: ["Kusunti", "Ekantakuna", "Yatayat"],
                        selected: controller.selectedAddress.value,
                        onChanged: (val) {
                          controller.setSelectedAddress(val!);
                        },
                      ),
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
                            groupValue: controller.paymentOption.value,
                            onChanged: (val) {
                              controller.setPaymentOption(val!);
                            },
                          ),
                          Text("Cash on Delivery"),
                          Radio<int>(
                            value: 1,
                            groupValue: controller.paymentOption.value,
                            onChanged: (val) {
                              controller.setPaymentOption(val!);
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
                  checkoutController.placeOrder();
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
      {required List addresses,required int selected, Function(int?)? onChanged}) {
    Widget buildAddress(int val, int grpVal, String address) {
      return Row(
        children: [
          Radio<int>(
            value: val,
            groupValue: grpVal,
            onChanged: onChanged,
          ),
          Text(address),
        ],
      );
    }

    return SizedBox(
      child: Column(
        children: [
          Column(
            children: addresses
                .map(
                  (address) => buildAddress(
                      addresses.indexOf(address), selected, address),
                )
                .toList(),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("Add New address"),
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
      ),
    );
  }
}
