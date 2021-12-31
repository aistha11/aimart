import 'package:aimart_dash/controllers/controllers.dart';
import 'package:get/get.dart';

class WrapperBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NavController>(NavController());
  Get.put<ProductController>(ProductController());
  Get.put<ContactController>(ContactController());
  Get.put<OrderController>(OrderController());
  Get.put<ChatController>(ChatController());
    
  }
}
