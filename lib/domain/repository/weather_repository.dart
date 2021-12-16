import 'package:dartz/dartz.dart';
import 'package:weather_bloc_practice/core/error/failure.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getLocationWeather(String location);
}
