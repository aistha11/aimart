import 'package:get/get.dart';
import 'package:aimart_dash/controllers/controllers.dart';

class ChatMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatMessageController>(ChatMessageController());
  }
}
