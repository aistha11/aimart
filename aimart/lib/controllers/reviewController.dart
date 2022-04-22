import 'dart:developer';

import 'package:aimart/controllers/profileController.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/models/mySVM.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebaseAuthController.dart';

class ReviewController extends GetxController {
  final Rx<List<Review>> _reviewList = Rx<List<Review>>([]);

  List<Review> get reviewList => _reviewList.value;
  int get getPositiveCount =>
      _reviewList.value.where((element) => element.sentiment == 1).length;
  int get getNeutralCount =>
      _reviewList.value.where((element) => element.sentiment == 0).length;
  int get getNegativeCount =>
      _reviewList.value.where((element) => element.sentiment == -1).length;

  double get getAverageRating {
    double totalSum = 0.0;
    for (var review in reviewList) {
      totalSum += review.rating;
    }
    return totalSum / reviewList.length;
  }

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
      await getSentiment(description.text);
      Review review = Review(
          id: Utils.getUsername(
              Get.find<FirebaseAuthController>().user!.email!),
          description: description.text,
          rating: rating.value,
          sentiment: sentiment.value,
          userInfo: UserInfo(
            name: Get.find<ProfileController>().dbUser.value.name,
            profilePhoto:
                Get.find<ProfileController>().dbUser.value.profilePhoto,
          ),
          updateDate: DateTime.now());
      ReviewService.createReview(businessId, review).then((value) {
        Get.snackbar("Success", "Your review is successfully created");
      });
      clear();
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Something went wrong. Please try again later");
    }
  }

  double getRatingByScore(double? score){

    if(score == null) return 0;

    if(score <= -4) return 0.5;
    if(score == 0) return 2.5;
    if(score == 0) return 2.5;
    if(score == 0) return 2.5;
    if(score == 0) return 2.5;
    if(score == 0) return 2.5;




    return 2.5;
  }

  Future<void> getSentiment(String msg) async {
    final MySvm mySvm = await SentimentService.getSentiment(msg);
    sentiment.value = mySvm.sentiment;
    rating.value = mySvm.score??2.5;
    update();
  }

  Future<void> deleteReview(String productId, String reviewId) async {
    await ReviewService.deleteReview(productId, reviewId);
  }

  clear() {
    description.text = "";
    rating.value = 0.0;
    enabled.value = false;
    sentiment.value = 0;
    update();
  }
}
