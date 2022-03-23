import 'package:aimart_dash/constants/messageType.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/services/firebaseService.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:aimart_dash/utilities/utilities.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatMessageController extends GetxController {
  var chatScaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<List<ChatMessage>> _chatMessageList = Rx<List<ChatMessage>>([]);

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]);

  List<ChatMessage> get chatMessageList => _chatMessageList.value;

  var message = TextEditingController().obs;

  var uploading = false.obs;

  var username = "".obs;

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

  sendTextMessageByAdmin(ChatUser chatUser, String senderId) async {
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
        senderId: senderId,
        receiverId: username.value,
        type: MESSAGE_TYPE_TEXT,
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
  Future<void> sendImageMessageByAdmin(ChatUser chatUser, String senderId, String imgUrl) async {
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
      ChatMessage chatMessage = ChatMessage(
        message: "Send Image.",
        senderId: senderId,
        receiverId: username.value,
        type: MESSAGE_TYPE_IMAGE,
        photoUrl: imgUrl,
        updateDate: DateTime.now(),
      );
      await FirebaseService.createChatMessage(username.value, chatMessage)
          .then((value) {
        Get.find<ChatController>().setLastMessage(chatUser, chatMessage.message);
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
