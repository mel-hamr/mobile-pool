import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/helpers/weather_helper.dart';
import 'package:weather_app_v2_proj/models/daily_weather_model.dart';
import 'package:weather_app_v2_proj/provider/my_provider.dart';
import 'package:weather_app_v2_proj/widgets/display_error.dart';

class WeeklyWidget extends StatelessWidget {
  const WeeklyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: false);

    const TextStyle textDecoration =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    if (provider.permission == false) {
      return const DisplayError(
          error:
              'Geolocation is not available, please enable it in your App settings');
    }
    if (provider.location.city == '') {
      return const Center(child: CircularProgressIndicator());
    }
    DailyWeatherModel dailyWeather = provider.weather.dailyWeather;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Weekly",
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
        SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.all(8.0), // Optional: Add padding to the container
            child: ListView.builder(
              shrinkWrap:
                  true, // This makes the ListView take only the space it needs
              // Disable scrolling inside the ListView
              itemCount: 7,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat.yMd()
                          .format(DateTime.parse(dailyWeather.time[index])),
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${dailyWeather.maxTemps[index]}°C',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${dailyWeather.minTemps[index]}°C',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: AutoSizeText(
                        WeatherHelper().getWeatherCondition(
                            dailyWeather.weathercodes[index]),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        maxFontSize: 18,
                        minFontSize: 8,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    // Text(
                    // WeatherHelper().getWeatherCondition(
                    //     dailyWeather.weathercodes[index]),
                    //   style: TextStyle(fontSize: 18),
                    // ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
