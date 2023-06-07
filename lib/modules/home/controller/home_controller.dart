import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController{
  RxString userEmail = "".obs;
  RxString userName = "".obs;
  RxString userProfile = "".obs;
  RxString userId = "".obs;
  RxBool isLoading=false.obs;
  @override
  void onInit() {
    super.onInit();
    getDataFromSharePreference();
  }
  getDataFromSharePreference(){
    userEmail.value= AppPreference.getString(Constant.userEmailKey);
    userName.value= AppPreference.getString(Constant.userNameKey);
    userProfile.value= AppPreference.getString(Constant.userProfileUrlKey);
    userId.value= AppPreference.getString(Constant.userIdKey);
  }

  signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    // await FirebaseAuth.instance.signOut();
  }
}