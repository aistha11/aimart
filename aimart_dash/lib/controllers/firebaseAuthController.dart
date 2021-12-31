import 'package:aimart_dash/config/config.dart';
import 'package:aimart_dash/utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?>? _firebaseUser;

  final Rx<Status> _status = Rx<Status>(Status.UNINITIALIZED);

  Status get status => _status.value;

  // User? get fUser => _firebaseUser!.value;

  User? get user => _auth.currentUser;

  @override
  void onInit() {
    _firebaseUser?.bindStream(_auth.authStateChanges());

    print(" Auth Change :   ${_auth.currentUser}");

    if (_auth.currentUser == null) {
      print("User is not logged in");
      _status.value = Status.UNAUTHENTICATED;

      update();
    } else {
      print("User is logged in");

      _status.value = Status.AUTHENTICATED;
      update();
    }
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    try {
      _status.value = Status.AUTHENTICATING;
      update();
      print("Sign In with:{email:$email,password:$password}");
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential uCreds) {
          print(uCreds);
          _status.value = Status.AUTHENTICATED;
          update();
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          Utils.showSnackBar("Sorry!!", "The provided email is invalid");
          break;
        case "user-disabled":
          Utils.showSnackBar("Sorry!!", "The provided email is disabled");
          break;
        case "user-not-found":
          Utils.showSnackBar("Sorry!!", "The user is not found");
          break;
        case "wrong-password":
          Utils.showSnackBar(
              "Sorry!! Try again", "The provided password is invalid");
          break;
        default:
          Utils.showSnackBar("Sorry!!", "Something went wrong");
          break;
      }

      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }

  // For logout from the app
  Future<void> signOut() async {
    try {
      _auth.signOut();
      _status.value = Status.UNAUTHENTICATED;
      update();
    } catch (e) {
      Utils.showSnackBar("Error!!!", e.toString());
      _status.value = Status.AUTHENTICATED;
      update();
    }
  }
}
