import 'package:get/get.dart';
import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:aimart_dash/utilities/utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {

  final Rx<List<Contact>> _contactsList = Rx<List<Contact>>([]);


  List<Contact> get contactsList => _contactsList.value;

  @override
  void onInit() {
    
    _contactsList.bindStream(FirebaseService.getAllContacts());
    super.onInit();
  }

  Future<void> deleteContact(Contact contact) async {
    await FirebaseService.deleteContact(contact);
  }

  Future<void> callUser(String url) async {
   try{
     if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not make a call';
    }
   }catch(e){
     Utils.showSnackBar("Sorry", e.toString());
   }
  }
  Future<void> mailUser(String url) async {
   try{
     if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not mail';
    }
   }catch(e){
     Utils.showSnackBar("Sorry", e.toString());
   }
  }

  
}