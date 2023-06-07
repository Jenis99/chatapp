import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  RxMap receiverData = {}.obs;
  RxString receiverName="".obs;
  RxString receiverProfilePicture="".obs;
  RxString receiverId="".obs;
  RxString senderId="".obs;
  TextEditingController messageController=TextEditingController();
  ScrollController scrollController=ScrollController();
  @override
  void onInit() {
    super.onInit();
    getReceiverData();
  }
  getReceiverData(){
    receiverData.value=Get.arguments;
    receiverName.value=receiverData[Constant.userNameKey];
    receiverProfilePicture.value=receiverData[Constant.userProfileUrlKey];
     receiverId.value=receiverData[Constant.receiverId];
    senderId.value=AppPreference.getString(Constant.senderIdKey);
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds:200),
      curve: Curves.bounceIn,
    );
  }

}