class WeatherEntity {
  WeatherEntity({
    required this.main,
    required this.name,
  });

  final Main main;
  final String name;

  WeatherEntity copyWith(double? temp, String? name) => WeatherEntity(
        main: Main(temp: temp ?? main.temp),
        name: name ?? this.name,
      );
}

class Main {
  Main({
    required this.temp,
  });

  final double temp;
}
