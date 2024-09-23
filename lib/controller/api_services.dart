import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sunmi_app_demo/utils/string_constants.dart';

class ApiServices {
  static addProductDetails() async {
    try {
      var api = Uri.parse("${StringConstants.baseURL}/add_products");
      http.Response response = await http.get(api);

      if (response.statusCode == 200) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      stdout.writeln(e);
    }
  }
}
