import 'package:aimart_dash/controllers/controllers.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ContactController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.contactsList.length,
            itemBuilder: (_, i) {
              Contact contact = controller.contactsList[i];
              return Slidable(
                // actionPane: SlidableStrechActionPane(),
                // actions: [
                //   IconSlideAction(
                //     icon: Icons.delete,
                //     color: Colors.red,
                //     onTap: () async {
                //       await controller.deleteContact(contact);
                //     },
                //   ),
                // ],
                // secondaryActions: [
                //   IconSlideAction(
                //     caption: "Call",
                //     icon: Icons.call,
                //     color: Colors.blue,
                //     onTap: () {
                //       final Uri phoneLaunchUri = Uri(
                //         scheme: 'tel',
                //         path: "${contact.number}",
                //       );
                //       controller.callUser(phoneLaunchUri.toString());
                //     },
                //   ),
                //   IconSlideAction(
                //     caption: "Email",
                //     icon: Icons.email,
                //     color: Colors.green,
                //     onTap: () {
                //       final Uri emailLaunchUri = Uri(
                //         scheme: 'mailto',
                //         path: "${contact.email}",
                //       );
                //       controller.mailUser(emailLaunchUri.toString());
                //     },
                //   ),
                // ],
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(Utils.getInitials(contact.name)),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.message),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
