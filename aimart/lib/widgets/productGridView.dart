import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key, required this.productList})
      : super(key: key);
  final List<Product> productList;
  @override
  Widget build(BuildContext context) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = Get.width / 2;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: Get.height * 0.90,
        child: GridView.builder(
          itemCount: productList.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            mainAxisSpacing: 15,
          ),
          itemBuilder: (_, i) {
            return ProductCard(
              product: productList[i],
            );
          },
        ),
      ),
    );
  }
}
