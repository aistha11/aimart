import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_rating/star_rating.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key? key, required this.dbUser}) : super(key: key);
  final DbUser dbUser;
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
            return ReviewTile(key: Key(i.toString()), review: review);
          },
        );
      },
    );
  }
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({Key? key, required this.review}) : super(key: key);
  final Review review;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: Get.height * 0.055,
        child: CircleAvatar(
          foregroundImage:
              CachedNetworkImageProvider(review.userInfo.profilePhoto),
          radius: 21.0,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.userInfo.name,
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
                color: Pallete.primaryCol,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${review.updateDate.year}-${review.updateDate.month}-${review.updateDate.day}",
                style: TextStyle(
                  fontSize: 14,
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

// class ReviewButton extends StatelessWidget {
//   const ReviewButton({Key? key,required this.dbUser}) : super(key: key);
//   final DbUser dbUser;
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ReviewController>(
//       builder: (controller) {
//         return controller.canReview
//             ? Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: FloatingActionButton(
//                     backgroundColor: Colors.grey,
//                     onPressed: () {
                     
//                     },
//                     child: Icon(
//                       Icons.reviews_outlined,
//                       color: Pallete.primaryCol,
//                     ),
//                   ),
//                 ),
//               )
//             : Padding(padding: EdgeInsets.all(8));
//       },
//     );
//   }
// }
