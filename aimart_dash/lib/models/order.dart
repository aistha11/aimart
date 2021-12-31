import 'databaseItem.dart';

class Order extends DatabaseItem {
  Order({
    this.id,
    required this.orderDate,
    required this.orderState,
    required this.orderedItems,
    required this.totalAmount,
    required this.userId,
  }) : super(id);

  final String? id;
  
  final DateTime orderDate;
  final String orderState;
  final List<OrderedItem> orderedItems;
  final double totalAmount;
  final String userId;
  

  factory Order.fromMap(String id,Map<String, dynamic> json) => Order(
        id: id,
        orderDate: json["orderDate"]?.toDate(),
        orderState: json["orderState"],
        orderedItems: List<OrderedItem>.from(
            json["orderedItems"].map((x) => OrderedItem.fromMap(x))),
        totalAmount: json["totalAmount"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "orderDate": orderDate,
        "orderState": orderState,
        "orderedItems": List<dynamic>.from(orderedItems.map((x) => x.toMap())),
        "totalAmount": totalAmount,
        "userId": userId,
      };
}

class OrderedItem {
  OrderedItem({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
  });

  final String imageUrl;
  final String name;
  final double price;
  final String productId;
  final int quantity;

  factory OrderedItem.fromMap(Map<String, dynamic> json) => OrderedItem(
        imageUrl: json["imageUrl"],
        name: json["name"],
        price: json["price"],
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "name": name,
        "price": price,
        "productId": productId,
        "quantity": quantity,
      };
}