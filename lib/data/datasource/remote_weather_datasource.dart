import 'dart:convert';

import 'package:weather_bloc_practice/config/constants.dart';
import 'package:weather_bloc_practice/core/error/exception.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteWeatherDataSource {
  Future<Weather> getLocationWeather(String location);
}

class RemoteWeatherDataSourceImpl implements RemoteWeatherDataSource {
  final http.Client client;

  RemoteWeatherDataSourceImpl(this.client);

  @override
  Future<Weather> getLocationWeather(String location) async {
    String url = kWeatherApiBaseUrl + location + '&appid=$kCachedWeatherKey';
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
