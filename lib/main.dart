import 'package:flutter/material.dart';
import 'package:ui_elements/ui_elements.dart';

/// The main entry point for the ShadyWeather demo application.
void main() => runApp(const MyApp());

/// The root widget of the ShadyWeather demo application.
class MyApp extends StatelessWidget {
  /// Creates the [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ShadyWeather Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            children:
                WeatherCondition.values.map((e) => WeatherPage(e)).toList(),
          ),
        ),
      ),
    );
  }
}
