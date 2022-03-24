import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/constants/dependencies.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:aimart_dash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<NavController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Ai-Mart Dashboard"),
          actions: [
            // IconButton(
            //   onPressed: () {
            //     ThemeService().switchTheme();
            //     settingsController
            //         .toggleThemeMode(!settingsController.isDarkMode.value);
            //   },
            //   icon: Obx(
            //     () {
            //       print("Dark Mode: ${settingsController.isDarkMode.value}");
            //       if (settingsController.isDarkMode.value) {
            //         return Icon(Icons.light_mode);
            //       } else {
            //         return Icon(Icons.dark_mode); 
            //       }
            //     },
            //   ),
            // ),
            IconButton(
              onPressed: () async {
                await Get.find<FirebaseAuthController>().signOut();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: controller.pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Pallete.backgroundColor,
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Pallete.primaryCol,
          items: [
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/products.svg",
                radius: 14,
              ),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/categories.svg",
                radius: 14,
              ),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/orders.svg",
                radius: 14,
              ),
              label: "Orders",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/contact-us.svg",
                radius: 14,
              ),
              label: "Contact",
            ),
            BottomNavigationBarItem(
              icon: SVGCircle(
                svgImage: "assets/images/chat.svg",
                radius: 14,
              ),
              label: "Chat",
            ),
          ],
          onTap: (index) {
            controller.onPageChange(index);
          },
        ),
      );
    });
  }
}
