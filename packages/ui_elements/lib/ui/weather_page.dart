import 'package:flutter/material.dart';
import 'package:ui_elements/data/mock_data.dart';
import 'package:ui_elements/entities/weather.dart';
import 'package:ui_elements/ui/widgets/shaders/weather_shader_widget.dart';
import 'package:ui_elements/ui/widgets/weather/weather_info_widget.dart';

/// Enum representing different weather conditions with associated shader information and background images.
/// This is just for demo purposes, that's why I included only 2 weather conditions.
enum WeatherCondition {
  /// Represents a rainy weather condition.
  rainy('assets/rainy.png', 'drops.frag', MockData.rainy),

  /// Represents a snowy weather condition.
  snowy('', 'snow.frag', MockData.snowy);

  /// Creates a [WeatherCondition] with the specified background image, shader, and weather data.
  const WeatherCondition(
    this.backgroundImage,
    this.shader,
    this.weatherData,
  );

  /// The background image associated with the weather condition.
  final String backgroundImage;

  /// The shader file associated with the weather condition.
  final String shader;

  /// The weather data associated with the condition.
  final Weather weatherData;

  /// Checks if the weather condition has a background image.
  bool get hasBackgroundImage => backgroundImage.isNotEmpty;
}

/// A page widget that displays weather information using a shader based on the specified weather condition.
///
/// Parameters:
///
/// - [weatherCondition] The weather condition to display.
class WeatherPage extends StatelessWidget {
  /// Creates a [WeatherPage] widget.
  const WeatherPage(
    this.weatherCondition, {
    super.key,
  });

  /// The weather condition to display.
  final WeatherCondition weatherCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Display the specified weather condition shader.
          WeatherShaderWidget(weatherCondition),
          // Display the title widget.
          WeatherInfoWidget(weatherCondition)
        ],
      ),
    );
  }
}
