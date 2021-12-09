import 'package:flutter/material.dart';

import 'presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
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
