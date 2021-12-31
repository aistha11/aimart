import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  final Rx<List<ChatUser>> _chatUserList = Rx<List<ChatUser>>([]);

  List<ChatUser> get chatUserList => _chatUserList.value;

  @override
  void onInit() {
    _chatUserList.bindStream(FirebaseService.getAllChats());
    super.onInit();
  }

  Future<void> setLastMessage(ChatUser chatUser, String message) async {
    ChatUser upChatUser = ChatUser(
      id: chatUser.id,
      name: chatUser.name,
      lastMessage: message,
      profileImg: chatUser.profileImg,
      updateDate: DateTime.now()
    );
    await FirebaseService.updateChatUser(upChatUser);
  }

}