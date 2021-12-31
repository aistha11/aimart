import 'package:get/get.dart';
import 'package:aimart_dash/controllers/controllers.dart';

class EditProducBinding implements Bindings {
@override
void dependencies() {
  Get.put<EditProductController>(EditProductController());
  }
}