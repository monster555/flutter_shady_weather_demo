part of 'weather_info_widget.dart';

class WeatherMainInfoWidget extends StatelessWidget {
  const WeatherMainInfoWidget(this.weather, {super.key});

  /// The weather data for which additional information is displayed.
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display weather icon.
        Icon(
          weather.weatherIcon,
          size: 64,
          color: Colors.white,
        ),
        // Display city name.
        Text(
          weather.city,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        // Display weather label.
        Text(
          weather.label,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white60,
          ),
          textAlign: TextAlign.center,
        ),
        // Display temperature.
        Text(
          '${weather.temperature}°',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 120,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
