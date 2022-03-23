import 'package:aimart/models/category.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryGridView extends StatelessWidget {
  const CategoryGridView({ Key? key, required this.categoryList }) : super(key: key);
  final List<Category> categoryList;
  @override
  Widget build(BuildContext context) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 3.5;
    final double itemWidth = Get.width / 2;
    return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: Get.height * 0.90,
                child: GridView.builder(
                  itemCount: categoryList.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (itemWidth / itemHeight),
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (_, i) {
                    return CategoryWidget(
                      category: categoryList[i],
                    );
                  },
                ),
              ),
            );
  }
}