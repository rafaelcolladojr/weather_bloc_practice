import 'package:weather_bloc_practice/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_bloc_practice/core/usecase.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';
import 'package:weather_bloc_practice/domain/repository/weather_repository.dart';

class GetLocationWeather extends UseCase<Weather, String> {
  GetLocationWeather(this.weatherRepository);

  final WeatherRepository weatherRepository;

  @override
  Future<Either<Failure, Weather>> call(String params) async {
    return await weatherRepository.getLocationWeather(params);
  }
}
