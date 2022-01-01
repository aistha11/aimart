import 'package:aimart_dash/models/category.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditCategoryController extends GetxController {
  var categoryId = "".obs;

  late Category editCategory;

  var name = TextEditingController().obs;

  RxList<String> subCategoryList = RxList([]);

  var subCategory = TextEditingController(text: "").obs;

  var categoryFormKey = GlobalKey<FormState>().obs;

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]);

  var imageUrl = "".obs;

  final picker = ImagePicker();

  var uploading = false.obs;
  var submitting = false.obs;
  var progressVal = 0.0.obs;

  @override
  void onInit() async {
    categoryId.value = Get.parameters['id']!;
    final Category? category =
        await FirebaseService.getCategoryById(categoryId.value);
    editCategory = category!;

    name.value.text = category.name;
    subCategoryList.addAll(category.subCategory.map((e) => e.name));
    imageUrl.value = category.imageUrl;
    update();
    
    super.onInit();
  }

  addSubCategory() {
    if (subCategory.value.text.isEmpty) {
      return;
    }
    subCategoryList.add(subCategory.value.text);
    subCategory.value.text = "";
    update();
  }

  removeSubCategory(String e) {
    subCategoryList.remove(e);
    update();
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

  removeExistingImage() {
    imageUrl.value = "";
    update();
  }

  removeImage(PickedFile file) {
    pickedImages.value.remove(file);
    update();
  }

  Future uploadFile() async {
    uploading.value = true;
    update();

    PickedFile img = pickedImages.value[0];

    imageUrl.value =
        await ImageUploader.uploadImage(img.path, "category_images");

    uploading.value = false;
    update();
  }

  Future<void> updateCategoryToDb() async {
    // Check whether there is any updates of not
    if (editCategory ==
        Category(
          id: categoryId.value,
          name: name.value.text,
          imageUrl: imageUrl.value,
          subCategory:
              subCategoryList.map((e) => SubCategory(name: e)).toList(),
          updateDate: DateTime.now(),
        )) {
      Get.snackbar("Oops!!", "There is no any updates");
      return;
    }

    // Check the internet connectivity
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
      return;
    }

    // Check the form state is validate of not
    if (categoryFormKey.value.currentState!.validate()) {
      // Lets Submit
      submitting.value = true;
      update();
      
      if (pickedImages.value.isNotEmpty) {
        uploading.value = true;
        update();
        await uploadFile();
        uploading.value = false;
        update();
      }

      // Check if there is a image of category or not
      if (imageUrl.value.isEmpty) {
        Get.snackbar("Sorry!!", "There is no image");
        return;
      }

      Category category = Category(
        id: categoryId.value,
          name: name.value.text,
          imageUrl: imageUrl.value,
          subCategory:
              subCategoryList.map((e) => SubCategory(name: e)).toList(),
          updateDate: DateTime.now());

      FirebaseService.updateCategory(category).then(
        (value) {
          Get.snackbar(
            "Successfull!!",
            "Your Category is Updated",
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
      onClear();
    }
    submitting.value = false;
    update();
  }

  deleteCategory(String id) {
    FirebaseService.deleteCategory(id);
    update();
  }

  void onClear() {
    name.value.text = "";
    subCategoryList.value = [];
    imageUrl.value = "";
    pickedImages.value = [];
    progressVal.value = 0.0;
  }
}
