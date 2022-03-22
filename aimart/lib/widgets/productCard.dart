import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/cartController.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_rating/star_rating.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/product/${product.id}");
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Container(
          width: Get.width * 0.42,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                child: Stack(
                  children: [
                    Image(
                      height: Get.height * 0.22,
                      width: Get.width * 0.43,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(product.imageUrl),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 35,
                        height: 35,
                        color: Pallete.primaryCol,
                        child: IconButton(
                          onPressed: () {
                            Get.find<CartController>().addToCart(product);
                          },
                          icon: Icon(Icons.add_shopping_cart_rounded),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Visibility(
                        visible: product.discount != 0.0,
                        child: Container(
                          width: 50,
                          height: 25,
                          color: Color.fromARGB(255, 236, 43, 69),
                          child: Text(
                            "-${product.discount.toStringAsFixed(1)}%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    ResPrice(
                      price: product.price,
                      mini: true,
                    ),
                    StarRating(
                      length: 5,
                      rating: product.rating!,
                      between: 5.0,
                      starSize: 20.0,
                      color: Color.fromARGB(255, 224, 207, 50),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
