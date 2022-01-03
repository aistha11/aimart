
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'editProfile_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  // final DbUser dpUser = DbUser(
  //   name: "Bijay Shrestha",
  //   username: "bijayshrestha840",
  //   profilePhoto:
  //       "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg",
  //   email: "bijayshrestha840@gmail.com",
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: GetX<ProfileController>(builder: (controller) {
          DbUser dpUser = controller.dbUser.value;
          return Stack(
            children: <Widget>[
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // Container(
                        //   padding: EdgeInsets.all(16.0),
                        //   margin: EdgeInsets.only(top: 16.0),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(5.0)),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Container(
                        //         margin: EdgeInsets.only(left: 96.0),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: <Widget>[
                        //             Text(
                        //               "${dpUser.name}",
                        //             ),
                        //             ListTile(
                        //               contentPadding: EdgeInsets.all(0),
                        //               title: Text("Product Designer"),
                        //               subtitle: Text("Kathmandu"),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(height: 10.0),
                        //       Row(
                        //         children: <Widget>[
                        //           Expanded(
                        //             child: Column(
                        //               children: <Widget>[
                        //                 Text("285"),
                        //                 Text("Likes")
                        //               ],
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Column(
                        //               children: <Widget>[
                        //                 Text("3025"),
                        //                 Text("Comments")
                        //               ],
                        //             ),
                        //           ),
                        //           Expanded(
                        //             child: Column(
                        //               children: <Widget>[
                        //                 Text("650"),
                        //                 Text("Favourites")
                        //               ],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(dpUser.profilePhoto),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("User information"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Email"),
                            subtitle: Text(dpUser.email),
                            leading: Icon(Icons.email),
                          ),
                          ListTile(
                            title: Text("Number"),
                            subtitle: dpUser.number == null
                                ? Text("Not Available")
                                : Text("+977-${dpUser.number}"),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Username"),
                            subtitle: Text(dpUser.username),
                            leading: Icon(Icons.verified_user_rounded),
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => EditProfileView());
                      },
                      icon: Icon(Icons.edit))
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
