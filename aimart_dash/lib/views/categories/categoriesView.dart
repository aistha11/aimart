import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<CategoryController>(
          builder: (controller) {
            if (controller.categoryList.isEmpty) {
              return Center(
                child: Text("No categories"),
              );
            }

            return ListView.builder(
              itemCount: controller.categoryList.length,
              itemBuilder: (_, i) {
                // Category category = Category(
                //   name: "Vegetables",
                //   imageUrl:
                //       "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg",
                //   subCategory: [
                //     SubCategory(name: "Dark Green"),
                //     SubCategory(name: "Legumes"),
                //     SubCategory(name: "Starchv"),
                //     SubCategory(name: "Other"),
                //   ],
                //   updateDate: DateTime.now(),
                // );
                Category category = controller.categoryList[i];
                return CategoryListTile(
                  category: category,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/addCategory");
          },
          child: Icon(Icons.add),
          backgroundColor: Pallete.primaryCol,
          tooltip: "Add New Category"),
    );
  }
}

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({Key? key, required this.category}) : super(key: key);
  final Category category;

  String subCategoryDesc(List<SubCategory> subCat) {
    String result = "";
    for (var e in subCat) {
      result = result + "${e.name} ,";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return Slidable(
        key: key,
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              label: 'Edit',
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              onPressed: (_) {
                Get.toNamed("/editCategory/${category.id}");
              },
            ),
            SlidableAction(
              label: 'Delete',
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (_) {
                Get.find<CategoryController>().deleteCategory(category.id!);
              },
            ),
          ],
        ),
        child: ListTile(
          isThreeLine: true,
          leading: CachedNetworkImage(
            imageUrl: category.imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          title: Text(
            category.name,
            maxLines: 2,
          ),
          subtitle: Text(
            subCategoryDesc(category.subCategory),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    });
  }
}
