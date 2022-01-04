import 'package:aimart/controllers/controllers.dart';
import 'package:get/get.dart';

class InstanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());

    Get.put<CategoryController>(CategoryController());
    Get.put<ProductController>(ProductController());

    

    Get.lazyPut<SearchController>(() => SearchController());

  }
}
