import 'dart:async';


import 'package:bloc_get_api/res/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/api_result_model.dart';




class RestaurantRepository  {

  @override
  Future<RestaurantModel> getRestaurantData() async {
    final response =  await http.get(AppStrings.cricArticleUrl);

    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return RestaurantModel.fromJson(jsonDecode(responseString));
    } else {
      print("EEEE");
      throw Exception();
    }
  }

}