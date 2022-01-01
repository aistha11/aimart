import 'dart:io';

import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryView extends StatelessWidget {
  const AddCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Add Category'),
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
                        "Add new category",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GetBuilder<CategoryController>(builder: (controller) {
                        return Form(
                          key: controller.categoryFormKey.value,
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
                              Text(
                                "Add sub-category",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Wrap(
                                spacing: 5.0,
                                children: controller.subCategoryList
                                    .map((e) => Chip(
                                          label: Text(e),
                                          onDeleted: () {
                                            controller.removeSubCategory(e);
                                          },
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: controller.subCategory.value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  labelText: "Sub Category",
                                  suffix: InkWell(
                                    onTap: () {
                                      controller.addSubCategory();
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                              Text(
                                "Upload Images of your category",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              GetBuilder<CategoryController>(
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
                              SelectedCategoryImages(),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: !controller.submitting.value
                                      ? controller.addCategoryToDb
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

class SelectedCategoryImages extends StatelessWidget {
  const SelectedCategoryImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
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
        Get.find<CategoryController>().removeImage(file);
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
