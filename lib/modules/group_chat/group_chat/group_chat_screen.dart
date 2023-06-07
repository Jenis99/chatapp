import 'package:chatapp/modules/group_chat/group_chat/group_chat_controller.dart';
import 'package:chatapp/util/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupChatScreen extends StatelessWidget {
   GroupChatScreen({Key? key}) : super(key: key);
   final GroupChatController _groupChatController=Get.put(GroupChatController());
   String currentUserName="currentUser";
   /*List<Map<String,dynamic>> userList=[
     {
       "message":one
     }
   ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Name"
        ),centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: Text("Group chat"),),
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
                            onPressed: (){},
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
      )
    );
  }
}
