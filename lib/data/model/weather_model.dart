import 'dart:convert';

import 'package:equatable/equatable.dart';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather extends Equatable {
  const Weather({
    required this.main,
    required this.name,
  });

  final Main main;
  final String name;

  static const Weather empty = Weather(
    main: Main(temp: 0.0),
    name: '',
  );

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: Main.fromJson(json["main"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "name": name,
      };

  @override
  List<Object?> get props => [main, name];
}

class Main extends Equatable {
  const Main({
    required this.temp,
  });

  final double temp;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };

  @override
  List<Object?> get props => [temp];
}
