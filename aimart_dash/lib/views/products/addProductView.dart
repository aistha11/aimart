import 'dart:io';

import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Add Product'),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.15,
            width: Get.width,
            decoration: BoxDecoration(
              color: Pallete.primaryCol,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Pallete.secondaryCol,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Add new product",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GetBuilder<ProductController>(builder: (controller) {
                        return Form(
                          key: controller.productFormKey.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Title can't be empty.";
                                  }
                                  return null;
                                },
                                controller: controller.title.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  labelText: "Title",
                                ),
                                onFieldSubmitted: (val) {
                                  controller.title.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                maxLines: 3,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Description can't be empty.";
                                  }
                                  return null;
                                },
                                controller: controller.description.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  labelText: "Short Description",
                                ),
                                onFieldSubmitted: (val) {
                                  controller.description.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Enter price in USD",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Basic Price can't be empty.";
                                  }
                                  return null;
                                },
                                controller: controller.basicPrice.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    labelText: "Basic Price"),
                                onFieldSubmitted: (val) {
                                  controller.basicPrice.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Standard Price can't be empty.";
                                  }
                                  return null;
                                },
                                controller: controller.standardPrice.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    labelText: "Standard Price"),
                                onFieldSubmitted: (val) {
                                  controller.standardPrice.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Premium Price can't be empty.";
                                  }
                                  return null;
                                },
                                controller: controller.premiumPrice.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    labelText: "Premium Price"),
                                onFieldSubmitted: (val) {
                                  controller.premiumPrice.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Upload Images of your product",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              GetBuilder<ProductController>(
                                builder: (controller) {
                                  return !controller.uploading.value
                                      ? ElevatedButton(
                                          onPressed: () {
                                            if (controller.pickedImages.value.isEmpty) {
                                              controller.chooseImage();
                                            } else {
                                              Get.snackbar("Sorry",
                                                  "You can add only one image. Remove existing to select again.");
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              onPrimary: Pallete.primaryCol,
                                              primary: Colors.white,
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(20)),
                                          child:
                                              Icon(Icons.add_a_photo_outlined),
                                        )
                                      : CircularProgressIndicator(
                                          value: controller.progressVal.value,
                                        );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SelectedProductImages(),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: !controller.submitting.value
                                      ? controller.addProductToDb
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      primary: Pallete.primaryCol,
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15)),
                                  child: Text("Submit"),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedProductImages extends StatelessWidget {
  const SelectedProductImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Wrap(
        spacing: 5.0,
        children: controller.pickedImages.value.map((e) {
          return buildImageCont(e);
        }).toList(),
      );
    });
  }

  Widget buildImageCont(PickedFile file) {
    print(file.path);
    return GestureDetector(
      onDoubleTap: () {
        print(file.path);
        Get.find<ProductController>().removeImage(file);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: FileImage(
                File(file.path),
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
