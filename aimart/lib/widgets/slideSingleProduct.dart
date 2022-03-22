import 'dart:ui';

import 'package:aimart/config/config.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:star_rating/star_rating.dart';

import '../controllers/controllers.dart';

class SlideSingleProduct extends StatefulWidget {
  const SlideSingleProduct({Key? key}) : super(key: key);

  @override
  _SlideSingleProductState createState() => _SlideSingleProductState();
}

class _SlideSingleProductState extends State<SlideSingleProduct> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 90.0;
  final String productId = Get.parameters['id']!;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .75;
    final Product product =
        Get.find<ProductController>().getProductById(productId);
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(product),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: GetX<CartController>(
              builder: (cartController) {
                return Visibility(
                  visible: !cartController.isInCart(productId),
                  child: buildCartFAB(product),
                );
              },
            ),
          ),

          Positioned(
            top: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),

          //back icon
          Positioned(
            top: 52.0,
            left: 20.0,
            child: buildBackIcon(),
          ),
          //cart icon
          Positioned(
            top: 52.0,
            right: 20.0,
            child: buildCartIcon(),
          ),
        ],
      ),
    );
  }

  Widget buildBackIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        },
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
        ],
      ),
    );
  }

  Widget buildCartFAB(Product product) {
    return FloatingActionButton.extended(
      label: Text(
        "Add to cart",
        style: TextStyle(color: Colors.black),
      ),
      icon: Icon(
        Icons.add_shopping_cart,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () async {
        await Get.find<CartController>().addToCart(
          product,
          1,
        );
      },
      backgroundColor: Colors.white,
    );
  }

  Widget buildCartIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 1),
      child: GetX<CartController>(
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Top Reviews",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            GetX<ReviewController>(builder: (reviewController) {
              return buildSentimentRow(
                positiveCount: reviewController.getPositiveCount,
                neutralCount: reviewController.getNeutralCount,
                negativeCount: reviewController.getNegativeCount,
              );
            }),
            SizedBox(
              height: 36.0,
            ),
            GetBuilder<ReviewController>(builder: (reviewController) {
              return reviewController.canReview
                  ? buildCanReview(Get.find<ProfileController>().dbUser.value)
                  : SizedBox(
                      height: 18,
                    );
            }),
            SizedBox(
              height: 18.0,
            ),
            SizedBox(
              height: Get.height * 0.6,
              child: ReviewsWidget(
                  dbUser: Get.find<ProfileController>().dbUser.value),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ));
  }

  Widget buildCanReview(DbUser dbUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    "Share Details of your own experience of this product",
                fillColor: Colors.grey[350],
                filled: true,
              ),
              textInputAction: TextInputAction.send,
              onEditingComplete: () {
                Get.find<ReviewController>().createReview().then((value) {});
              },
              onChanged: (val) {
                Get.find<ReviewController>().changeEnabled();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 10,
              ),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Get.find<ReviewController>().enabled.value
                          ? Pallete.primaryCol
                          : Colors.grey,
                    ),
                    onPressed: () {
                      Get.find<ReviewController>().enabled.value
                          ? Get.find<ReviewController>()
                              .createReview()
                              .then((value) {})
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
    );
  }

  Widget buildSentimentRow(
      {int positiveCount = 0, int negativeCount = 0, int neutralCount = 0}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _button("Positive", "🤗", Colors.green, positiveCount),
        _button("Neutral", "😐", Colors.blue, neutralCount),
        _button("Negative", "😣", Colors.red, negativeCount),
      ],
    );
  }

  Widget _button(String label, String emoji, Color color, int count) {
    return Column(
      children: <Widget>[
        Badge(
          badgeContent: Text("$count"),
          badgeColor: color,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              emoji,
              style: TextStyle(color: Colors.white),
            ),
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 8.0,
              )
            ]),
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body(Product product) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
          ),
          buildProductImage(product),
          buildProductDescription(product),
          SizedBox(
            height: _panelHeightClosed,
          ),
        ],
      ),
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

  Widget buildProductDescription(Product product) {
    return SizedBox(
      height: Get.height * 0.50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
            child: ResPrice(price: product.price, large: true,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: GetX<ReviewController>(
              builder: (reviewController) {
                return StarRating(
                  length: 5,
                  rating: reviewController.getAverageRating,
                  between: 5.0,
                  starSize: 20.0,
                  color: Color.fromARGB(255, 224, 207, 50),
                );
              },
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
              maxLines: 6,
            ),
          ),
        ],
      ),
    );
  }
}
