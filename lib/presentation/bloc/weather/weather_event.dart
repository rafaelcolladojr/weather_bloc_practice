abstract class WeatherEvent {}

class GetLocationWeatherEvent extends WeatherEvent {
  GetLocationWeatherEvent(this.location);

  String location;
}
