import 'package:get/get.dart';
import 'package:aimart/controllers/controllers.dart';

class ChatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatMessageController>(ChatMessageController());
  }
}
