import 'package:get/get.dart';

class SearchController extends GetxController {

  var query = "".obs;

  var catId = "".obs;

  var selectedCatName = "".obs;

  void setQuery(String val){
    query.value = val;
    update();
  }
  void setCatId(String val){
    catId.value = val;
    update();
  }
  void setCatName(String catName){
    selectedCatName.value = catName;
    update();
  }


}
