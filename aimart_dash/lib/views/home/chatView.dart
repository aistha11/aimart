import 'package:aimart_dash/bindings/bindings.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
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
        return ListView.builder(
            itemCount: controller.chatUserList.length,
            itemBuilder: (_, i) {
              ChatUser chatUser = controller.chatUserList[i];
              return Slidable(
                // actionPane: SlidableStrechActionPane(),
                // secondaryActions: [
                //   IconSlideAction(
                //     caption: "Delete",
                //     icon: Icons.delete,
                //     color: Colors.red,
                //     onTap: () async {
                //       Get.defaultDialog(
                //         title: "Do you want to delete?",
                //         backgroundColor: Colors.red,
                //         middleText: "This will delete all of the chats and the user too.",
                //         confirm: IconButton(
                //           onPressed: () async {
                //             await FirebaseApi.deleteChatUser(chatUser);
                //             Get.back();
                //           },
                //           icon: Icon(Icons.done),
                //         ),
                //         cancel: IconButton(
                //           onPressed: () {
                //             Get.back();
                //           },
                //           icon: Icon(Icons.cancel),
                //         ),
                //       );
                //     },
                //   ),
                // ],
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
