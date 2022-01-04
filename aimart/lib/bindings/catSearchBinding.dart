import 'package:aimart/controllers/controllers.dart';
import 'package:get/get.dart';

class CategorySearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CategorySearchController>(CategorySearchController());
  }
}
