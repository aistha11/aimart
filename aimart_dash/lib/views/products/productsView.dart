import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ProductController>(builder: (controller) {
        if(controller.productList.isEmpty){
          return Center(child: Text("No products"),);
        }
        return SafeArea(
          child: ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (_, i) {
              Product product = controller.productList[i];
              return ProductListTile(product: product,);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/addProduct");
          },
          child: Icon(Icons.add),
          backgroundColor: Pallete.primaryCol,
          tooltip: "Add New Product"),
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Slidable(
        key: key,
        
        endActionPane: ActionPane(children: [
          SlidableAction(
            label: 'Edit',
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: (_) {
              Get.toNamed("/editProduct/${product.id}");
            },
          ),
          SlidableAction(
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (_) {
              Get.find<ProductController>().deleteProduct(product.id!);
            },
          ),
        ],motion: ScrollMotion(),),
        child: ListTile(
          isThreeLine: true,
          leading: CachedNetworkImage(
            imageUrl: product.imageUrl,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
          title: Text(
            product.name,
            maxLines: 2,
          ),
          subtitle: Text(product.description),
        ),
      );
    });
  }
}
