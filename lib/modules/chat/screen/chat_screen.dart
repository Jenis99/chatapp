import 'package:chatapp/modules/chat/controller/chat_controller.dart';
import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/app_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      appBar: AppBar(
        // leading: CircleAvatar(backgroundImage: NetworkImage(_chatController.receiverProfilePicture.value,)),
        title: Text(_chatController.receiverName.value),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(Constant.userDataCollection)
                .doc(_chatController.senderId.value)
                .collection(Constant.chatsKeyCollection)
                .doc(_chatController.receiverId.value)
                .collection(Constant.messageCollection)
                .orderBy(Constant.timeStampKey, descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.size <= 0) {
                  return const Center(
                    child: Text("There is no data"),
                  );
                } else {
                  return ListView(
                      reverse: true,
                      controller: _chatController.scrollController,
                      children: snapshot.data!.docs.map((documents) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment:
                            _chatController.senderId.value == documents[Constant.senderIdKey] ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0),
                                      topLeft: _chatController.senderId.value == documents[Constant.senderIdKey] ? Radius.circular(10.0):Radius.zero,
                                    bottomRight: _chatController.senderId.value == documents[Constant.senderIdKey] ? Radius.zero :Radius.circular(10.0)),
                                  color: Color(0xffFFFFFF),
                                ),
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(10.0),
                                child: Text(documents[Constant.messageKey])),
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
                            controller: _chatController.messageController,
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
                            onPressed: () async {
                              if (_chatController.messageController.text.isNotEmpty) {
                                String msg = _chatController.messageController.text;
                                _chatController.messageController.text = "";

                                await FirebaseFirestore.instance
                                    .collection(Constant.userDataCollection)
                                    .doc(_chatController.senderId.value)
                                    .collection(Constant.chatsKeyCollection)
                                    .doc(_chatController.receiverId.value)
                                    .collection(Constant.messageCollection)
                                    .add({
                                  Constant.receiverId: _chatController.receiverId.value,
                                  Constant.senderIdKey: _chatController.senderId.value,
                                  Constant.typeKey: Constant.textType,
                                  Constant.messageKey: msg,
                                  Constant.timeStampKey: DateTime.now().millisecondsSinceEpoch,
                                }).then((value) async {
                                  await FirebaseFirestore.instance
                                      .collection(Constant.userDataCollection)
                                      .doc(_chatController.receiverId.value)
                                      .collection(Constant.chatsKeyCollection)
                                      .doc(_chatController.senderId.value)
                                      .collection(Constant.messageCollection)
                                      .add({
                                    Constant.receiverId: _chatController.receiverId.value,
                                    Constant.senderIdKey: _chatController.senderId.value,
                                    Constant.typeKey: Constant.textType,
                                    Constant.messageKey: msg,
                                    Constant.timeStampKey: DateTime.now().millisecondsSinceEpoch,
                                  }).then((value) {
                                    _chatController.messageController.text = "";
                                  });
                                });
                                _chatController.scrollDown();
                              }
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
      ),
    );
  }
}
