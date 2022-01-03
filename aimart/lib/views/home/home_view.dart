import 'package:aimart/bindings/bindings.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:aimart/views/views.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Ai Mart"),
          actions: [
            InkWell(
              child: SVGCircle(svgImage: "assets/images/chat.svg"),
              onTap: (){
                String email = Get.find<FirebaseAuthController>().user!.email!;
                String username = Utils.getUsername(email);
                Get.to(() => ChatMessageView(),
                    binding: ChatsBinding(), arguments: {'id': username});
              },
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Center(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}
