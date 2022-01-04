import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {

 final Rx<List<Category>> categoryList = Rx<List<Category>>([]);

//  final Rx<List<SubCategory>> subCategoryList = Rx<List<SubCategory>>([]);

 List<Category> get categories => categoryList.value;

//  List<SubCategory> get subCategories => subCategoryList.value;




 @override
 void onInit(){
   categoryList.bindStream(FirebaseService.getCategories());
   super.onInit();
 }


 getCategoryName(String id){
   var cat = categoryList.value.where((e){
     return e.id == id ? true : false;
   }).toList();
   return cat[0].name;
 }
 getCategoryImageUrl(String catId){
   var cat = categoryList.value.where((e){
     return e.id == catId ? true : false;
   }).toList();
   return cat[0].imageUrl;
 }

 List<SubCategory> getSubCategory(String catId){
   var catList = categoryList.value.where((e){
     return e.id == catId;
   }).toList();
   return catList[0].subCategory;
 }

  
}
