import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: GetX<OrderController>(
        builder: (controller) {
          if (controller.orderList.isEmpty) {
            return Center(
              child: Text("Your order is empty"),
            );
          }
          return ListView.builder(
            itemCount: controller.orderList.length,
            itemBuilder: (_, i) {
              Order order = controller.orderList[i];
              return ListTile(
                onTap: () {
                  Get.defaultDialog(
                    title: "#${order.id!}",
                    backgroundColor: Pallete.getOrderColor(order.orderState),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text(
                            "Total Amount - \$${order.totalAmount.toStringAsFixed(2)}",
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text(
                            "Status - ${order.orderState}",
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text(
                            "Order Items",
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: order.orderedItems.map(
                              (orderItem) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  padding: EdgeInsets.only(
                                      left: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      orderItem.imageUrl,
                                    ),
                                  )),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      orderItem.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          child: Text(
                            "Order Date - ${Utils.getDate(order.orderDate)}",
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  );
                },
                leading: CircleAvatar(
                  // backgroundColor: Pallete.getOrderColor(order.orderState),
                  child: Icon(
                    Pallete.getOrderIcon(order.orderState),
                    color: Colors.white,
                  ),
                ),
                title: Text("#${order.id}"),
                subtitle: Text("Your order is ${order.orderState} \nTotal amount is \$${order.totalAmount.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
    );
  }
}
