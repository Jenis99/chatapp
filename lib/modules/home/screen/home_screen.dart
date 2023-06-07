import 'package:chatapp/modules/home/controller/home_controller.dart';
import 'package:chatapp/util/app_constant.dart';
import 'package:chatapp/util/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.groupChatHomeScreen);
        },
        child: const Icon(
          Icons.group,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_homeController.userName.value),
              accountEmail: Text(_homeController.userEmail.value),
              currentAccountPicture: CircleAvatar(
                child: Image.network(_homeController.userProfile.value),
              ),
            ),
            Center(
              child: Obx(
                () => ElevatedButton(
                    onPressed: () async {
                      _homeController.isLoading.value = true;
                      await _homeController.signOut();
                      _homeController.isLoading.value = false;
                      Get.offAllNamed(Routes.authScreen);
                    },
                    child: _homeController.isLoading.value ? CircularProgressIndicator() : Text("Sign out")),
              ),
            )
          ],
        ),
      ),
      body: (_homeController.userEmail.value.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(Constant.userDataCollection)
                  .where(Constant.userEmailKey, isNotEqualTo: _homeController.userEmail.value)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.size <= 0) {
                    return const Center(
                      child: Text("There is No Data"),
                    );
                  } else {
                    return ListView(
                        children: snapshot.data!.docs.map((documents) {
                      print("have data");
                      return ListTile(
                        onTap: () {
                          var arguments = {
                            Constant.receiverId: documents.id,
                            Constant.userNameKey: documents[Constant.userNameKey],
                            Constant.userProfileUrlKey: documents[Constant.userProfileUrlKey]
                          };
                          Get.toNamed(Routes.chatScreen, arguments: arguments);
                        },
                        title: Text(documents[Constant.userNameKey]),
                        subtitle: Text(documents[Constant.userEmailKey]),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(documents[Constant.userProfileUrlKey]),
                        ),
                      );
                    }).toList());
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}
