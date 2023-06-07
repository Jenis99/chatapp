import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];
  var SearchedData;
  TextEditingController searchController = TextEditingController();
  searchData(){
    SearchedData =searchTerms.where((result) => result.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    print("searchData-------------->$SearchedData");
  }
}