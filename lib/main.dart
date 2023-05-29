import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather/firebase_options.dart';
import 'package:weather/presentation/weather_app.dart';
import 'package:weather/service/fcm_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMService().init();
  runApp(const WeatherApp());
}
