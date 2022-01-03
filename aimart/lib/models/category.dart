
import 'package:equatable/equatable.dart';
import 'databaseItem.dart';

class Category extends DatabaseItem with EquatableMixin {
  Category({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.subCategory,
    required this.updateDate,
  }) : super(id);

  final String? id;
  final String name;
  final String imageUrl;
  final List<SubCategory> subCategory;
  final DateTime updateDate;

  factory Category.fromMap(String id, Map<String, dynamic> json) => Category(
        id: id,
        name: json["name"],
        imageUrl: json["imageUrl"],
        subCategory: List<SubCategory>.from(
            json["subCategory"].map((x) => SubCategory.fromMap(x))),
        updateDate: json["updateDate"]?.toDate(),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "imageUrl": imageUrl,
        "subCategory": List<dynamic>.from(subCategory.map((x) => x.toMap())),
        "updateDate": updateDate,
      };

  @override
  List<Object?> get props => [id,name,imageUrl,subCategory];

}

class SubCategory with EquatableMixin{
  SubCategory({
    required this.name,
  });

  final String name;

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };

  @override
  List<Object?> get props => [name];
}