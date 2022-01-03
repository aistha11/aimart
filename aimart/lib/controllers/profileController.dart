import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<DbUser> dbUser = Rx<DbUser>(
    DbUser(
      name: "No Name",
      username: "nomail",
      number: null,
      profilePhoto: "",
      email: "nomail@gmail.com",
    ),
  );

  getDbUser(String username) async {
    dbUser.bindStream(FirebaseService.streamDbUserById(username));
    // dbUser.value = await FirebaseService.getDbUserById(username);
    print("DbUser: ${dbUser.value.name}");
    update();
  }

  @override
  void onInit() {
    String username =
        Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);

    getDbUser(username);
    super.onInit();
  }
}
