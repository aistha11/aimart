import 'package:aimart/models/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Get.toNamed("/category/${category.id}");
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                child: Image(
                  height: 70,
                  width: width * 0.43,
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(category.imageUrl),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
