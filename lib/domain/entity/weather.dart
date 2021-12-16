class Weather {
  Weather({
    required this.main,
    required this.name,
  });

  final Main main;
  final String name;
}

class Main {
  Main({
    required this.temp,
  });

  final double temp;
}
