import 'package:flutter/material.dart';

class CaroSlider extends StatelessWidget {
  const CaroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = Get.height * 1;
    // double width = Get.width * 1;

    return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  color: Colors.grey
                ),
              );

    // return GetX<CaroController>(
    //   builder: (controller) {
    //     if(controller.caroSlide.isEmpty){
    //       return Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(10.0),
    //               ),
    //               color: Colors.grey
    //             ),
    //           );
    //     }
    //     return CarouselSlider(
    //       options: CarouselOptions(
    //         height: height * 0.2,
    //         enlargeCenterPage: true,
    //         autoPlay: true,
    //         aspectRatio: 16 / 9,
    //         autoPlayCurve: Curves.fastOutSlowIn,
    //         enableInfiniteScroll: true,
    //         autoPlayAnimationDuration: Duration(milliseconds: 800),
    //         viewportFraction: 0.8,
    //       ),
    //       items: controller.caroSlide.map(
    //         (caroSlide) {
    //           return Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(10.0),
    //               ),
    //               color: gray,
    //               image: DecorationImage(
    //                 fit: BoxFit.fitWidth,
    //                 image: CachedNetworkImageProvider(caroSlide.imageUrl),
    //               ),
    //             ),
    //           );
    //         },
    //       ).toList(),
    //     );
    //   },
    // );
  }
}

