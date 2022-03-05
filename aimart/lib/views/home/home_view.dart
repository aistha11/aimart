import 'package:aimart/bindings/bindings.dart';
import 'package:aimart/config/config.dart';
import 'package:aimart/config/pallete.dart';
import 'package:aimart/constants/constants.dart';
import 'package:aimart/controllers/controllers.dart';
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
                  // child: Icon(
                  //   FontAwesomeIcons.facebookMessenger,
                  //   color: Colors.blueAccent,
                  //   size: height * 0.04,
                  // ),
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
                  child: Column(
                    // direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      GetX<CategoryController>(builder: (controller) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          height: height * 0.15,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.categoryList.value.map((e) {
                              return CategoryWidget(
                                catId: e.id!,
                                catName: e.name,
                                imageUrl: e.imageUrl,
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      GetX<ProductController>(builder: (controller) {
                        return controller.featuredProducts.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, bottom: 15.0),
                                    child: Text(
                                      "Featured Products",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    height: height * 0.3,
                                    // child: ListView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   children:
                                    //       controller.featuredBusiness.map((e) {
                                    //     return Popular(
                                    //       id: e.id,
                                    //       listingName: e.name,
                                    //       address: e.address,
                                    //       imageUrl: e.caroBusinessImgs[0].imgUrl,
                                    //     );
                                    //   }).toList(),
                                    // ),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.featuredProducts.length,
                                      itemBuilder: (context, i) {
                                        var e = controller.featuredProducts[i];
                                        return ProductCard(
                                          id: e.id!,
                                          listingName: e.name,
                                          price: e.price.toString(),
                                          imageUrl: e.imageUrl,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                      }),
                      GetX<ProductController>(
                        builder: (controller) {
                          return controller.productList.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 15.0),
                                      child: Text(
                                        "New Products",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 10.0),
                                      height: Get.height * 0.3,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children:
                                            controller.latestProducts.map((e) {
                                          return ProductCard(
                                            id: e.id!,
                                            listingName: e.name,
                                            price: e.price.toString(),
                                            imageUrl: e.imageUrl,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                        },
                      ),
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
}
