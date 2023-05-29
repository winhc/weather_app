import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FCMProvider {
  Future<http.Response> sendMessage(
      {required String title, required String message}) async {
    final response =
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: {
              'Authorization':
                  "key=AAAAx2kN_iI:APA91bH-RoJ7fjA02OeOj3H46kd_GQYDOufhkjKydwJ6AM4m--wKKKfQc8NcYaU_TREEg2D_F_ujo61fT5jFZr_-x-JrWcCmC-ev4Yhx0aLiJTJ1Mutmc6bqTJ3XLJpfJnu2f43MsJhS",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "to": "/topics/WLOWeatherApp",
              "collapse_key": "type_a",
              "notification": {"title": title, "body": message},
              "data": {"status": "status"},
            }));
    debugPrint("response => ${jsonDecode(response.body)}");
    return response;
  }
}
