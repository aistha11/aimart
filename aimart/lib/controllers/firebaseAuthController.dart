import 'dart:developer';

import 'package:aimart/config/config.dart';
import 'package:aimart/controllers/controllers.dart';
import 'package:aimart/models/models.dart';
import 'package:aimart/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Rx<User?>? _firebaseUser;

  final Rx<Status> _status = Rx<Status>(Status.UNINITIALIZED);

  Status get status => _status.value;

  User? get user => _auth.currentUser; 

  @override
  void onInit() {
    _firebaseUser?.bindStream(_auth.authStateChanges());

    log(" Auth Change :   ${_auth.currentUser}");

    if (_auth.currentUser == null) {
      log("User is not logged in");
      _status.value = Status.UNAUTHENTICATED;
      update();
    } else {
      log("User is logged in");
      _status.value = Status.AUTHENTICATED;
      update();
    }
    super.onInit();
  }

  // function to createuser, login and sign out user
  Future<void> signUp(String name, String email, String password) async {
    try {
      _status.value = Status.AUTHENTICATING;
      update();
      String username = email.split('@')[0];
      log(
          "Sign Up with:{username:$username,name:$name,email:$email,password:$password}");
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential uCreds) async {
          DbUser dbuser = DbUser(
            id: uCreds.user!.uid,
            name: name,
            profilePhoto: "",
            email: uCreds.user!.email.toString(),
            username: username,
            shippingAddresses: []
          );
          await FirebaseService.createDbUserById(dbuser);
          signIn(email, password);
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
      update();
    } catch (e) {
      Get.snackbar("Error!!!", e.toString());
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _status.value = Status.AUTHENTICATING;
      update();
      log("Sign In with:{email:$email,password:$password}");
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential uCreds) {
          log(uCreds.toString());
          _status.value = Status.AUTHENTICATED;
          update();
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
      update();
    } catch (e) {
      Get.snackbar("Error!!!", e.toString());
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }

  void sendPasswordResetEmail(String email) async {
    if (email == "") {
      Get.snackbar("Email is empty",
          "Please enter the email address you've used to register with us and we'll send you a reset link!");
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        Get.offAllNamed("/");
        Get.snackbar("Password Reset email link is been sent", "Success");
      }).catchError((onError) {
        Get.snackbar("Error In Email Reset", onError.message);
      });
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
    } catch (e) {
      Get.snackbar("Error!!!", e.toString());
    }
  }

  


  // For Android
  Future<void> loginGoogle() async {
    try {
      // Changing the status to authenticating
      _status.value = Status.AUTHENTICATING;
      update();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (uCreds) async{
          
          DbUser dbuser = DbUser(
            id: uCreds.user!.uid,
            name: uCreds.user!.displayName.toString(),
            profilePhoto: uCreds.user!.photoURL.toString(),
            email: uCreds.user!.email.toString(),
            username: uCreds.user!.email!.split('@')[0],
            shippingAddresses: []
          );
          await FirebaseService.createDbUserById(dbuser);
          _status.value = Status.AUTHENTICATED;
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
      update();
    } on PlatformException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
      update();
    } catch (e) {
      log(e.toString());
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
      googleSignIn.signOut();
      _status.value = Status.UNAUTHENTICATED;
      update();
      Get.delete<ProfileController>(force: true);
      Get.delete<CartController>(force: true);
      Get.delete<OrderController>(force: true);
      return Future.delayed(Duration.zero);
    } catch (e) {
      log(e.toString());
      _status.value = Status.AUTHENTICATED;
      update();
    }
  }

  void showSnackMessage(String code) {
    switch (code) {
      case "account-exists-with-different-credential":
        Get.snackbar(
            "Sorry!!!", "Already exists an account with the email address");
        break;
      case "invalid-credential":
        Get.snackbar("Sorry!!!", "Your credential is malformed or has expired");
        break;
      case "operation-not-allowed":
        Get.snackbar("Sorry its not you!!!", "Google sign In is not enabled");
        break;
      case "email-already-in-use":
        Get.snackbar("Sorry!!!", "The email provided is already exists");
        break;
      case "invalid-email":
        Get.snackbar("Sorry!!!", "Your email is invalid");
        break;
      case "weak-password":
        Get.snackbar("Sorry!!!", "Your password is too weak");
        break;
      case "user-disabled":
        Get.snackbar("Sorry!!!", "Your account has been disabled");
        break;
      case "user-not-found":
        Get.snackbar("Sorry!!!", "Your account cannot be found");
        break;
      case "wrong-password":
        Get.snackbar("Sorry!!!", "Your provided password is invalid");
        break;
      case "invalid-verification-code":
        Get.snackbar("Sorry!!!", "Your verification code is invalid");
        break;
      case "invalid-verification-id":
        Get.snackbar("Sorry!!!", "Your verification id is invalid");
        break;
      default:
        Get.snackbar("Sorry!!!", "Something went wrong. Try again");
    }
  }
}
