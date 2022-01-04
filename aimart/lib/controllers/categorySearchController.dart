import 'package:get/get.dart';

class CategorySearchController extends GetxController {

  var query = "".obs;

  var selectedSubCatName = "".obs;

  void setQuery(String val){
    query.value = val;
    update();
  }
  
  void setSubCatName(String catName){
    selectedSubCatName.value = catName;
    update();
  }


}
