import 'package:aimart/controllers/controllers.dart';
import 'package:get/get.dart';

class SingleProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ReviewController>(ReviewController());
  }
}
