import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_bloc_practice/config/constants.dart';
import 'package:weather_bloc_practice/core/error/exception.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';

abstract class LocalWeatherDatasource {
  Future<Weather> getLastLocationWeather(String location);
  Future<void> cacheWeather(Weather weather);
}

class LocalWeatherDatasourceImpl implements LocalWeatherDatasource {
  final SharedPreferences sharedPreferences;

  LocalWeatherDatasourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheWeather(Weather weather) {
    sharedPreferences.setString(
      '${kCachedWeatherKey}_${weather.name}', // eg. CACHED_WEATHER_newyork
      jsonEncode(weather.toJson()),
    );

    return Future<void>(() {});
  }

  @override
  Future<Weather> getLastLocationWeather(String location) {
    // attempt to get cached weather json string associated with provided location string
    // location name is used in storage key
    final jsonString =
        sharedPreferences.getString('${kCachedWeatherKey}_$location') ?? '';

    if (jsonString != '') {
      // if weather is not cached, return CacheException. Later to be CacheFailure
      return Future<Weather>.value(Weather.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
