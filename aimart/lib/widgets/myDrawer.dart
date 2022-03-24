import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/utilities/utilities.dart';
import 'package:aimart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                DrawerProfile(),
                SizedBox(
                  height: 20,
                ),
                Utils.getDivider(),
                SizedBox(
                  height: 5,
                ),
                DrawerListTile(
                  svgImage: "assets/images/contact-us.svg",
                  title: "Contact Us",
                  route: "/contact",
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 18,
                    child: SvgPicture.asset(
                      "assets/images/sign-out.svg",
                      alignment: Alignment.center,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    'SignOut',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Get.find<FirebaseAuthController>().signOut();
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/appLogo.png",
                    width: 200,
                    height: 140,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerProfile extends StatelessWidget {
  const DrawerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      builder: (controller) {
        DbUser user = controller.dbUser.value;
        return Row(
          children: [
            UserAvatar(profileUrl: user.profilePhoto, name: user.name),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  child: Text(
                    user.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
