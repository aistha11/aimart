import 'dart:developer';

import 'package:aimart/config/config.dart';
import 'package:aimart/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reference to users collection
  static final usersColsRefs = _db
      .collection(USERSCOLLECTION)
      .withConverter<DbUser>(
          fromFirestore: (doc, _) => DbUser.fromMap(doc.id,doc.data()!),
          toFirestore: (user, _) => user.toMap());

  // Reference to category collection
  static final categoryColsRefs = _db
      .collection(CATEGORYCOLLECTION)
      .withConverter<Category>(
          fromFirestore: (doc, _) => Category.fromMap(doc.id, doc.data()!),
          toFirestore: (category, _) => category.toMap());
  
  // Reference to products collection
  static final productColsRefs = _db
      .collection(PRODUCTCOLLECTION)
      .withConverter<Product>(
          fromFirestore: (doc, _) => Product.fromMap(doc.id, doc.data()!),
          toFirestore: (product, _) => product.toMap());

  // Reference to orders collection
  static final orderColsRefs = _db
      .collection(ORDERSCOLLECTION)
      .withConverter<Order>(
          fromFirestore: (doc, _) => Order.fromMap(doc.id, doc.data()!),
          toFirestore: (order, _) => order.toMap());

  // Reference to contacts collection
  static final contactsColsRefs = _db
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

  // All functionality related to users

  /// Create Dbuser by Dbuser
  /// If the user is new then it is created in database
  /// If it already exists then
  static Future<void> createDbUserById(DbUser dbuser) async {
    var userIfExist =
        await usersColsRefs.where("username", isEqualTo: dbuser.username).get();
    if (userIfExist.docs.isEmpty) {
      log("Creating a new user in db");
      await usersColsRefs.doc(dbuser.username).set(dbuser);
    } else {
      log("User already exists");
    }
  }

  /// Get stream of db user by id
  static Stream<DbUser> streamDbUserById(String id) {
    final refUser = usersColsRefs.doc(id).snapshots();

    return refUser.map((doc) {
      return doc.data()!;
    });
  }

  /// Get db user by id
  static Future<DbUser> getDbUserById(String id) async {
    DocumentSnapshot<DbUser> userSnap = await usersColsRefs.doc(id).get();
    return userSnap.data()!;
  }

  /// Update db User
  static Future<void> updateProfile(DbUser user)async{
    return await usersColsRefs.doc(user.username).set(user, SetOptions(merge: true));
  }

  // All Functionality related to categories


  /// Get all categories
  static Stream<List<Category>> getCategories() {
    final refCategories = categoryColsRefs.snapshots();
    return refCategories.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Get single category by id
  static Future<Category?> getCategoryById(String id) async {
    DocumentSnapshot<Category> snap = await categoryColsRefs.doc(id).get();
    return snap.data();
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

  /// Get featured products
  static Stream<List<Product>> getFeaturedProducts(int limit) {
    final refProducts = productColsRefs.where("featured", isEqualTo: true).limit(10).snapshots();
    return refProducts.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }
  /// Get featured products
  static Stream<List<Product>> getLatestProducts(int limit) {
    final refProducts = productColsRefs.orderBy("updateDate", descending: true).limit(10).snapshots();
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

  // All functionality related to carts

  /// Streams all cart item
  static Stream<List<CartItem>> getAllCartItem(String username) {
    
    final cartColsRefs = _db
        .collection("$USERSCOLLECTION/$username/carts")
        .withConverter<CartItem>(
            fromFirestore: (doc, _) => CartItem.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    final cartRefs = cartColsRefs.snapshots();
    return cartRefs.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Create a cart item
  static Future<void> createCartItem(String username, CartItem cartItem) async {
    final cartColsRefs = _db
        .collection("$USERSCOLLECTION/$username/carts")
        .withConverter<CartItem>(
            fromFirestore: (doc, _) => CartItem.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    await cartColsRefs.add(cartItem);
  }

  /// Delete cart item
  static Future<void> deleteCartItem(String username, String id) async {
    final cartColsRefs = _db
        .collection("$USERSCOLLECTION/$username/carts")
        .withConverter<CartItem>(
            fromFirestore: (doc, _) => CartItem.fromMap(doc.id, doc.data()!),
            toFirestore: (cartItem, _) => cartItem.toMap());
    await cartColsRefs.doc(id).delete();
  }

  /// Update cart item
  static Future<void> updateCartItem(String username, CartItem cartItem) async {
    final cartColsRefs = _db
        .collection("$USERSCOLLECTION/$username/carts")
        .withConverter<CartItem>(
            fromFirestore: (doc, _) => CartItem.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    await cartColsRefs.doc(cartItem.id).set(cartItem, SetOptions(merge: true));
  }

  /// Create a contact item
  static Future<void> createContact(Contact contact) async {
    await contactsColsRefs.add(contact);
  }

  // All Functionality related to orders

  /// Create a product item
  static Future<void> createOrder(Order order) async {
    await orderColsRefs.add(order);
  }

  /// Get all orders
  static Stream<List<Order>> getMyOrders(String username) {
    final refOrders =
        orderColsRefs.where("userId", isEqualTo: username).orderBy("orderDate", descending: true).snapshots();
    return refOrders.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
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

  /// Update chatUser
  static Future<void> updateChatUser(ChatUser chatUser){
    return chatsColsRefs
        .doc(chatUser.id)
        .set(chatUser, SetOptions(merge: true));
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