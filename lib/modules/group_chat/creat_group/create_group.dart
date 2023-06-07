import 'package:chatapp/modules/group_chat/creat_group/create_group_cotroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroup extends StatelessWidget {
   CreateGroup({super.key});
   final CreateGroupController _createGroupController=Get.put(CreateGroupController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Group Name"),
      ),
      body: isLoading
          ? Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 10,
          ),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _createGroupController.groupName,
                decoration: InputDecoration(
                  hintText: "Enter Group Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          ElevatedButton(
            onPressed: _createGroupController.createGroup,
            child: Text("Create Group"),
          ),
        ],
      ),
    );
  }
}




