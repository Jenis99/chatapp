import 'package:chatapp/util/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GroupChatController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController groupChatTextController=TextEditingController();
  ScrollController scrollController=ScrollController();
  RxMap groupData={}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    groupData.value=Get.arguments;
  }


  void onSendMessage() async {
    if (groupChatTextController.text.isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": auth.currentUser!.displayName,
        "message": groupChatTextController.text,
        "type": "text",
        Constant.timeStampKey: DateTime.now().microsecondsSinceEpoch,
      };

      groupChatTextController.clear();

      await FirebaseFirestore.instance
          .collection(Constant.groupKey)
          .doc(groupData["groupId"])
          .collection(Constant.chatsKeyCollection)
          .add(chatData);
    }
  }
  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds:200),
      curve: Curves.bounceIn,
    );
  }

}