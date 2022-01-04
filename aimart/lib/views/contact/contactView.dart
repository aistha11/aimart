import 'package:aimart/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactView extends GetView<ContactController> {
   const ContactView({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Contact Us'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: Get.height * 0.15,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text(
                        "Please fill up the information",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GetBuilder<ContactController>(
                        builder: (controller) {
                          return Form(
                            key: controller.contactFormKey.value,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: controller.name.value,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "*Name can't be empty.";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      labelText: "Name"),
                                  onFieldSubmitted: (val) {
                                    controller.name.value.text = val;
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: controller.email.value,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "*Email can't be empty.";
                                    } else if (!GetUtils.isEmail(val)) {
                                      return "Please Insert Correct Email Address";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      labelText: "Email"),
                                  onFieldSubmitted: (val) {
                                    controller.email.value.text = val;
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: controller.phone.value,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "*Contact Number can't be empty.";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      labelText: "Contact Number"),
                                  onFieldSubmitted: (val) {
                                    controller.phone.value.text = val;
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  maxLines: 5,
                                  controller: controller.message.value,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "*Message can't be empty.";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      labelText: "Your Message here"),
                                  onFieldSubmitted: (val) {
                                    controller.message.value.text = val;
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            controller.handleContact();
                          },
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15)),
                          child: Text("Submit"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}