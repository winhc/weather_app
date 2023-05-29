import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather/data/models/local_weather_model.dart';

class LocalDatabaseProvider {
  LocalDatabaseProvider.internal();
  static final LocalDatabaseProvider _instance =
      LocalDatabaseProvider.internal();

  factory LocalDatabaseProvider() => _instance;

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  final String DATABASE_NAME = 'weather.db';
  final int DATABASE_VERSION = 1;

  final String WEATHER_TABLE = 'weather_table';
  final String ID = 'id';
  final String WEATHER_FORECAST = 'weather_forecast';

  Future<Database> _initiateDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, DATABASE_NAME);

    var createdDatabase = await openDatabase(path,
        version: DATABASE_VERSION, onCreate: _onCreate);
    return createdDatabase;
  }

  Future<void> _onCreate(Database db, int version) async {
    String weatherTable =
        "CREATE TABLE $WEATHER_TABLE($ID TEXT PRIMARY KEY, $WEATHER_FORECAST TEXT)";
    await db.execute(weatherTable);
  }

  Future<List<LocalWeather>> getLocalWeatherData() async {
    var dbClient = await database;
    String sql = "SELECT * FROM $WEATHER_TABLE";
    List<Map<String, dynamic>> results = await dbClient.rawQuery(sql);
    return results.map((row) => LocalWeather.fromMap(row)).toList();
  }

  Future<LocalWeather> findLocalWeatherDataById(String id) async {
    var dbClient = await database;
    String sql = "SELECT * FROM $WEATHER_TABLE WHERE $ID = $id";
    final result = await dbClient.rawQuery(sql);
    return LocalWeather.fromMap(result.first);
  }

  Future<int> insertLocalWeatherData(LocalWeather localWeather) async {
    var dbClient = await database;
    final data = localWeather.toMap();
    int result = await dbClient.insert(WEATHER_TABLE, data);
    debugPrint('Add Data=> $result');
    return result;
  }

  Future<void> updateLocalWeatherData(
      String id, LocalWeather localWeather) async {
    var dbClient = await database;
    var weatherForecast = localWeather.weatherForecast!.toJson();
    String sql =
        "UPDATE $WEATHER_TABLE SET $WEATHER_FORECAST = '$weatherForecast' WHERE $ID = $id";
    await dbClient.rawQuery(sql);
  }

  Future<int> deleteLocalWeatherData(String id) async {
    var dbClient = await database;
    var result =
        dbClient.delete(WEATHER_TABLE, where: "$ID = ? ", whereArgs: [id]);
    return result;
  }

  Future<int> findLocalWeatherData(String id) async {
    var dbClient = await database;
    String sql = "SELECT COUNT(*) FROM $WEATHER_TABLE WHERE $ID = $id";
    var result = await dbClient.rawQuery(sql);
    int? count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }
}
