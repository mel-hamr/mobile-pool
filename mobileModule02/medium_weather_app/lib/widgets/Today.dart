import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/models/hourly_weather_model.dart';
import 'package:weather_app_v2_proj/provider/my_provider.dart';
import 'package:weather_app_v2_proj/widgets/display_error.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: false);

    const TextStyle textDecoration =
        TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

    if (provider.permission == false) {
      return const DisplayError(
          error:
              'Geolocation is not available, please enable it in your App settings');
    }
    if (provider.location.city == '') {
      return const Center(child: CircularProgressIndicator());
    }
    HourlyWeatherModel hourlyWeather = provider.weather.hourlyWeather;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Today",
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
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 20),
            shrinkWrap:
                true, // This makes the ListView take only the space it needs
            // Disable scrolling inside the ListView
            itemCount: hourlyWeather.temps.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    DateFormat.Hm()
                        .format(DateTime.parse(hourlyWeather.time[index])),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${hourlyWeather.temps[index]}°C',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${hourlyWeather.windspeed[index]}km/h',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
