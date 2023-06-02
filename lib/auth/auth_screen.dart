import 'package:chatapp/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
   AuthScreen({Key? key}) : super(key: key);
  final AuthController _authController=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Log in "),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          _authController.loginWithGoogle();
        }, child:Text("Google")),
      ),
    );
  }
}
