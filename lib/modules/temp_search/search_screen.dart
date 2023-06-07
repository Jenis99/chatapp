import 'package:chatapp/modules/temp_search/search_cotroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: searchController.searchController,
          ),
          ElevatedButton(
            onPressed: () {
              searchController.searchData();
            },
            child: const Text("Search",style: TextStyle(
              fontSize: 10.0
            ),),
          ),
        ],
      ),
    );
  }
}
