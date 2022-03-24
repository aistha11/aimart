import 'dart:developer';

import 'package:aimart/constants/constants.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatMessageController extends GetxController {
  var chatScaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<List<ChatMessage>> _chatMessageList = Rx<List<ChatMessage>>([]);

  List<ChatMessage> get chatMessageList => _chatMessageList.value;

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]);

  var message = TextEditingController().obs;

  var username = "".obs;


  var uploading = false.obs;

  var imageUrl = "".obs;


  final picker = ImagePicker();

  Future<void> chooseImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      pickedImages.value.add(PickedFile(pickedFile!.path));
    } catch (e) {
      Get.snackbar("Ohh😮😮😮😮", "Image not selected😌😌😌😌");
    }

    update();
  }

   Future uploadFile() async {
    uploading.value = true;
    update();

    PickedFile img = pickedImages.value[0];

    imageUrl.value = await ImageUploader.uploadImage(img.path, "chat_images/${username.value}");

    uploading.value = false;
    update();
  }

  @override
  void onInit() {
    username.value = Get.arguments['id']!;
    log(username.value);
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

  sendTextMessageByUser(String receiverId) async {
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
        receiverId: receiverId,
        type: MESSAGE_TYPE_TEXT,
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
  Future<void> sendImageMessageByUser(String receiverId) async {
    final ProfileController userController = Get.find<ProfileController>();
    try {
      if (imageUrl.value.isEmpty) {
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
        lastMessage: "Send Image.",
        updateDate: DateTime.now(),
      );
      ChatMessage chatMessage = ChatMessage(
        message: "Send Image.",
        senderId: username.value,
        receiverId: receiverId,
        type: MESSAGE_TYPE_IMAGE,
        photoUrl: imageUrl.value,
        updateDate: DateTime.now(),
      );
      await FirebaseService.createChatMessage(username.value, chatMessage)
          .then((value) {
            FirebaseService.updateChatUser(chatUser);
        FocusScope.of(chatScaffoldKey.currentState!.context)
            .requestFocus(FocusNode());
        pickedImages.value = [];
        imageUrl.value = "";
        update();
      });
    } catch (e) {
      Utils.showSnackBar("Sorry!!!", e.toString());
    }
  }
}
