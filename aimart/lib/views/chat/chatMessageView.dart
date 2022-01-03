import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessageView extends GetView<ChatMessageController> {
  const ChatMessageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.chatScaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset("assets/images/appLogo.png"),
            ),
            SizedBox(width: 10,),
            Text(
              "Ai Mart",
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GetX<ChatMessageController>(builder: (controller) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10.0);
                },
                reverse: true,
                itemCount: controller.chatMessageList.length,
                itemBuilder: (BuildContext context, int index) {
                  ChatMessage chatMessage = controller.chatMessageList[index];
                  if (chatMessage.senderId != "aimart11") {
                    return _buildMessageRow(chatMessage, current: true);
                  }
                  return _buildMessageRow(chatMessage, current: false);
                },
              );
            }),
          ),
          ChatMessageField(),
        ],
      ),
    );
  }

  Widget _buildMessageRow(ChatMessage message, {required bool current}) {
    return GestureDetector(
      onLongPress: () {
        if (current) {
          Get.defaultDialog(
            title: "Do you want to delete?",
            backgroundColor: current ? Colors.red : Colors.cyanAccent,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Message: ${message.message}"),
                Text("Created at: ${message.updateDate}")
              ],
            ),
            confirm: IconButton(
              onPressed: () async {
                await controller.deleteChatMessageItem(message.id!);
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
        }
      },
      child: Row(
        mainAxisAlignment:
            current ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: current ? 30.0 : 20.0),
          if (!current) ...[
            CircleAvatar(
              child: Image.asset("assets/images/appLogo.png"),
              radius: 18.0,
            ),
            const SizedBox(width: 5.0),
          ],

          ///Chat bubbles
          Container(
            padding: EdgeInsets.only(
              bottom: 5,
              right: 5,
            ),
            child: Column(
              crossAxisAlignment:
                  current ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    minHeight: 40,
                    maxHeight: 250,
                    maxWidth: Get.size.width * 0.7,
                    minWidth: Get.size.width * 0.1,
                  ),
                  decoration: BoxDecoration(
                    color: current ? Colors.red : Colors.cyanAccent,
                    borderRadius: current
                        ? BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 5, right: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: current
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            message.message,
                            style: TextStyle(
                              color: current ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: current ? 20.0 : 30.0),
        ],
      ),
    );
  }
}

class ChatMessageField extends StatelessWidget {
  const ChatMessageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GetBuilder<ChatMessageController>(builder: (controller) {
              return TextField(
                controller: controller.message.value,
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: "Aa"),
                onEditingComplete: () {
                  controller.sendMessageByUser();
                },
              );
            }),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Get.find<ChatMessageController>().sendMessageByUser();
            },
          )
        ],
      ),
    );
  }
}
