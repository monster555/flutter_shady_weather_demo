import 'package:flutter/material.dart';
import 'package:ui_elements/entities/weather.dart';

/// A class providing mock data for weather conditions.
class MockData {
  /// Mock data for rainy weather.
  static const rainy = Weather(
    label: 'Light Rain',
    city: 'London',
    temperature: 17,
    weatherIcon: Icons.cloudy_snowing,
    precipitation: '72%',
    humidity: '68%',
    wind: '12 km/h',
  );

  /// Mock data for snowy weather.
  static const snowy = Weather(
    label: 'Snowy',
    city: 'New York',
    temperature: 9,
    weatherIcon: Icons.snowing,
    precipitation: '10%',
    humidity: '31%',
    wind: '5 km/h',
  );
}
