import 'databaseItem.dart';

class Order extends DatabaseItem {
  Order({
    this.id,
    required this.orderDate,
    required this.orderState,
    required this.orderNote,
    required this.orderedItems,
    required this.totalAmount,
    required this.userId,
    required this.shippingAddress,
    required this.paymentMethod,
  }) : super(id);

  final String? id;
  
  final DateTime orderDate;
  final String orderState;
  final String orderNote;
  final List<OrderedItem> orderedItems;
  final double totalAmount;
  final String userId;
  final String shippingAddress;
  final int paymentMethod; // 0 for COD, 1 for khalti
  

  factory Order.fromMap(String id,Map<String, dynamic> json) => Order(
        id: id,
        orderDate: json["orderDate"]?.toDate(),
        orderState: json["orderState"],
        orderNote: json["orderNote"],
        orderedItems: List<OrderedItem>.from(
            json["orderedItems"].map((x) => OrderedItem.fromMap(x))),
        totalAmount: json["totalAmount"],
        userId: json["userId"],
        shippingAddress: json["shippingAddress"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toMap() => {
        "orderDate": orderDate,
        "orderState": orderState,
        "orderNote": orderNote,
        "orderedItems": List<dynamic>.from(orderedItems.map((x) => x.toMap())),
        "totalAmount": totalAmount,
        "userId": userId,
        "shippingAddress": shippingAddress,
        "paymentMethod": paymentMethod,
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