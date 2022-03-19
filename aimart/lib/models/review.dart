import 'databaseItem.dart';

class Review extends DatabaseItem{
    Review({
        required this.id,
        required this.userInfo,
        required this.rating,
        required this.description,
        required this.sentiment,
        required this.updateDate,
    }):super(id);

    final String id;
    final UserInfo userInfo;
    final double rating;
    final String description;
    final int? sentiment;
    final DateTime updateDate;

    factory Review.fromMap(String id, Map<String, dynamic> json) => Review(
        id: id,
        userInfo: UserInfo.fromMap(json["userInfo"]),
        rating: json["rating"],
        description: json["description"],
        sentiment: json["sentiment"]??0,
        updateDate: DateTime.parse(json["updateDate"]),
    );

    Map<String, dynamic> toMap() => {
        "userInfo": userInfo.toMap(),
        "rating": rating,
        "description": description,
        "sentiment": sentiment,
        "updateDate": "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
    };
}

class UserInfo {
    UserInfo({
        required this.name,
        required this.profilePhoto,
    });

    final String name;
    final String profilePhoto;

    factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        name: json["name"],
        profilePhoto: json["profilePhoto"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "profilePhoto": profilePhoto,
    };
}