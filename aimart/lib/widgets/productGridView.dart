import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final double itemHeight = (Get.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = Get.width / 2;
    return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: Get.height * 0.90,
                child: GridView.builder(
                  itemCount: 20,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (_, i) {
                    return ProductCard(
                      product: Product(
                        id: "adfjjad43j234f",
                        categoryId: "adfasdfh",
                        description: "Test Description",
                        imageUrl:
                            "https://cdn.shopify.com/s/files/1/0559/9736/6449/products/WebDevelopment_1_1800x1800.png?v=1617489687",
                        price: 1234,
                        name: "Test Product",
                        subCategory: "Nike",
                        updateDate: DateTime.now(),
                        discount: 0.0,
                        rating: 3,
                      ),
                    );
                  },
                ),
              ),
            );
  }
}