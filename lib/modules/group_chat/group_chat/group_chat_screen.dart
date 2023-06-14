import 'package:chatapp/modules/group_chat/group_chat/group_chat_controller.dart';
import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupChatScreen extends StatelessWidget {
  GroupChatScreen({Key? key}) : super(key: key);
  final GroupChatController _groupChatController = Get.put(GroupChatController());
  String currentUserName = "currentUser";

  /*List<Map<String,dynamic>> userList=[
     {
       "message":one
     }
   ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_groupChatController.groupData["groupName"]),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(Constant.groupKey)
                  .doc(_groupChatController.groupData["groupId"])
                  .collection(Constant.chatsKeyCollection)
                  .orderBy(Constant.timeStampKey,descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.size <= 0) {
                    return const Center(
                      child: Text("There is No Data"),
                    );
                  } else {
                    return ListView(
                        reverse: true,
                        controller: _groupChatController.scrollController,
                        children: snapshot.data!.docs.map((documents) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: _groupChatController.auth.currentUser!.displayName == documents[Constant.sendByKey] ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                        topLeft: _groupChatController.auth.currentUser!.displayName == documents[Constant.sendByKey] ? Radius.circular(10.0) : Radius.zero,
                                        bottomRight: _groupChatController.auth.currentUser!.displayName == documents[Constant.sendByKey] ? Radius.zero : Radius.circular(10.0)),
                                    color: Color(0xffFFFFFF),
                                  ),
                                  margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(documents["sendBy"],style: TextStyle(
                                        color: Colors.grey
                                      ),),
                                      Text(documents[Constant.messageKey]),
                                    ],
                                  )),
                            ),
                          );
                        }).toList());
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Card(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _groupChatController.groupChatTextController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppString.typeAMessage,
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.emoji_emotions_outlined,
                                  ),
                                  onPressed: () {},
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.attach_file),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                            right: 2,
                            left: 2,
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xFF128C7E),
                            child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _groupChatController.onSendMessage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
