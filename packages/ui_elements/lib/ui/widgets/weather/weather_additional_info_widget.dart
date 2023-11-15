part of 'weather_info_widget.dart';

/// Widget displaying additional weather information such as precipitation, humidity, and wind.
class WeatherAdditionalInfo extends StatelessWidget {
  const WeatherAdditionalInfo(this.weather, {super.key});

  /// The weather data for which additional information is displayed.
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display precipitation information.
        WeatherInfoRow(
          label: 'Precipitation',
          value: weather.precipitation,
        ),
        // Display humidity information.
        WeatherInfoRow(
          label: 'Humidity',
          value: weather.humidity,
        ),
        // Display wind information.
        WeatherInfoRow(
          label: 'Wind',
          value: weather.wind,
        ),
      ],
    );
  }
}
