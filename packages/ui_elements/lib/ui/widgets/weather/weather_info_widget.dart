import 'package:flutter/material.dart';
import 'package:ui_elements/entities/weather.dart';
import 'package:ui_elements/ui/weather_page.dart';
import 'package:ui_elements/ui/widgets/weather/weather_info_row.dart';

part 'weather_additional_info_widget.dart';
part 'weather_main_info_widget.dart';

/// Widget displaying weather information based on the provided [WeatherCondition].
class WeatherInfoWidget extends StatelessWidget {
  const WeatherInfoWidget(
    this.weatherCondition, {
    super.key,
  });

  /// The weather condition for which the information is displayed.
  final WeatherCondition weatherCondition;

  @override
  Widget build(BuildContext context) {
    // Extract weather data from the provided condition.
    final weather = weatherCondition.weatherData;

    // Get the screen width.
    final width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
      child: SizedBox(
        width: width,
        child: ListView(
          children: [
            // Display main weather information.
            WeatherMainInfoWidget(weather),
            // Display additional weather information.
            WeatherAdditionalInfo(weather),
          ],
        ),
      ),
    );
  }
}
