import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Bloc Practice'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Center(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your location',
                ),
              ),
            ),
            Center(
              child: TextButton(
                child: const Text('Search'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
