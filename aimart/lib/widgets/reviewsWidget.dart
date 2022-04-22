import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_rating/star_rating.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key, required this.dbUser,required this.productId}) : super(key: key);
  final DbUser dbUser;
  final String productId;
  @override
  Widget build(BuildContext context) {
    return GetX<ReviewController>(
      builder: (controller) {
        if (controller.reviewList.isEmpty) {
          return Center(
            child: Text("No Reviews Yet."),
          );
        }
        return ListView.builder(
          itemCount: controller.reviewList.length,
          itemBuilder: (_, i) {
            Review review = controller.reviewList[i];
            return ReviewTile(review: review, productId: productId,);
          },
        );
      },
    );
  }
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({Key? key, required this.review,required this.productId}) : super(key: key);
  final Review review;
  final String productId;

  Color getTileColor(int? sentiment) {
    switch (sentiment) {
      case 1:
        return Colors.green;
      case -1:
        return Colors.red;

      default:
        return Colors.blue;
    }
  }

  String getSentimentEmoji(int? sentiment) {
    switch (sentiment) {
      case 1:
        return "🤗";
      case -1:
        return "😣";

      default:
        return "😐";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: (){
        Get.find<ReviewController>().deleteReview(productId, review.id);
      },
      tileColor: getTileColor(review.sentiment),
      leading: UserAvatar(
        profileUrl: review.userInfo.profilePhoto,
        name: review.userInfo.name,
        radius: 21,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${getSentimentEmoji(review.sentiment)} ${review.userInfo.name}",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              StarRating(
                length: 5,
                rating: review.rating,
                between: 5.0,
                starSize: 20.0,
                color: Color.fromARGB(255, 224, 207, 50),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${review.updateDate.year}-${review.updateDate.month}-${review.updateDate.day}",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      contentPadding: EdgeInsets.only(left: 20),
      subtitle: Text(
        review.description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
    );
  }
}
