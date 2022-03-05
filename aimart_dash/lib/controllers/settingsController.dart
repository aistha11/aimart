import 'package:aimart_dash/services/services.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {

  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    isDarkMode.value = ThemeService().isDarkMode; 
    print("DarkMode: ${isDarkMode.value}");
    super.onInit();
  }

  toggleThemeMode(bool val){
    isDarkMode.value = val;
    print("DarkMode: ${isDarkMode.value}");
    update();
  }
}