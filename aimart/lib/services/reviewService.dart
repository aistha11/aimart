import 'package:aimart/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aimart/config/config.dart';

class ReviewService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // All functionality related to reviews

  /// Streams all review item
  static Stream<List<Review>> getAllReview(String productId) {
    
    final reviewColsRefs = _db
        .collection("$PRODUCTCOLLECTION/$productId/reviews")
        .withConverter<Review>(
            fromFirestore: (doc, _) => Review.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    final reviewRefs = reviewColsRefs.snapshots();
    return reviewRefs.map((list) {
      return list.docs.map((doc) => doc.data()).toList();
    });
  }

  /// Create a review item
  static Future<void> createReview(String productId, Review reviewItem) async {
    final reviewColsRefs = _db
        .collection("$PRODUCTCOLLECTION/$productId/reviews")
        .withConverter<Review>(
            fromFirestore: (doc, _) => Review.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    await reviewColsRefs.doc(reviewItem.id).set(reviewItem);
  }

  /// Delete review item
  static Future<void> deleteReview(String productId, String id) async {
    final reviewColsRefs = _db
        .collection("$PRODUCTCOLLECTION/$productId/reviews")
        .withConverter<Review>(
            fromFirestore: (doc, _) => Review.fromMap(doc.id, doc.data()!),
            toFirestore: (reviewItem, _) => reviewItem.toMap());
    await reviewColsRefs.doc(id).delete();
  }

  /// Update review item
  static Future<void> updateReview(String productId, Review reviewItem) async {
    final reviewColsRefs = _db
        .collection("$PRODUCTCOLLECTION/$productId/reviews")
        .withConverter<Review>(
            fromFirestore: (doc, _) => Review.fromMap(doc.id, doc.data()!),
            toFirestore: (item, _) => item.toMap());
    await reviewColsRefs.doc(reviewItem.id).set(reviewItem, SetOptions(merge: true));
  }
}