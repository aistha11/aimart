import 'databaseItem.dart';

class CartItem extends DatabaseItem {
  final String? id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final String userId;
  final String productId;
  final String plan;

  CartItem({
    required this.name,
    this.id,
    required this.imageUrl,
    required this.userId,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.plan,
  }) : super(id);

  CartItem.fromMap(String id, Map<String, dynamic> data)
      : id = id,
        name = data['name'],
        userId = data['userId'],
        imageUrl = data['imageUrl'],
        quantity = data['quantity'],
        productId = data['productId'],
        plan = data['plan'],
        price = data['price'],
        super(id);

  Map<String, dynamic> toMap() => {
        "name": name,
        "userId": userId,
        "imageUrl": imageUrl,
        "quantity": quantity,
        "productId": productId,
        "plan": plan,
        "price": price,
      };
}
