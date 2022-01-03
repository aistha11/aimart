import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  //to derive username from email address
  static String getUsername(String email) {
    return email.split('@')[0];
  }

  static showKeyboard(textFieldFocus) => textFieldFocus.requestFocus();

  static hideKeyboard(textFieldFocus) => textFieldFocus.unfocus();

  static double getWidthByPercentage(BuildContext context, double percent) {
    Size size = MediaQuery.of(context).size;
    return (percent / 100) * size.width;
  }

  static double getHeightByPercentage(BuildContext context, double percent) {
    Size size = MediaQuery.of(context).size;
    return (percent / 100) * size.height;
  }

  static String getInitials(String name) {
    if (name != "") {
      List<String> nameSplit = name.split(" ");
      String firstNameInitial = nameSplit[0][0];
      String lastNameInitial = nameSplit[1][0];
      return firstNameInitial + lastNameInitial;
    } else {
      return "NS";
    }
  }

  static String getFirstInitials(String string) {
    List<String> stringSplit = string.split(" ");
    String firstInitials = stringSplit[0];
    return firstInitials;
  }

  static String getExceptionMessage(String string) {
    List<String> stringSplit = string.split(" ");
    stringSplit.removeAt(0);
    String result = "";
    for (var item in stringSplit) {
      result += "$item ";
    }
    return result;
  }

  static int strToInt(String str) {
    return int.parse(str);
  }

  static String getLastName(String name) {
    try {
      List<String> nameSplit = name.split(" ");
      String lastName = nameSplit[1];
      return lastName;
    } catch (e) {
      return "";
    }
  }

  static String getFirstName(String name) {
    try {
      List<String> nameSplit = name.split(" ");
      String firstName = nameSplit[0];
      return firstName;
    } catch (e) {
      return "";
    }
  }

  static String getDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  static Widget getDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      indent: 5,
      endIndent: 5,
    );
  }

  static Widget profileDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Divider(
        color: Colors.grey,
        thickness: 1,
        indent: 15,
        endIndent: 15,
      ),
    );
  }

  static showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.yellow);
  }

  static Future<void> launchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(
          url,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      Utils.showSnackBar("Sorry", e.toString());
    }
  }

  
}