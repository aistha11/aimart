import 'databaseItem.dart';


class ChatUser extends DatabaseItem {
  ChatUser({
    this.id,
    required this.name,
    required this.profileImg,
    required this.lastMessage,
    required this.updateDate,
  }) : super(id);

  final String? id;
  final String name;
  final String profileImg;
  final String lastMessage;
  final DateTime updateDate;

  factory ChatUser.fromMap(String id, Map<String, dynamic> json) => ChatUser(
        id: id,
        name: json["name"],
        profileImg: json["profileImg"],
        lastMessage: json["lastMessage"],
        updateDate: json["updateDate"]?.toDate(),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "profileImg": profileImg,
        "lastMessage": lastMessage,
        "updateDate": updateDate,
      };
}
