import 'package:chatapp/modules/group_chat/add_member/add_member_controller.dart';
import 'package:chatapp/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMemberScreen extends StatelessWidget {
  AddMemberScreen({Key? key}) : super(key: key);

  final AddMemberController _addMemberController = Get.put(AddMemberController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Members"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Obx(
                () => ListView.builder(
                  itemCount: _addMemberController.membersList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(
                      () => ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(_addMemberController.membersList[index]['name']),
                        subtitle: Text(_addMemberController.membersList[index]['email']),
                        trailing: IconButton(
                            onPressed: () {
                              _addMemberController.onRemoveMembers(index);
                            },
                            icon: Icon(Icons.close)),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              height: size.height / 14,
              width: size.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: size.height / 14,
                width: size.width / 1.15,
                child: TextField(
                  controller: _addMemberController.searchController,
                  decoration: InputDecoration(
                    hintText: "Search",
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
            Obx(
              () => _addMemberController.isLoading.value
                  ? Container(
                      height: size.height / 12,
                      width: size.height / 12,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_addMemberController.searchController.text.isNotEmpty /*&&_addMemberController.membersList.contains(_addMemberController.searchController.text)*/) {
                          _addMemberController.onSearch();
                        }
                      },
                      child: Text("Search"),
                    ),
            ),
            Obx(
              () => _addMemberController.userMap.isNotEmpty
                  ? ListTile(
                      onTap: () {
                        _addMemberController.onResultTap();
                      },
                      leading: Icon(Icons.account_box),
                      title: Text(_addMemberController.userMap['userName']),
                      subtitle: Text(_addMemberController.userMap['userEmail']),
                      trailing: GestureDetector(
                        onTap: () {
                          _addMemberController.removeFromUserMap();
                        },
                        child: Icon(Icons.add),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => _addMemberController.membersList.length >= 2
            ? FloatingActionButton(
                child: Icon(Icons.forward),
                onPressed: () {
                  Get.toNamed(Routes.createGroupScreen, arguments: _addMemberController.membersList);
                }

                // Navigator.of(context).push(
                // MaterialPageRoute(
                //   builder: (_) => CreateGroup(
                //     _addMemberController.membersList: _addMemberController.membersList,
                //   ),
                // ),
                // ),
                )
            : SizedBox(),
      ),
    );
  }
}
