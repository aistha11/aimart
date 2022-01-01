import 'package:aimart_dash/bindings/bindings.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:aimart_dash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../chat/chatMessageView.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ChatController>(builder: (controller) {
        if (controller.chatUserList.isEmpty) {
          return Center(
            child: Text("No Chats"),
          );
        }
        return ListView.builder(
            itemCount: controller.chatUserList.length,
            itemBuilder: (_, i) {
              ChatUser chatUser = controller.chatUserList[i];
              return Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                  SlidableAction(
                    label: "Delete",
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    onPressed: (_) async {
                      Get.defaultDialog(
                        title: "Do you want to delete?",
                        backgroundColor: Colors.red,
                        middleText: "This will delete all of the chats and the user too.",
                        confirm: IconButton(
                          onPressed: () async {
                            await FirebaseService.deleteChatUser(chatUser);
                            Get.back();
                          },
                          icon: Icon(Icons.done),
                        ),
                        cancel: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      );
                    },
                  ),
                ],
                ),
                child: ListTile(
                  key: Key(chatUser.id!),
                  onTap: () {
                    Get.to(
                        () => ChatMessageView(
                              chatUser: chatUser,
                            ),
                        binding: ChatMessageBinding(),
                        arguments: {"id": "${chatUser.id}"});
                  },
                  leading: UserCircle(
                    key: key,
                    name: chatUser.name,
                    profileImage: chatUser.profileImg,
                  ),
                  title: Text(chatUser.name),
                  subtitle: Text(
                    chatUser.lastMessage,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            });
      }),
    );
  }
}
