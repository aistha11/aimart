import 'databaseItem.dart';


class ChatMessage extends DatabaseItem {
  ChatMessage({
    this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.type,
     this.photoUrl,
    required this.updateDate,
  }) : super(id);

  final String? id;
  final String message;
  final String senderId;
  final String receiverId;
  String type;
  String? photoUrl;
  final DateTime updateDate;

  factory ChatMessage.fromMap(String id, Map<String, dynamic> json) => ChatMessage(
        id: id,
        message: json["message"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        type: json["type"],
        photoUrl: json["photoUrl"],
        updateDate: json["updateDate"]?.toDate(),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "senderId": senderId,
        "receiverId": receiverId,
        "type": type,
        "photoUrl": photoUrl,
        "updateDate": updateDate,
      };
}
