import 'dart:developer';

import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final SearchController searchController = Get.find<SearchController>();
  final ProductController productController = Get.find<ProductController>();

  SearchView({Key? key}) : super(key: key);

  buildSuggestionsByQuery(String query, String catId) {
    var suggestionList = productController.productList.isNotEmpty
        ? productController.productList.where((Product product) {
            var matchedName =
                product.name.toLowerCase().contains(query.toLowerCase())
                    ? true
                    : false;
            var matchedCatId = product.categoryId == catId ? true : false;
            log(
                "$matchedName = ${product.name.toLowerCase()} == ${query.toLowerCase()}");
            log("$matchedCatId = ${product.categoryId} == $catId");
            if (query.isEmpty && catId.isEmpty) {
              return true;
            } else if (query.isEmpty && catId.isNotEmpty) {
              return matchedCatId;
            } else if (query.isNotEmpty && catId.isEmpty) {
              return matchedName;
            } else {
              if (matchedName) {
                if (!matchedCatId) return false;
              }
              if (matchedCatId) {
                return matchedName;
              }
              return (matchedName || matchedCatId);
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
            height: 5.0,
          );
        },
        itemCount: suggestionList.length < 10 ?suggestionList.length : 10,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(color: Pallete.primaryCol),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Icon(
                    Icons.search,
                    size: 30.0,
                    color: Pallete.primaryCol,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: PopupMenuButton<String>(
                    itemBuilder: (context) {
                      return Get.find<CategoryController>()
                          .categoryList
                          .value
                          .map((e) {
                        return PopupMenuItem(
                          child: Text(e.name),
                          value: e.id,
                        );
                      }).toList();
                    },
                    onSelected: (val) {
                      var catName =
                          Get.find<CategoryController>().getCategoryName(val);
                      searchController.setCatId(val);
                      searchController.setCatName(catName);
                    },
                    icon: Icon(
                      Icons.filter_list,
                      size: 30.0,
                      color: Pallete.primaryCol,
                    ),
                  ),
                ),
                hintText: "Enter here",
                hintStyle: TextStyle(color: Pallete.inputFillColor),
              ),
              onChanged: (val) {
                searchController.setQuery(val);
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Obx(
            () => searchController.selectedCatName.value != ""
                ? Chip(
                    label: Text(searchController.selectedCatName.value),
                    onDeleted: () {
                      searchController.setCatId("");
                      searchController.setCatName("");
                    },
                    deleteIcon: Icon(Icons.remove_circle_outline),
                  )
                : Container(),
          ),
          SizedBox(
            height: 25,
          ),
          //Suggestions
          GetX<SearchController>(builder: (controller) {
            return buildSuggestionsByQuery(
                controller.query.value, controller.catId.value);
          }),
        ],
      ),
    );
  }
}
