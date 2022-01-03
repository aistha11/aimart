


import 'databaseItem.dart';

/// This is a model for the user
/// It is used while performing crud operation on firebase database
/// Also used if the api operation is carried out
/// Here, the username is generated from the email which is unique
/// For Eg: Email:- marketingproo@gmail.com then username will be marketingproo

class DbUser extends DatabaseItem{
  DbUser({
    this.id,
    required this.name,
    required this.username,
    required this.profilePhoto,
    required this.email,
    this.number,
  }): super(id);

  final String? id;
  final String name;
  final String username;
  final String profilePhoto;
  final String email;
  final int? number;

  

  Map<String, dynamic> toMap() {
    return {
      
      'name': name,
      'username': username,
      'profilePhoto': profilePhoto,
      'email': email,
      'number': number,
    };
  }

  factory DbUser.fromMap(String id,Map<String, dynamic> map) {
    return DbUser(
      id: id,
      name: map['name'],
      username: map['username'],
      profilePhoto: map['profilePhoto'],
      email: map['email'],
      number: map['number'],
    );
  }

  

  
}
