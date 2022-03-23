import 'package:aimart/services/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key,required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Preview"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async{
              await ImageDownloader.downloadImage(imageUrl);
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover,height: double.infinity,width: double.infinity,),
    );
  }
}