import 'package:aimart_dash/controllers/controllers.dart';
import 'package:get/get.dart';

class EditCategoryBinding implements Bindings {
@override
void dependencies() {
  Get.put<EditCategoryController>(EditCategoryController());
}
}