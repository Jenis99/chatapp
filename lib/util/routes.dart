import 'package:chatapp/auth/auth_screen.dart';
import 'package:get/get.dart';

mixin Routes {
  static const String authScreen = "/authScreen";

  static List<GetPage<dynamic>> pages = [
    GetPage(name: authScreen, page: () => AuthScreen()),

  ];
}
