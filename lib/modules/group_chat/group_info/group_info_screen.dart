import 'package:chatapp/modules/group_chat/group_info/group_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupInfo extends StatelessWidget {
  GroupInfo({super.key});

  final GroupInfoController _groupInfoController = Get.put(GroupInfoController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => _groupInfoController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: BackButton(),
                      ),
                      SizedBox(
                        height: size.height / 8,
                        width: size.width / 1.1,
                        child: Row(
                          children: [
                            Container(
                              height: size.height / 11,
                              width: size.height / 11,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Icon(
                                Icons.group,
                                color: Colors.white,
                                size: size.width / 10,
                              ),
                            ),
                            SizedBox(
                              width: size.width / 20,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  _groupInfoController.groupName.value,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: size.width / 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //

                      SizedBox(
                        height: size.height / 20,
                      ),

                      Container(
                        width: size.width / 1.1,
                        child: Text(
                          "${_groupInfoController.membersList.length} Members",
                          style: TextStyle(
                            fontSize: size.width / 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height / 20,
                      ),

                      // Members Name

                      _groupInfoController.checkAdmin()
                          ? ListTile(
                              /*onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddMemberInGroup(
                      groupChatId: widget.groupId,
                      name: widget.groupName,
                      membersList: membersList,
                    ),
                  ),
                ),*/
                              leading: const Icon(
                                Icons.add,
                              ),
                              title: Text(
                                "Add Members",
                                style: TextStyle(
                                  fontSize: size.width / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : const SizedBox(),

                      Flexible(
                        child: ListView.builder(
                          itemCount: _groupInfoController.membersList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: _groupInfoController.showDialogBox(index, context),
                              leading: const Icon(Icons.account_circle),
                              title: Text(
                                _groupInfoController.membersList[index]['name'],
                                style: TextStyle(
                                  fontSize: size.width / 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(_groupInfoController.membersList[index]['email']),
                              trailing: Text(_groupInfoController.membersList[index]['isAdmin'] ? "Admin" : ""),
                            );
                          },
                        ),
                      ),

                      ListTile(
                        onTap: _groupInfoController.onLeaveGroup,
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          "Leave Group",
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
