import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_practice/core/error/failure.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';
import 'package:weather_bloc_practice/domain/repository/weather_repository.dart';
import 'package:weather_bloc_practice/domain/usecase/get_location_weather.dart';
import 'package:weather_bloc_practice/presentation/bloc/weather/weather_event.dart';
import 'package:weather_bloc_practice/presentation/bloc/weather/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(const WeatherState()) {
    on<GetLocationWeatherEvent>((event, emit) async {
      GetLocationWeatherUseCase getLocationWeather =
          GetLocationWeatherUseCase(weatherRepository);
      String location = event.location;
      // Set state to LOADING
      emit(const WeatherState(status: WeatherStatus.loading));
      // Fetch weather
      Either<Failure, Weather> result = await getLocationWeather(location);
      result.fold(
        (left) => emit(
          const WeatherState(status: WeatherStatus.failure),
        ),
        (right) => emit(
          WeatherState(status: WeatherStatus.success, weather: right),
        ),
      );
    });
  }
}
