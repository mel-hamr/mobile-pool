import 'package:weather_app_v2_proj/models/current_weather_model.dart';
import 'package:weather_app_v2_proj/models/daily_weather_model.dart';
import 'package:weather_app_v2_proj/models/hourly_weather_model.dart';

class WeatherModel {
  final CurrentWeatherModel currentWeather;
  final HourlyWeatherModel hourlyWeather;
  final DailyWeatherModel dailyWeather;

  WeatherModel({
    required this.currentWeather,
    required this.hourlyWeather,
    required this.dailyWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      currentWeather: CurrentWeatherModel.fromJson(json['current']),
      hourlyWeather: HourlyWeatherModel.fromJson(json['hourly']),
      dailyWeather: DailyWeatherModel.fromJson(json['daily']),
    );
  }

  factory WeatherModel.empty() {
    return WeatherModel(
      currentWeather: CurrentWeatherModel.empty(),
      hourlyWeather: HourlyWeatherModel.empty(),
      dailyWeather: DailyWeatherModel.empty(),
    );
  }
}
