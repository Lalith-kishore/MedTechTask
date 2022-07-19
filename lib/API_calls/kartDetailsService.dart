import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/FetchCartModel.dart';

class KartDetailsService {
  /* static final http.Client httpClient = http.Client();*/

  static Future<FetchCartModel?> getData() async {
    print("Entering into API call Method");

    try {
      var url = Uri.parse(
          "https://pg.dailefresh.com/WebApi/ListProductByCategoryorSubCategory_Page?"
          "Cat=FNV&Sub=FV&StoreId=1&User_id=1&R_Number=1");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        debugPrint("Success");
      } else if (response.statusCode == 404) {
        debugPrint("Fail");
      } else if (response.statusCode == 500) {
        debugPrint("Server Error");
      } else {
        debugPrint("Cross Origin Error");
      }

      debugPrint("response:" + response.body.toString(), wrapWidth: 1024);

      final json = jsonDecode(response.body);

      if (json != null && json.length > 0) {
        FetchCartModel dashboard = FetchCartModel.fromJson(json);
        return dashboard;

      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
