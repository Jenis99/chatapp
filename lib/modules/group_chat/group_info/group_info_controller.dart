import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupInfoController extends GetxController{
  RxMap<dynamic,dynamic> groupData={}.obs;
  List membersList = [];
  RxBool isLoading = true.obs;
  RxString groupName="".obs;
  RxString groupId="".obs;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    groupData=Get.arguments;
    getGroupDetails();
  }

  bool checkAdmin() {
    bool isAdmin = false;

    membersList.forEach((element) {
      if (element['uid'] == _auth.currentUser!.uid) {
        isAdmin = element['isAdmin'];
      }
    });
    return isAdmin;
  }

  Future getGroupDetails() async {
  groupId=groupData["groupId"];
  groupName=groupData["groupName"];
    await _firestore
        .collection('groups')
        .doc(groupId.value)
        .get()
        .then((chatMap) {
      membersList = chatMap['members'];
      print(membersList);
      isLoading.value = false;
    });
  }


  Future removeMembers(int index) async {
    String uid = membersList[index]['uid'];

      isLoading.value = true;
      membersList.removeAt(index);

    await _firestore.collection('groups').doc(groupId.value).update({
      "members": membersList,
    }).then((value) async {
      await _firestore
          .collection(Constant.userDataCollection)
          .doc(uid)
          .collection(Constant.groupKey)
          .doc(groupId.value)
          .delete();

        isLoading.value = false;
    });
  }

   showDialogBox(int index,BuildContext context) {
    if (checkAdmin()) {
      if (_auth.currentUser!.uid != membersList[index]['uid']) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  onTap: () => removeMembers(index),
                  title: Text("Remove This Member"),
                ),
              );
            });
      }
    }
  }

  Future onLeaveGroup() async {
    if (!checkAdmin()) {

        isLoading.value = true;

      for (int i = 0; i < membersList.length; i++) {
        if (membersList[i]['uid'] == _auth.currentUser!.uid) {
          membersList.removeAt(i);
        }
      }

      await _firestore.collection('groups').doc(groupId.value).update({
        "members": membersList,
      });

      await _firestore
          .collection(Constant.userDataCollection)
          .doc(_auth.currentUser!.uid)
          .collection(Constant.groupKey)
          .doc(groupId.value)
          .delete();
      Get.offAllNamed(Routes.homeScreen);
    }
  }
}