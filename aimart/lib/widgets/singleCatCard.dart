import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleCatCard extends StatelessWidget {
  final String productId;
  final String name;
  final String category;
  final String price;
  final String imgUrl;
  const SingleCatCard({
    Key? key,
    required this.name,
    required this.price,
    required this.category,
    required this.imgUrl,
    required this.productId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Get.toNamed("/product/$productId"),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(20),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.3,
              height: height * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imgUrl),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: Get.width * .4,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  category,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.money,
                      color: Colors.green,
                      size: 11,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
