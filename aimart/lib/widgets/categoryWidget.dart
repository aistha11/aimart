import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CategoryWidget extends StatelessWidget {
  final String catId;
  final String catName;
  final String imageUrl;
   const CategoryWidget(
      {Key? key, required this.catName, required this.imageUrl, required this.catId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  //  double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed("/mybusiness");
        Get.toNamed("/category/$catId");
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
                  image: CachedNetworkImageProvider(imageUrl),
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
                      catName,
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
