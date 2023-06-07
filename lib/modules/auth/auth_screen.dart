import 'package:chatapp/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Log in "),
      ),
      body: Center(
        child: Obx(
          () => ElevatedButton(
              onPressed: () {
                _authController.loginWithGoogle();
              },
              child: _authController.isLoading.value ? const CircularProgressIndicator() : const Text("Google",)),
        ),
      ),
    );
  }
}
