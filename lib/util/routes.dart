import 'package:chatapp/modules/auth/auth_screen.dart';
import 'package:chatapp/modules/chat/screen/chat_screen.dart';
import 'package:chatapp/modules/group_chat/add_member/add_member_screen.dart';
import 'package:chatapp/modules/group_chat/creat_group/create_group_screen.dart';
import 'package:chatapp/modules/group_chat/group_chat/group_chat_screen.dart';
import 'package:chatapp/modules/group_chat/group_home/group_chat_home_screen.dart';
import 'package:chatapp/modules/home/screen/home_screen.dart';
import 'package:chatapp/modules/splash_screen/splash_screen.dart';
import 'package:chatapp/modules/temp_search/search_screen.dart';
import 'package:get/get.dart';

mixin Routes {
  static const String authScreen = "/authScreen";
  static const String homeScreen = "/homeScreen";
  static const String chatScreen = "/chatScreen";
  static const String searchScreen = "/searchScreen";
  static const String groupChatHomeScreen = "/groupChatHomeScreen";
  static const String groupChatScreen = "/groupChatScreen";
  static const String addMemberScreen = "/addMemberInGroup";
  static const String createGroupScreen = "/createGroupScreen";
  static const String splashScreen = "/splashScreen";

  static List<GetPage<dynamic>> pages = [
    GetPage(name: authScreen, page: () => AuthScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: chatScreen, page: () => ChatScreen()),
    GetPage(name: searchScreen, page: () => SearchScreen()),
    GetPage(name: groupChatHomeScreen, page: () => GroupChatHomeScreen()),
    GetPage(name: groupChatScreen, page: () => GroupChatScreen()),
    GetPage(name: addMemberScreen, page: () => AddMemberScreen()),
    GetPage(name: createGroupScreen, page: () => CreateGroupScreen()),
    GetPage(name: splashScreen, page: () => SplashScreen()),

  ];
}
