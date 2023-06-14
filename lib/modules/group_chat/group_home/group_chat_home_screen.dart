import 'package:chatapp/modules/group_chat/add_member/add_member_screen.dart';
import 'package:chatapp/modules/group_chat/group_home/group_home_controller.dart';
import 'package:chatapp/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupChatHomeScreen extends StatelessWidget {
  GroupChatHomeScreen({Key? key}) : super(key: key);
  final GroupHomeController _groupHomeController = Get.put(GroupHomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
      ),
      body: Obx(() => _groupHomeController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _groupHomeController.groupList.length,
              itemBuilder: (context, index) {
                if (_groupHomeController.groupList.isNotEmpty) {
                  return ListTile(
                    onTap: () {
                      var arg={
                        "groupName": _groupHomeController.groupList[index]['groupName'],
                        "groupId": _groupHomeController.groupList[index]['groupId'],
                      };
                      Get.toNamed(Routes.groupChatScreen,arguments: arg);
                    },
                    leading: Icon(Icons.group),
                    title: Text(_groupHomeController.groupList[index]['groupName']),
                  );
                  // ),
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddMemberScreen(),
          ),
        ),
        tooltip: "Create Group",
      ),
    );
  }
}
