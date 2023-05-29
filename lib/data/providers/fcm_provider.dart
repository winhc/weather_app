import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FCMProvider {
  Future<http.Response> sendMessage(
      {required String title, required String message}) async {
    final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Authorization': "key=YOUR_API_KEY",
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
