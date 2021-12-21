import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_bloc_practice/presentation/bloc/weather/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String location;

  @override
  void initState() {
    super.initState();
    location = '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        // Display toast on failure
        if (state.status.isFailure) {
          Fluttertoast.showToast(
              msg: "Unable to retrieve weather data.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 1.0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Bloc Practice'),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Center(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Enter your location',
                          ),
                          onChanged: (value) {
                            location = value;
                          },
                        ),
                      ),
                      Center(
                        child: TextButton(
                          child: const Text('Search'),
                          onPressed: () async {
                            if (location != '') {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(GetLocationWeatherEvent(location));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      Widget result;
                      if (state.status.isInitial) {
                        result = const Center(child: Text('No weather data.'));
                      } else if (state.status.isLoading) {
                        result =
                            const Center(child: CircularProgressIndicator());
                      } else if (state.status.isFailure) {
                        result = const Center(
                            child: Text('Unable to retrieve weather data.'));
                      } else {
                        // isSuccess
                        result = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                  'The current temperature in ${state.weather.name}...'),
                            ),
                            Center(
                              child: Text(
                                '${state.weather.main.temp}°C',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.black.withAlpha(100)),
                              ),
                            ),
                          ],
                        );
                      }
                      return result;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
