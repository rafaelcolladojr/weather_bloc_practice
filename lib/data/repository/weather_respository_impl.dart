import 'package:weather_bloc_practice/core/error/exception.dart';
import 'package:weather_bloc_practice/core/network/network_info.dart';
import 'package:weather_bloc_practice/data/datasource/local_weather_datasource.dart';
import 'package:weather_bloc_practice/data/datasource/remote_weather_datasource.dart';
import 'package:weather_bloc_practice/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';
import 'package:weather_bloc_practice/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final LocalWeatherDatasource localWeatherDatasource;
  final RemoteWeatherDataSource remoteWeatherDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.localWeatherDatasource,
    required this.remoteWeatherDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getLocationWeather(String location) async {
    if (await networkInfo.isConnection()) {
      try {
        // attempt getting Weather from remote data source
        final remoteWeather =
            await remoteWeatherDataSource.getLocationWeather(location);
        localWeatherDatasource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        // return a ServerFailure if unable to retrieve Weather from remote data source
        return Left(ServerFailure());
      }
    } else {
      try {
        // attempt getting Weather from system prefs
        final localWeather =
            await localWeatherDatasource.getLastLocationWeather(location);
        return Right(localWeather);
      } on CacheException {
        // return a CacheFailure if unable to retrieve Weather from cache data source (system prefs)
        return Left(CacheFailure());
      }
    }
  }
}
