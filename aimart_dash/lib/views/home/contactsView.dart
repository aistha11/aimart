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
          if(controller.contactsList.isEmpty){
            return Center(child: Text("No Contacts"),);
          }
          return ListView.builder(
            itemCount: controller.contactsList.length,
            itemBuilder: (_, i) {
              Contact contact = controller.contactsList[i];
              return Slidable(
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    onPressed: (_) async {
                      await controller.deleteContact(contact);
                    },
                  ),
                  ],
                ),
              
                endActionPane: ActionPane(motion: ScrollMotion(), children: [
                  SlidableAction(
                    label: "Call",
                    icon: Icons.call,
                    backgroundColor: Colors.blue,
                    onPressed: (_) {
                      final Uri phoneLaunchUri = Uri(
                        scheme: 'tel',
                        path: "${contact.number}",
                      );
                      controller.callUser(phoneLaunchUri.toString());
                    },
                  ),
                  SlidableAction(
                    label: "Email",
                    icon: Icons.email,
                    backgroundColor: Colors.green,
                    onPressed: (_) {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: contact.email,
                      );
                      controller.mailUser(emailLaunchUri.toString());
                    },
                  ),
                ]),
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
