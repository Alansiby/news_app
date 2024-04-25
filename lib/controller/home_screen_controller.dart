import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_api_res_model.dart';

class HomeScreenController with ChangeNotifier {
  static List<String> categoryList = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  NewsApiResModel? resByCategory;
  int selectedCatagoryIndex = 0;
  NewsApiResModel? resModel;
  bool isLoading = false;

  //get data by category
  Future getDataByCategory() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=${categoryList[selectedCatagoryIndex]}&apiKey=bbfa9427d470424cba349097b404a7ba");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decodeData = jsonDecode(res.body);
      resModel = NewsApiResModel.fromJson(decodeData);
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  //on category selection
  onCategorySelection(int value) {
    selectedCatagoryIndex = value;
    notifyListeners();
    getDataByCategory();
  }

// get data of everything
  // Future getData() async {
  //   isLoading = true;
  //   notifyListeners();
  //   Uri url = Uri.parse(
  //       "https://newsapi.org/v2/everything?q=bitcoin&apiKey=bbfa9427d470424cba349097b404a7ba");

  //   var res = await http.get(url);

  //   if (res.statusCode == 200) {
  //     var decodeData = jsonDecode(res.body);
  //     resModel = NewsApiResModel.fromJson(decodeData);
  //   } else {
  //     print("failed");
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }
}
