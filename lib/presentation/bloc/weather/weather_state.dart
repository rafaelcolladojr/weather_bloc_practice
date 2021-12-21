import 'package:equatable/equatable.dart';
import 'package:weather_bloc_practice/data/model/weather_model.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusEx on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather = Weather.empty,
  });

  WeatherState copyWith(
    WeatherStatus? status,
    Weather? weather,
  ) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}
