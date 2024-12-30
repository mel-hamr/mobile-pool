import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/models/current_weather_model.dart';

import 'package:weather_app_v2_proj/provider/my_provider.dart';
import 'package:weather_app_v2_proj/widgets/display_error.dart';

class CurrentlyWidget extends StatelessWidget {
  const CurrentlyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle textDecoration =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    final provider = Provider.of<MyProvider>(context, listen: true);

    if (provider.permission == false) {
      return const DisplayError(
          error:
              'Geolocation is not available, please enable it in your App settings');
    }
    if (provider.location.city == '') {
      return const Center(child: CircularProgressIndicator());
    }
    CurrentWeatherModel currWeather = provider.weather.currentWeather;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Currently",
          style: textDecoration,
        ),
        Text(
          provider.location.city,
          style: textDecoration,
        ),
        Text(
          provider.location.area,
          style: textDecoration,
        ),
        Text(
          '${currWeather.temp}°C',
          style: textDecoration,
        ),
        Text(
          '${currWeather.windspeed}Km/h',
          style: textDecoration,
        ),
      ],
    );
  }
}
