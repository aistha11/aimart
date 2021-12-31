import 'databaseItem.dart';


class ChatMessage extends DatabaseItem {
  ChatMessage({
    this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.updateDate,
  }) : super(id);

  final String? id;
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime updateDate;

  factory ChatMessage.fromMap(String id, Map<String, dynamic> json) => ChatMessage(
        id: id,
        message: json["message"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        updateDate: json["updateDate"]?.toDate(),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "senderId": senderId,
        "receiverId": receiverId,
        "updateDate": updateDate,
      };
}
