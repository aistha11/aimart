import 'package:get/get.dart';
import 'package:aimart/controllers/controllers.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController());
  }
}
