import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/reviewsWidget.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_rating/star_rating.dart';

class SingleProduct extends StatelessWidget {
  SingleProduct({Key? key}) : super(key: key);

  final String productId = Get.parameters['id']!;

  @override
  Widget build(BuildContext context) {
    final Product product =
        Get.find<ProductController>().getProductById(productId);
    return Scaffold(
      backgroundColor: Pallete.cyan100,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Column(
            children: [
              Stack(
                children: [
                  buildProductImage(product),
                  Align(
                    alignment: Alignment.topCenter,
                    child: buildAppBar(product),
                  ),
                ],
              ),
              buildProductDescription(product),
            ],
          ),
          buildDraggableReview(product),
        ],
      ),
      floatingActionButton:
          buildReviewButton(Get.find<ProfileController>().dbUser.value),
    );
  }

  Widget buildProductImage(Product product) {
    return Container(
      width: Get.width,
      height: Get.height * .5,
      padding: EdgeInsets.all(1),
      child: CachedNetworkImage(
        imageUrl: product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildReviewButton(DbUser dbUser) {
    return FloatingActionButton(
      onPressed: () {
        Get.dialog(
          Dialog(
            child: Container(
              width: Get.width * .60,
              height: Get.height * .35,
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: SizedBox(
                      height: Get.height * 0.055,
                      child: CircleAvatar(
                        foregroundImage:
                            CachedNetworkImageProvider(dbUser.profilePhoto),
                        radius: 21.0,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dbUser.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        GetX<ReviewController>(builder: (reviewController) {
                          return StarRating(
                            length: 5,
                            rating: reviewController.rating.value,
                            between: 5.0,
                            onRaitingTap: (rat) {
                              reviewController.setRating(rat);
                            },
                            starSize: 30.0,
                            color: Pallete.primaryCol,
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: Get.find<ReviewController>().description,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            "Share Details of your own experience at this place",
                        fillColor: Colors.grey[350],
                        filled: true,
                      ),
                      onChanged: (val) {
                        Get.find<ReviewController>().changeEnabled();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Get.find<ReviewController>().enabled.value
                                      ? Pallete.primaryCol
                                      : Colors.grey,
                            ),
                            onPressed: () {
                              Get.find<ReviewController>().enabled.value
                                  ? Get.find<ReviewController>()
                                      .createReview()
                                      .then((value) {
                                      Get.back();
                                    })
                                  : null;
                            },
                            child: Text(
                              "Post",
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                      SizedBox(
                        width: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.reviews_outlined,
        color: Pallete.primaryCol,
      ),
    );
  }

  Widget buildDraggableReview(Product product) {
    return DraggableScrollableSheet(
      initialChildSize: 0.10,
      minChildSize: 0.10,
      maxChildSize: 0.9,
      builder: (_, scrollController) {
        return Container(
          width: Get.width,
          height: Get.height * .6,
          decoration: BoxDecoration(
            color: Pallete.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                offset: Offset(0, -4),
                blurRadius: 8,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Column(
                children: [
                  // SizedBox(
                  //   height: 40,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: [Text("1 Review")],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: ReviewsWidget(
                      dbUser: Get.find<ProfileController>().dbUser.value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildAppBar(Product product) {
    return AppBar(
      title: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(60),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Text(
          product.name,
          style: TextStyle(
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      actions: [
        GetX<CartController>(
          builder: (controller) {
            return IconButton(
              onPressed: () {
                Get.find<NavController>().onPageChange(2);
                Get.back();
              },
              icon: Badge(
                child: Icon(Icons.shopping_cart),
                badgeContent: Text("${controller.cartItemList.length}"),
                badgeColor: Pallete.cyan100,
              ),
            );
          },
        ),
        SizedBox(
          width: 20,
        ),
      ],
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildProductDescription(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Text(product.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Text(
            "Rs ${product.price.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.red,
              fontSize: 30.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            "Description",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          child: Text(
            product.description,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.grey.shade600),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15.0, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Pallete.primaryCol,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                ),
                onPressed: () async {
                  await Get.find<CartController>().addToCart(
                    product,
                    1,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 32.0),
                  child: Text("Add to cart"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
