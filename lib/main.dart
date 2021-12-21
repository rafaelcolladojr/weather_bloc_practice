import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_practice/domain/repository/weather_repository.dart';
import 'presentation/bloc/weather/bloc.dart';
import 'package:weather_bloc_practice/injection_container.dart' as di;

import 'presentation/bloc/weather/weather_bloc.dart';
import 'presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Needed for the instantiation of SharedPreferences. Don't know why
  await di.init();
  runApp(
    RepositoryProvider.value(
      value: (_) => di.getIt<WeatherRepository>(),
      child: BlocProvider<WeatherBloc>.value(
        value: di.getIt<WeatherBloc>(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Bloc Practice',
      theme: ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}
