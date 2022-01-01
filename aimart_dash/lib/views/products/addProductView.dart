import 'dart:io';

import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/config/pallete.dart';
import 'package:aimart_dash/constants/dependencies.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/widgets/widgets.dart';
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
                              CustomTFF(
                                controller: controller.name.value,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Name can't be empty.";
                                  }
                                  return null;
                                },
                                labelText: "Name",
                                onFieldSubmitted: (val) {
                                  controller.name.value.text = val;
                                },
                              ),
                              // TextFormField(
                              //   validator: (val) {
                              //     if (val!.isEmpty) {
                              //       return "*Name can't be empty.";
                              //     }
                              //     return null;
                              //   },
                              //   controller: controller.name.value,
                              //   textInputAction: TextInputAction.next,
                              //   keyboardType: TextInputType.text,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(
                              //       borderSide: BorderSide(),
                              //     ),
                              //     labelText: "Name",
                              //   ),
                              //   onFieldSubmitted: (val) {
                              //     controller.name.value.text = val;
                              //   },
                              // ),
                              // SizedBox(
                              //   height: 10.0,
                              // ),
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
                                height: 10,
                              ),

                              DropdownButtonFormField<String>(
                                validator: (String? val) {
                                  if (val == null) {
                                    return "*Please select category";
                                  }
                                  return null;
                                },
                                value: controller.categoryId.value == ""
                                    ? null
                                    : controller.categoryId.value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                ),
                                onChanged: (val) {
                                  controller.setCategoryId(val!);
                                },
                                hint: Text("Select Category"),
                                items: categoryController.categoryList.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.id,
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => controller.categoryId.value != ""
                                    ? DropdownButtonFormField<String>(
                                        validator: (String? val) {
                                          if (val == null) {
                                            return "*Please select sub category";
                                          }
                                          return null;
                                        },
                                        value:
                                            controller.subCategory.value == ""
                                                ? null
                                                : controller.subCategory.value,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                        onChanged: (String? val) {
                                          controller.subCategory.value = val!;
                                        },
                                        hint: Text("Select Sub Category"),
                                        items: categoryController
                                            .getSubCategory(
                                                controller.categoryId.value)
                                            .map((e) {
                                          return DropdownMenuItem(
                                            child: Text(e.name.toString()),
                                            value: e.name.toString(),
                                          );
                                        }).toList(),
                                      )
                                    : Container(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "*Price can't be empty.";
                                  }
                                  // if (val.length != 10)
                                  //   return "*Enter Correct Mobile Number";
                                  return null;
                                },
                                controller: controller.price.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    labelText: "Price"),
                                onFieldSubmitted: (val) {
                                  controller.price.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: controller.discount.value,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                    labelText: "Discount"),
                                onFieldSubmitted: (val) {
                                  controller.discount.value.text = val;
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                              children: [
                                Checkbox(
                                  value: controller.featured.value,
                                  activeColor: Pallete.primaryCol,
                                  onChanged: (val) {
                                    controller.setFeatured(val!);
                                  },
                                ),
                                Text(
                                  "Do you want to featured this?   ",
                                  style: TextStyle(
                                      color: Pallete.inputFillColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                controller.featured.value
                                    ? Text(
                                        "✔",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 20.0),
                                      )
                                    : Text("❌", style: TextStyle(fontSize: 8)),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
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
                                            if (controller
                                                .pickedImages.value.isEmpty) {
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
