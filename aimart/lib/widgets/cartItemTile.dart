import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;

  const CartItemTile({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        height: 135,
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: CachedNetworkImageProvider(cartItem.imageUrl),
                fit: BoxFit.cover,
              )),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            cartItem.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: IconButton(
                            onPressed: () async {
                              await Get.find<CartController>()
                                  .deleteCartItem(cartItem.id!);
                            },
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            iconSize: 20,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Price: "),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                              cartItem.price.toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                         
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Sub Total: "),
                        SizedBox(
                          width: 5,
                        ),
                         Text(
                            cartItem.price.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.orange,
                            ),
                          )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          cartItem.plan,
                          style: TextStyle(color: Colors.orange),
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                await Get.find<CartController>()
                                    .decrementCartItem(cartItem);
                              },
                              splashColor: Colors.redAccent.shade200,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${cartItem.quantity}'),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: () async {
                                await Get.find<CartController>()
                                    .incrementCartItem(cartItem);
                              },
                              splashColor: Colors.lightBlue,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}