/* {
  "id" : "adfjjad43j234f",
  "title": "App Development",
  "imageUrl": "https://cdn.shopify.com/s/files/1/0559/9736/6449/products/WebDevelopment_1_1800x1800.png?v=1617489687",
  "price":{
      "basic": 247417.18,
      "standard": 494834.35,
      "premium": 1649447.83
  },
  "description":"We Design and Develop Experiences that Make People's lives simples."
}
*/

import 'databaseItem.dart';

class Product extends DatabaseItem {
  Product({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
  }) : super(id);

  final String? id;
  final String title;
  final String imageUrl;
  final Price price;
  final String description;

  factory Product.fromMap(String id, Map<String, dynamic> json) => Product(
        id: id,
        title: json["title"],
        imageUrl: json["imageUrl"],
        price: Price.fromMap(json["price"]),
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "imageUrl": imageUrl,
        "price": price.toMap(),
        "description": description,
      };
}

class Price {
  Price({
    required this.basic,
    required this.standard,
    required this.premium,
  });

  final double basic;
  final double standard;
  final double premium;

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        basic: json["basic"].toDouble(),
        standard: json["standard"].toDouble(),
        premium: json["premium"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "basic": basic,
        "standard": standard,
        "premium": premium,
      };
}