import 'package:aimart/bindings/bindings.dart';
import 'package:aimart/config/config.dart';
import 'package:aimart/config/pallete.dart';
import 'package:aimart/constants/constants.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/routes/app_pages.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:aimart/views/views.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Get.height * 1;
    double width = Get.width * 1;

    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        drawer: MyDrawer(),
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              titleSpacing: -2,
              backgroundColor: Pallete.backgroundColor,
              leading: IconButton(
                iconSize: height * 0.05,
                icon: Icon(
                  Icons.sort,
                  color: Pallete.inputFillColor,
                ),
                onPressed: () {
                  controller.openDrawer();
                },
              ),
              title: GestureDetector(
                onTap: () {
                  navController.onPageChange(1);
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Pallete.backgroundColor.withAlpha(20),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(1, 3),
                      ),
                    ],
                    color: Pallete.inputFillColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 23.0,
                              color: Pallete.primaryCol,
                            ),
                            Text(
                              "What are you looking for?",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                InkWell(
                  child: SVGCircle(svgImage: "assets/images/chat.svg"),
                  onTap: () {
                    String email =
                        Get.find<FirebaseAuthController>().user!.email!;
                    String username = Utils.getUsername(email);
                    Get.to(() => ChatMessageView(),
                        binding: ChatsBinding(), arguments: {'id': username});
                  },
                ),
                SizedBox(width: 15),
              ],
              // pinned: true,
              // floating: true,
              snap: false,
              // expandedHeight: 250,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Padding(
              //     padding: const EdgeInsets.only(top: 90.0),
              //     child: CaroSlider(),
              //   ),
              // ),
            ),
            SliverFillRemaining(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                color: Pallete.backgroundColor,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      buildCategories(),
                      buildFeatured(),
                      buildLatestProduct(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategories() {
    return GetX<CategoryController>(
      builder: (controller) {
        var totalCategoryCount = controller.categoryList.value.length;
        var showingCount = totalCategoryCount > 10 ? 10 : totalCategoryCount;
        return HoriScrollCard(
          color: Color.fromARGB(255, 211, 211, 211),
          title: "Categories",
          showingCount: showingCount,
          totalCategoryCount: totalCategoryCount,
          child: Container(
            margin: EdgeInsets.all(10),
            height: Get.height * 0.15,
            child: ListView.builder(
              itemCount: showingCount,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                return CategoryWidget(category: controller.categories[i]);
              },
            ),
          ),
          buttonName: "View More",
          onPressed: () {
            Get.toNamed(Routes.CATEGORIES);
          },
        );
      },
    );
  }

  Widget buildFeatured() {
    return GetX<ProductController>(
      builder: (controller) {
        var totalCategoryCount = controller.featuredProducts.length;
        var showingCount = totalCategoryCount > 10 ? 10 : totalCategoryCount;
        return HoriScrollCard(
          color: Color.fromARGB(255, 211, 211, 211),
          title: "Featured",
          showingCount: showingCount,
          totalCategoryCount: totalCategoryCount,
          child: Container(
            margin: EdgeInsets.all(10),
            height: Get.height * 0.34,
            child: ListView.builder(
              itemCount: showingCount,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                return ProductCard(
                  product: controller.featuredProducts[i],
                );
              },
            ),
          ),
          buttonName: "View More",
          onPressed: () {},
        );
      },
    );
  }

  Widget buildLatestProduct() {
    return GetX<ProductController>(
      builder: (controller) {
        var totalCategoryCount = controller.latestProducts.length;
        var showingCount = totalCategoryCount > 10 ? 10 : totalCategoryCount;
        return HoriScrollCard(
          color: Color.fromARGB(255, 211, 211, 211),
          title: "New Products",
          showingCount: showingCount,
          totalCategoryCount: totalCategoryCount,
          child: Container(
            margin: EdgeInsets.all(10),
            height: Get.height * 0.34,
            child: ListView.builder(
              itemCount: showingCount,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) {
                return ProductCard(
                  product: controller.latestProducts[i],
                );
              },
            ),
          ),
          buttonName: "View More",
          onPressed: () {},
        );
      },
    );
  }
}
