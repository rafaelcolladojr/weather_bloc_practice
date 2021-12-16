import 'package:weather_bloc_practice/data/model/weather_model.dart';

abstract class RemoteWeatherDataSource {
  Future<Weather> getLocationWeather(String location);
}
