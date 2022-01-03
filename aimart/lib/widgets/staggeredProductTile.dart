import 'package:aimart/config/config.dart';
import 'package:aimart/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'singleProduct.dart';

class StaggeredProductTile extends StatelessWidget {
  const StaggeredProductTile({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleProduct(product: product));
      },
      child: Card(
        child: Container(
          color: Pallete.cyan100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
              //Title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //Price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:Text(product.price.toStringAsFixed(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
