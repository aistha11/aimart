import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
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

  // Future<void> deleteAllChatMessages() async {
  //   for (var item in _chatMessageList.value) {
  //     await FirebaseApi.deleteChatMessage(username.value, item.id!);
  //   }
  // }

  Future<void> deleteChatMessageItem(String id) async {
    await FirebaseService.deleteChatMessage(username.value, id);
  }

  sendMessageByUser() async {
    final ProfileController userController = Get.find<ProfileController>();
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
      ChatUser chatUser = ChatUser(
        id: userController.dbUser.value.id,
        name: userController.dbUser.value.name,
        profileImg: userController.dbUser.value.profilePhoto,
        lastMessage: message.value.text,
        updateDate: DateTime.now(),
      );
      ChatMessage chatMessage = ChatMessage(
        message: message.value.text,
        senderId: username.value,
        receiverId: "aimart11",
        updateDate: DateTime.now(),
      );
      await FirebaseService.createChatMessage(username.value, chatMessage)
          .then((value) {
            FirebaseService.updateChatUser(chatUser);
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
