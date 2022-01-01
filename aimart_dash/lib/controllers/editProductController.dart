import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:aimart_dash/services/services.dart';
import 'package:path/path.dart' as path;

class EditProductController extends GetxController {
  

  var productId = "".obs;
  var name = TextEditingController().obs;
  var description = TextEditingController().obs;
  var price = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var categoryId = "".obs;
  var subCategory = "".obs;
  var featured = false.obs;

  late firebase_storage.Reference ref;

  var productFormKey = GlobalKey<FormState>().obs;

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]); 

  var imageUrl = "".obs;

  final picker = ImagePicker();

  var uploading = false.obs;
  var submitting = false.obs;

  @override
  void onInit()async {
    productId.value = Get.parameters['id']!;
    final Product? product = await FirebaseService.getProductById(productId.value);
    name.value.text = product!.name;
    description.value.text = product.description;
    price.value.text = product.price.toString();
    categoryId.value= product.categoryId;
    discount.value.text = product.discount.toString();
    featured.value = product.featured;
    subCategory.value= product.subCategory;
    imageUrl.value = product.imageUrl;
    update();
    super.onInit();
  }

  chooseImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      pickedImages.value.add(PickedFile(pickedFile!.path));
    } catch (e) {
      Get.snackbar("Ohh😮😮😮😮", "Image not selected😌😌😌😌");
    }

    update();
  }

  removeImageAt(int index) {
    pickedImages.value.removeAt(index);
    update();
  }

  removeImage(PickedFile file) {
    pickedImages.value.remove(file);
    update();
  }

  setCategoryId(String catId) {
    categoryId.value = catId;
    subCategory.value = "";
    update();
  }

   setFeatured(bool val){
    featured.value = val;
    update();
  }

  removeExistingImage(){
    imageUrl.value = "";
    update();
  }

  Future uploadFile() async {
    uploading.value = true;
    update();

    PickedFile img = pickedImages.value[0];

    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('product_images/${path.basename(img.path)}');
    await ref.putFile(File(img.path)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imageUrl.value = value;
      });
    });
    uploading.value = false;
    update();
  }

  Future<void> editProduct() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
    } else {
      if (productFormKey.value.currentState!.validate()) {
        if(pickedImages.value.isNotEmpty){
          uploading.value= true;
          update();
          await uploadFile();
          update();
        }
        submitting.value = true;
        if (imageUrl.value == "") {
          Get.snackbar("Sorry!", "Add at least one image for product.");
        } else {
          Product product = Product(
            id: productId.value,
            name: name.value.text,
            imageUrl: imageUrl.value,
            price: double.parse(price.value.text),
            discount: double.parse(discount.value.text),
            categoryId: categoryId.value,
            subCategory: subCategory.value,
            description: description.value.text,
            featured: featured.value,
            updateDate: DateTime.now()
          );

          FirebaseService.updateProduct(product).then(
            (value) {
              Get.snackbar(
                "Successfull!!",
                "Your Product is Edited",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          );
          onClear();
        }
      }
    }
    submitting.value = false;
    update();
    Get.back();
  }

  deleteProduct(String id) {
    FirebaseService.deleteProduct(id);
    update();
  }

  void onClear() {
    name.value.text = "";
    description.value.text = "";
    imageUrl.value = "";
    discount.value.text = "";
    pickedImages.value = [];
    price.value.text = "";
    categoryId.value = "";
    subCategory.value = "";
  }
}
