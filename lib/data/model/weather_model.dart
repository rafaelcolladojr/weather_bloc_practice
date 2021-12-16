import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

class Weather {
  Weather({
    this.main,
    this.name,
  });

  Main? main;
  String? name;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: Main.fromJson(json["main"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "main": main!.toJson(),
        "name": name,
      };
}

class Main {
  Main({
    this.temp,
  });

  double? temp;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}
