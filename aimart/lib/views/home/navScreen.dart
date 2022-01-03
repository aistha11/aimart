import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavView extends StatelessWidget {
  final ProfileController userController = Get.put(ProfileController());
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());

   NavView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<NavController>(builder: (controller) {
      return Scaffold(
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Pallete.backgroundColor,
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Pallete.primaryCol,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.design_services), label: "Services"),
            BottomNavigationBarItem(
                icon: GetX<CartController>(builder: (controller){
                  return Badge(
                  child: Icon(Icons.shopping_cart),
                  badgeContent: Text("${controller.cartItemList.length}"),
                  badgeColor: Pallete.cyan100,
                );
                }),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "Orders"),
          ],
          onTap: (index) {
            controller.onPageChange(index);
          },
        ),
      );
    });
  }
}
