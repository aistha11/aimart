import 'package:aimart/controllers/controllers.dart';
import 'package:get/get.dart';

class WrapperBinding implements Bindings {
@override
void dependencies() {
  Get.put<NavController>(NavController());
    Get.put<HomeController>(HomeController());
    Get.put<ProductController>(ProductController());
  }
}