import 'dart:developer';

import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<DbUser> dbUser = Rx<DbUser>(
    DbUser(
        name: "Ai Mart",
        username: "aimart11",
        number: null,
        profilePhoto: "",
        email: "aimart11@gmail.com",
        shippingAddresses: []),
  );

  getDbUser(String username) async {
    dbUser.bindStream(FirebaseService.streamDbUserById(username));
    // dbUser.value = await FirebaseService.getDbUserById(username);
    log("DbUser: ${dbUser.value.name}");
    update();
  }

  @override
  void onInit() {
    String username =
        Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);

    getDbUser(username);
    super.onInit();
  }

  Future<void> addShippingAddress(String newAddress)async {
    List<String> newShippingAdressList = [];
    newShippingAdressList.addAll(dbUser.value.shippingAddresses);
    newShippingAdressList.add(newAddress);
    DbUser upDbUser = DbUser(
      id: dbUser.value.id,
      name: dbUser.value.name,
      username: dbUser.value.username,
      profilePhoto: dbUser.value.profilePhoto,
      email: dbUser.value.email,
      shippingAddresses: newShippingAdressList,
    );
    await FirebaseService.updateProfile(upDbUser);
  }
}
