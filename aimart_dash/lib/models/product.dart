/* {
  "id" : "adfjjad43j234f",
  "name": "App Development",
  "imageUrl": "https://cdn.shopify.com/s/files/1/0559/9736/6449/products/WebDevelopment_1_1800x1800.png?v=1617489687",
  "description":"We Design and Develop Experiences that Make People's lives simples.",
  "price": 1234,
  "discount": 12,
  "featured": true,
  "categoryId": "12asdfyagf23",
  "subCategory": "12asdfyagf23",
  "updateDate": 2020-12-21
}
*/

import 'package:equatable/equatable.dart';

import 'databaseItem.dart';



class Product extends DatabaseItem with EquatableMixin{
    Product({
        this.id,
        required this.name,
        required this.imageUrl,
        required this.description,
        required this.price,
        this.discount = 0,
        this.featured = false,
        required this.categoryId,
        required this.subCategory,
        required this.updateDate,
    }):super(id);

    final String? id;
    final String name;
    final String imageUrl;
    final String description;
    final double price;
    final double discount;
    final bool featured;
    final String categoryId;
    final String subCategory;
    final DateTime updateDate;

    factory Product.fromMap(String id, Map<String, dynamic> json) => Product(
        id: id,
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        price: json["price"],
        discount: json["discount"],
        featured: json["featured"],
        categoryId: json["categoryId"],
        subCategory: json["subCategory"],
        updateDate: DateTime.parse(json["updateDate"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "price": price,
        "discount": discount,
        "featured": featured,
        "categoryId": categoryId,
        "subCategory": subCategory,
        "updateDate": "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
    };

  @override
  List<Object?> get props => [id,name,description,imageUrl,price,discount,featured,categoryId,subCategory];
}
