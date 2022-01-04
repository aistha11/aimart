import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleCategory extends StatelessWidget {
  final String catId = Get.parameters["catId"]!;
  final TextEditingController _searchController = TextEditingController();
  final CategorySearchController searchController =
      Get.find<CategorySearchController>();
  final ProductController productController = Get.find<ProductController>();

   SingleCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    final String imageUrl =
        Get.find<CategoryController>().getCategoryImageUrl(catId);

    buildSuggestionsByQuery(String query, String subCatName) {
      var suggestionList = productController.getProductByCatId(catId).isNotEmpty
          ? productController
              .getProductByCatId(catId)
              .where((Product product) {
              var matchedName = query.isEmpty
                  ? false
                  : product.name.toLowerCase().contains(query.toLowerCase())
                      ? true
                      : false;
              var matchedSubCat = subCatName.isEmpty
                  ? false
                  : product.subCategory == subCatName
                      ? true
                      : false;

              if (query.isEmpty && subCatName.isEmpty) {
                return true;
              } else if (query.isEmpty && subCatName.isNotEmpty) {
                return matchedSubCat;
              } else if (query.isNotEmpty && subCatName.isEmpty) {
                return matchedName;
              } else {
                if (matchedName) {
                  if (!matchedSubCat) return false;
                }
                if (matchedSubCat) {
                  return matchedName;
                }
                return (matchedName || matchedSubCat);
              }
            }).toList()
          : [];
      if (suggestionList.isEmpty) {
        if (query.isNotEmpty) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      }
      return Flexible(
        child: ListView.separated(
          separatorBuilder: (_, i) {
            return SizedBox(
              height: 10.0,
            );
          },
          itemCount: suggestionList.length,
          itemBuilder: (_, i) {
            Product searchedProduct = suggestionList[i];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleCatCard(
                productId: searchedProduct.id!,
                name: searchedProduct.name,
                price: searchedProduct.price.toString(),
                category: Get.find<CategoryController>()
                    .getCategoryName(searchedProduct.categoryId),
                imgUrl: searchedProduct.imageUrl,
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          image: DecorationImage(
            // image: NetworkImage(imageUrl),
            image: CachedNetworkImageProvider(
              imageUrl,
            ),
            fit: BoxFit.contain,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      borderSide: BorderSide(color: Pallete.primaryCol),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.search,
                        size: 30.0,
                        color: Pallete.primaryCol,
                      ),
                    ),
                    hintText: "What are you looking for?",
                    hintStyle: TextStyle(color: Pallete.backgroundColor),
                  ),
                  onChanged: (val) {
                    searchController.setQuery(val);
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Get.find<CategoryController>().getSubCategory(catId).isNotEmpty
                  ? SizedBox(
                    height: 50,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: Get.find<CategoryController>()
                            .getSubCategory(catId)
                            .map((e) {
                          return e.name.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: GetX<CategorySearchController>(
                                    builder: (controller) {
                                      return FilterChip(
                                        label: Text(e.name),
                                        onSelected: (val) {
                                          controller.setSubCatName(e.name);
                                        },
                                        selected:
                                            controller.selectedSubCatName.value ==
                                                e.name,
                                        selectedColor: Pallete.primaryCol,
                                      );
                                    },
                                  ),
                                )
                              : Container();
                        }).toList(),
                      ),
                  )
                  : Container(),
              SizedBox(
                height: 25,
              ),
              //Suggestions
              GetX<CategorySearchController>(builder: (controller) {
                return buildSuggestionsByQuery(controller.query.value,
                    controller.selectedSubCatName.value);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
