import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxString userEmail="".obs;
  RxString userName="".obs;
  RxString userProfile="".obs;

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
       userEmail.value=user?.email??"";
       userName.value=user?.displayName??"";
       userProfile.value=user?.photoURL??"";

      if (result != null) {
        Get.snackbar("successful", "login");
        AppPreference.setString(Constant.userEmailKey, userEmail.value);
        AppPreference.setString(Constant.userNameKey, userName.value);
        AppPreference.setString(Constant.userProfileUrlKey, userProfile.value);
        Get.snackbar(Constant.userEmailKey, userEmail.value);
        print("UserEmail-------------->${userEmail}");
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  uploadOnFirebase()async{
    await FirebaseFirestore.instance.collection("UserData").add({
      "userName":userName.value,
      "userEmail":userEmail.value,
      "userProfileUrl":userProfile.value,
    }).then((value) async {
      await FirebaseFirestore.instance.collection("UserData").get().then((value){
        
      });
    });
  }
}