import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:chatapp/util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxString userEmail = "".obs;
  RxString userName = "".obs;
  RxString userProfile = "".obs;
  RxString userId = "".obs;
  RxBool isLoading=false.obs;

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
      userId.value=user?.uid??"";
      await FirebaseFirestore.instance
          .collection(Constant.userDataCollection)
          .where(Constant.userEmailKey, isEqualTo: userEmail.value)
          .get()
          .then((documents) async {
        if (documents.docs.isEmpty) {
          isLoading.value=true;
          await FirebaseFirestore.instance.collection(Constant.userDataCollection).add({
            Constant.userNameKey: userName.value,
            Constant.userEmailKey: userEmail.value,
            Constant.userProfileUrlKey: userProfile.value,
            Constant.userIdKey: userId.value
          }).then(
            (value) async {
              AppPreference.setString(Constant.userEmailKey, userEmail.value);
              AppPreference.setString(Constant.userNameKey, userName.value);
              AppPreference.setString(Constant.userProfileUrlKey, userProfile.value);
              AppPreference.setString(Constant.userIdKey, userId.value);
              AppPreference.setString(Constant.senderIdKey, value.id);
            },
          );
          isLoading.value=false;
          Get.toNamed(Routes.homeScreen);
        } else {
          AppPreference.setString(Constant.userEmailKey, userEmail.value);
          AppPreference.setString(Constant.userNameKey, userName.value);
          AppPreference.setString(Constant.userProfileUrlKey, userProfile.value);
          AppPreference.setString(Constant.userIdKey, userId.value);
          AppPreference.setString(Constant.senderIdKey, documents.docs.first.id);
          Get.toNamed(Routes.homeScreen);
        }
      });
      Get.snackbar(Constant.successful, Constant.login);
      Get.snackbar(Constant.userEmailKey, userEmail.value);
    }
  }

  uploadOnFirebase() async {
    await FirebaseFirestore.instance.collection(Constant.userDataCollection).add({
      Constant.userNameKey: userName.value,
      Constant.userEmailKey: userEmail.value,
      Constant.userProfileUrlKey: userProfile.value,
      Constant.userIdKey: userId.value
    }).then(
      (value) async {
        await FirebaseFirestore.instance.collection(Constant.userDataCollection).get().then(
          (value) {
            saveInSharePreference();
          },
        );
      },
    );
  }

  saveInSharePreference() {
    AppPreference.setString(Constant.userEmailKey, userEmail.value);
    AppPreference.setString(Constant.userNameKey, userName.value);
    AppPreference.setString(Constant.userProfileUrlKey, userProfile.value);
    AppPreference.setString(Constant.userIdKey, userId.value);
    AppPreference.setString(Constant.userIdKey, userId.value);
  }
}
