import 'databaseItem.dart';

class DbUser extends DatabaseItem {
  DbUser({
    this.id,
    required this.name,
    required this.username,
    required this.profilePhoto,
    required this.email,
    required this.shippingAddresses,
    this.number,
  }) : super(id);

  final String? id;
  final String name;
  final String username;
  final String profilePhoto;
  final String email;
  final int? number;
  final List<String> shippingAddresses;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'profilePhoto': profilePhoto,
      'email': email,
      'number': number,
      'shippingAddresses': List<dynamic>.from(shippingAddresses.map((x) => x)),
    };
  }

  factory DbUser.fromMap(String id, Map<String, dynamic> map) {
    return DbUser(
      id: id,
      name: map['name'],
      username: map['username'],
      profilePhoto: map['profilePhoto'],
      email: map['email'],
      number: map['number'],
      shippingAddresses:
          List<String>.from(map["shippingAddresses"].map((x) => x)),
    );
  }
}
