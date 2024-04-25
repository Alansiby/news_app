import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_api_res_model.dart';

class HomeScreenController with ChangeNotifier {
  NewsApiResModel? resModel;

  bool isLoading = false;

  Future getData() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=bbfa9427d470424cba349097b404a7ba");

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
}
