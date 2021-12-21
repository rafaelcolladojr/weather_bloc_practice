import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_bloc_practice/domain/repository/weather_repository.dart';
import 'package:weather_bloc_practice/presentation/bloc/weather/bloc.dart';
import 'package:weather_bloc_practice/core/network/network_info.dart';
import 'package:weather_bloc_practice/data/datasource/local_weather_datasource.dart';
import 'package:weather_bloc_practice/data/datasource/remote_weather_datasource.dart';
import 'package:weather_bloc_practice/data/repository/weather_respository_impl.dart';
import 'package:weather_bloc_practice/domain/usecase/get_location_weather.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance; // Service Locator

Future<void> init() async {
  // BLOCS
  getIt.registerFactory<WeatherBloc>(() => WeatherBloc(getIt()));

  // USE CASES
  getIt.registerLazySingleton<GetLocationWeatherUseCase>(
      () => GetLocationWeatherUseCase(getIt()));

  // REPOSITORIES
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        localWeatherDatasource: getIt(),
        remoteWeatherDataSource: getIt(),
        networkInfo: getIt(),
      ));

  // DATASOURCES
  getIt.registerLazySingleton<LocalWeatherDatasource>(
      () => LocalWeatherDatasourceImpl(getIt()));
  getIt.registerLazySingleton<RemoteWeatherDataSource>(
      () => RemoteWeatherDataSourceImpl(getIt()));

  // NETWORK INFO
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo());

  // EXTERNAL
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton<Client>(() => http.Client());
}
