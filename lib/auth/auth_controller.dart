import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      String userEmail=user?.email??"";
      String userName=user?.displayName??"";
      String userProfile=user?.photoURL??"";

      if (result != null) {
        Get.snackbar("successful", "login");
        AppPreference.setString(Constant.userEmailKey, userEmail);
        AppPreference.setString(Constant.userNameKey, userName);
        AppPreference.setString(Constant.userProfileUrlKey, userProfile);
        Get.snackbar(Constant.userEmailKey, userEmail);
        print("UserEmail-------------->${userEmail}");
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
}