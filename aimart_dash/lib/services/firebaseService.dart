
import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService  {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reference to users collection
  static final usersColsRefs = _db
      .collection(USERSCOLLECTION)
      .withConverter<DbUser>(
          fromFirestore: (doc, _) => DbUser.fromMap(doc.id, doc.data()!),
          toFirestore: (user, _) => user.toMap());

  // Reference to contacts collection
  static final contactColsRefs = _db
      .collection(CONTACTCOLLECTION)
      .withConverter<Contact>(
          fromFirestore: (doc, _) => Contact.fromMap(doc.id, doc.data()!),
          toFirestore: (contact, _) => contact.toMap());

  // Reference to chats collection
  static final chatsColsRefs = _db
      .collection(CHATCOLLECTION)
      .withConverter<ChatUser>(
          fromFirestore: (doc, _) => ChatUser.fromMap(doc.id, doc.data()!),
          toFirestore: (chatUser, _) => chatUser.toMap());

  // Reference to orders collection
  static final ordersColsRefs = _db
      .collection(ORDERCOLLECTION)
      .withConverter<Order>(
          fromFirestore: (doc, _) => Order.fromMap(doc.id, doc.data()!),
          toFirestore: (order, _) => order.toMap());

  // Reference to product collection
  static final productColsRefs = _db
      .collection(PRODUCTCOLLECTION)
      .withConverter<Product>(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (product, _) => product.toMap());

  // All functionality related to users

  /// Get all Users
  static Stream<List<DbUser>> getUsers() {
    final refUsers = usersColsRefs.snapshots();
    return refUsers.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  // All Functionality related to products

  /// Create a product item
  static Future<void> createProduct(Product product) async {
    await productColsRefs.add(product);
  }

  /// Get all products
  static Stream<List<Product>> getProducts() {
    final refProducts = productColsRefs.snapshots();
    return refProducts.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Get single product by id
  static Future<Product?> getProductById(String id) async {
    DocumentSnapshot<Product> snap = await productColsRefs.doc(id).get();
    return snap.data();
  }

  // U - update
  static Future<void> updateProduct(Product product) {
    return productColsRefs
        .doc(product.id)
        .set(product, SetOptions(merge: true));
  }

  /// Delete a product
  /// Takes an id of a product
  static Future<void> deleteProduct(String id) {
    return productColsRefs.doc(id).delete();
  }

  /// Get all orders
  static Stream<List<Order>> getAllOrders() {
    final refOrders =
        ordersColsRefs.orderBy("orderDate", descending: true).snapshots();
    return refOrders.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Update order status
  static Future<void> changeOrderStatus(Order order){
    return ordersColsRefs
        .doc(order.id)
        .set(order, SetOptions(merge: true));
  }

  /// Delete a order
  static Future<void> deleteOrder(Order order) {
    return ordersColsRefs.doc(order.id).delete();
  }


  ///Gets all contacts
  static Stream<List<Contact>> getAllContacts() {
    final refContacts =
        contactColsRefs.orderBy("updateDate", descending: true).snapshots();
    return refContacts.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Delete a contact
  static Future<void> deleteContact(Contact contact) {
    return contactColsRefs.doc(contact.id).delete();
  }

  ///Gets all chat user
  static Stream<List<ChatUser>> getAllChats() {
    final refChats =
        chatsColsRefs.orderBy("updateDate", descending: true).snapshots();
    return refChats.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Update chatUser
  static Future<void> updateChatUser(ChatUser chatUser){
    return chatsColsRefs
        .doc(chatUser.id)
        .set(chatUser, SetOptions(merge: true));
  }
  /// Delete chatUser
  static Future<void> deleteChatUser(ChatUser chatUser){
    return chatsColsRefs
        .doc(chatUser.id)
        .delete();
  }

  /// Streams all chatMessages
  static Stream<List<ChatMessage>> getAllChatMessages(String username) {
    final chatMessageColsRefs = _db
        .collection("$CHATCOLLECTION/$username/messages")
        .withConverter<ChatMessage>(
            fromFirestore: (doc, _) => ChatMessage.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    final chatMessageRefs = chatMessageColsRefs.orderBy("updateDate", descending: true).snapshots();
    return chatMessageRefs.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Create a chatmessage item
  static Future<void> createChatMessage(String username, ChatMessage chatMessage) async {
    final chatMessageColsRefs = _db
        .collection("$CHATCOLLECTION/$username/messages")
        .withConverter<ChatMessage>(
            fromFirestore: (doc, _) => ChatMessage.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    await chatMessageColsRefs.add(chatMessage);
  }
  /// Delete a chatmessage item
  static Future<void> deleteChatMessage(String username, String id) async {
    final chatMessageColsRefs = _db
        .collection("$CHATCOLLECTION/$username/messages")
        .withConverter<ChatMessage>(
            fromFirestore: (doc, _) => ChatMessage.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    await chatMessageColsRefs.doc(id).delete();
  }       

}