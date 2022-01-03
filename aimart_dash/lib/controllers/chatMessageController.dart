import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/services/firebaseService.dart';
import 'package:aimart_dash/utilities/utilities.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessageController extends GetxController {
  var chatScaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<List<ChatMessage>> _chatMessageList = Rx<List<ChatMessage>>([]);

  List<ChatMessage> get chatMessageList => _chatMessageList.value;

  var message = TextEditingController().obs;

  var username = "".obs;

  @override
  void onInit() {
    username.value = Get.arguments['id']!;
    print(username.value);
    _chatMessageList.bindStream(FirebaseService.getAllChatMessages(username.value));
    super.onInit();
  }

  Future<void> deleteAllChatMessages() async {
    for (var item in _chatMessageList.value) {
      await FirebaseService.deleteChatMessage(username.value, item.id!);
    }
  }

  Future<void> deleteChatMessageItem(String id) async {
    await FirebaseService.deleteChatMessage(username.value, id);
  }

  sendMessageByAdmin(ChatUser chatUser) async {
    try {
      if (message.value.text.isEmpty) {
        FocusScope.of(chatScaffoldKey.currentState!.context)
            .requestFocus(FocusNode());
        return;
      }
      ConnectivityResult connectivity =
          await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        throw "Check your internet connection";
      }
      ChatMessage chatMessage = ChatMessage(
        message: message.value.text,
        senderId: "aimart11",
        receiverId: username.value,
        updateDate: DateTime.now(),
      );
      await FirebaseService.createChatMessage(username.value, chatMessage)
          .then((value) {
        Get.find<ChatController>().setLastMessage(chatUser, message.value.text);
        FocusScope.of(chatScaffoldKey.currentState!.context)
            .requestFocus(FocusNode());
        message.value.text = "";
        update();
      });
    } catch (e) {
      Utils.showSnackBar("Sorry!!!", e.toString());
    }
  }
}
