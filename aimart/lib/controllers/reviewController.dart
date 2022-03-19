import 'dart:developer';

import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebaseAuthController.dart';

class ReviewController extends GetxController {
  final Rx<List<Review>> _reviewList = Rx<List<Review>>([]);

  List<Review> get reviewList => _reviewList.value;

  var description = TextEditingController();
  var rating = 0.0.obs;
  var sentiment = 0.obs;
  String businessId = "";

  var enabled = false.obs;
  final RxBool _canReview = true.obs;

  bool get canReview {
    var username =
        Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    for (var review in _reviewList.value) {
      if (review.id == username) {
        _canReview.value = false;
      }
    }
    return _canReview.value;
  }

  setRating(double rat) {
    if (rat < 0.0 || rat > 5.0) {
      return;
    }
    rating.value = rat;
    log("Rating value: " + rating.value.toString());
  }

  changeEnabled() {
    if (description.text != "") {
      enabled.value = true;
    } else {
      enabled.value = false;
    }
    update();
    log("Description value: " + description.text);
  }

  @override
  void onInit() {
    businessId = Get.parameters['id']!;
    log("Review Id: " + businessId);
    _reviewList.bindStream(ReviewService.getAllReview(businessId));
    super.onInit();
  }

  Future<void> createReview() async {
    try {
      Review review = Review(
          id: Utils.getUsername(
              Get.find<FirebaseAuthController>().user!.email!),
          description: description.text,
          rating: rating.value,
          sentiment: sentiment.value,
          userInfo: UserInfo(
            name: Get.find<FirebaseAuthController>().user!.displayName!,
            profilePhoto: Get.find<FirebaseAuthController>().user!.photoURL!,
          ),
          updateDate: DateTime.now());
      ReviewService.createReview(businessId, review).then((value) {
        Get.snackbar("Success", "Your review is successfully created");
      });
      clear();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again later");
    }
  }

  getSentiment(String msg) async {
    sentiment.value = await SentimentService.getSentiment(msg);
    update();
  }

  clear() {
    description.text = "";
    rating.value = 0.0;
    enabled.value = false;
  }
}
