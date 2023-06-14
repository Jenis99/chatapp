import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:chatapp/util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CreateGroupController extends GetxController{
  RxList memberList=[].obs;
  RxBool isLoading=false.obs;
  final TextEditingController groupName = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    memberList.value=Get.arguments;
  }


  void createGroup() async {
      isLoading.value = true;
    String groupId = Uuid().v1();
    await FirebaseFirestore.instance.collection(Constant.groupKey).doc(groupId).set({
      "members": memberList,
      "id": groupId,
    }).then((value){
      print("value after created Group");
    });

    for (int i = 0; i < memberList.length; i++) {
      String uid = memberList[i]['uid'];
      print("UID-------->$uid");
      await FirebaseFirestore.instance
          .collection(Constant.userDataCollection)
          .doc(uid)
          .collection(Constant.groupKey)
          .doc(groupId)
          .set({
        "groupName": groupName.text,
        "groupId": groupId,
      });
    }

    await FirebaseFirestore.instance.collection(Constant.groupKey).doc(groupId).collection(Constant.chatsKeyCollection).add({
      "message": "${AppPreference.getString(Constant.userNameKey)} Created This Group.",
      "type": "notify",
    });
    Get.offAllNamed(Routes.homeScreen);
    //
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
  }
}