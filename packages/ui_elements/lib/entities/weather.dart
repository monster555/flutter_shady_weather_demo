import 'package:flutter/material.dart';

/// Represents weather information.
class Weather {
  /// Creates a [Weather] instance.
  const Weather({
    required this.label,
    required this.city,
    required this.temperature,
    required this.weatherIcon,
    required this.precipitation,
    required this.humidity,
    required this.wind,
  });

  /// The label describing the weather condition.
  final String label;

  /// The city associated with the weather data.
  final String city;

  /// The temperature in degrees Celsius.
  final int temperature;

  /// The icon representing the weather condition.
  final IconData weatherIcon;

  /// The precipitation information.
  final String precipitation;

  /// The humidity information.
  final String humidity;

  /// The wind information.
  final String wind;
}
