import 'package:aimart/controllers/controllers.dart';
import 'package:get/get.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CheckoutController>(CheckoutController());
  }
}
