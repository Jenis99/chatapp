import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddMemberController extends GetxController {
  Map<String, dynamic>? userMap;
  RxBool isLoading = false.obs;
  RxString searchedData = "".obs;
  RxList<Map<String, dynamic>> membersList = <Map<String, dynamic>>[].obs;
  final TextEditingController searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
     getCurrentUserData();
  }


  getCurrentUserData() {
    membersList.add({
      "name": AppPreference.getString(Constant.userNameKey),
      "email": AppPreference.getString(Constant.userEmailKey),
      "uid": AppPreference.getString(Constant.senderIdKey),
      "isAdmin": true,
    });
  }


  void onResultTap() {
    print("result Tapped");
    bool isAlreadyExist = false;

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == userMap!['userId']) {
        isAlreadyExist = true;
      }
    }

    if (!isAlreadyExist) {
      membersList.add({
        "name": userMap!['userName'],
        "email": userMap!['userEmail'],
        "uid": userMap!['userId'],
        "isAdmin": false,
      });
      userMap?.remove(userMap?[0]);
      print("membersList.length----------------${membersList.length}");
    }
  }


  void onRemoveMembers(int index) {
    if (membersList[index]['uid'] != AppPreference.getString(Constant.senderIdKey)) {
      membersList.removeAt(index);
    }
  }

  void onSearch() async {
    print("userEmail before Searched-----${searchController.text}");
    isLoading.value = true;
    await FirebaseFirestore.instance
        .collection(Constant.userDataCollection)
        .where(Constant.userEmailKey, isEqualTo: searchController.text)
        .get()
        .then((value) {
      print("userEmail before Searched-----${value.docs[0].data()}");
      userMap = value.docs[0].data();
      isLoading.value = false;
      print("userMap====>$userMap");
    });
  }
}
