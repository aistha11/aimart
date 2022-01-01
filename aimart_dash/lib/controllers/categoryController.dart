import 'package:aimart_dash/models/category.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryController extends GetxController {
  final Rx<List<Category>> _categoryList = Rx<List<Category>>([]);

  List<Category> get categoryList => _categoryList.value;

  

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
  void onInit() {
    _categoryList.bindStream(FirebaseService.getCategories());
    super.onInit();
  }

  getCategoryName(String id) {
    var cat = categoryList.where((e) {
      return e.id == id ? true : false;
    }).toList();
    return cat[0].name;
  }

  getCategoryImageUrl(String catId) {
    var cat = categoryList.where((e) {
      return e.id == catId ? true : false;
    }).toList();
    return cat[0].imageUrl;
  }

  List<SubCategory> getSubCategory(String catId) {
    var catList = categoryList.where((e) {
      return e.id == catId;
    }).toList();
    return catList[0].subCategory;
  }

  addSubCategory(){
    if(subCategory.value.text.isEmpty){
      return;
    }
    subCategoryList.add(subCategory.value.text);
    subCategory.value.text = "";
    update();
  }

  removeSubCategory(String e){
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

  Future<void> addCategoryToDb() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
    } else {
      if (categoryFormKey.value.currentState!.validate()) {
        submitting.value = true;
        if (pickedImages.value.isEmpty) {
          Get.snackbar("Sorry!", "Add at least one image for category.");
        } else {
          await uploadFile();
          update();
          Category category = Category(
              name: name.value.text,
              imageUrl: imageUrl.value,
              subCategory:
                  subCategoryList.map((e) => SubCategory(name: e)).toList(),
              updateDate: DateTime.now());

          FirebaseService.createCategory(category).then(
            (value) {
              Get.snackbar(
                "Successfull!!",
                "Your Category is Created",
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
  }

  deleteCategory(String id) {
    FirebaseService.deleteCategory(id);
    update();
  }

  void onClear() {
    name.value.text = "";

    imageUrl.value = "";
    pickedImages.value = [];
    progressVal.value = 0.0;
  }
}
