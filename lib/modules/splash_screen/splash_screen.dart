import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:chatapp/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      await checkLogin();
    });
  }
    checkLogin(){
    if (AppPreference.getBoolean(Constant.isLoginKey)){
      Get.offAndToNamed(Routes.homeScreen);
    }
    else{
      Get.offAndToNamed(Routes.authScreen);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Chat App",style: TextStyle(
          color: Colors.white,
          fontSize: 20.0
        ),),
      ),
    );
  }
}
