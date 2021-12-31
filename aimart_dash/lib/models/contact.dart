import 'databaseItem.dart';

class Contact extends DatabaseItem{
    Contact({
        this.id,
        required this.name,
        required this.email,
        required this.number,
        required this.message,
        required this.updateDate,
    }):super(id);

    final String? id;
    final String name;
    final String email;
    final int number;
    final String message;
    final DateTime updateDate;

    factory Contact.fromMap(String id,Map<String, dynamic> json) => Contact(
        id: id,
        name: json["name"],
        email: json["email"],
        number: json["number"],
        message: json["message"],
        updateDate: json["updateDate"]?.toDate(),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "number": number,
        "message": message,
        "updateDate": updateDate,
    };
}