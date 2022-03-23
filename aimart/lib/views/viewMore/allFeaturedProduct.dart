import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/widgets/productGridView.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllFeatured extends StatelessWidget {
  const AllFeatured({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                AppHeader(heading: "Featured Products"),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GetX<ProductController>(
              builder: (productController) {
                return ProductGridView(productList: productController.featuredProducts,); 
              },
            ),
          ],
        ),
      ),
    );
  }
}