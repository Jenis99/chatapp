import 'package:chatapp/util/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GroupHomeController extends GetxController{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = true.obs;

  RxList groupList = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = auth.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection(Constant.userDataCollection)
        .doc(uid)
        .collection(Constant.groupKey)
        .get()
        .then((value) {
          print("---->${value}");
        groupList.value = value.docs.obs;
        isLoading.value = false;
    });
  }
}