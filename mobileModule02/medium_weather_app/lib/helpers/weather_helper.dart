import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:weather_app_v2_proj/models/weather_model.dart';

class WeatherHelper {
  Future<WeatherModel> fetchWeatherData(
      double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,weather_code,wind_speed_10m&hourly=temperature_2m,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=GMT'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load weather data');
    }
    final jsonBody = json.decode(response.body);
    return WeatherModel.fromJson(jsonBody);
  }

  getWeatherCondition(int code) {
    if (code == 0) return "Clear sky";
    if (code == 1) return "Mainly clear";
    if (code == 2) return "partly cloudy";
    if (code == 3) return "overcast";
    if (code == 45 || code == 48) return "Fog and depositing rime fog";
    if (code == 51) return 'Light intensity Drizzle';
    if (code == 53) return 'Moderate intensity Drizzle';
    if (code == 55) return 'Dense intensity Drizzle';
    if (code == 56) return "Light intensity Freezing Drizzle";
    if (code == 57) return "Dense intensity Freezing Drizzle";
    if (code == 61) return "Slight intensity Rain";
    if (code == 63) return "Moderate intensity Rain";
    if (code == 65) return "Heavy intensity Rain";
    if (code == 66) return "Light intensity Freezing Rain";
    if (code == 67) return "Heavy intensity Freezing Rain";
    if (code == 71) return "Slight intensity Snow fall";
    if (code == 73) return "Moderate intensity Snow fall";
    if (code == 75) return "Heavy intensity Snow fall";
    if (code == 77) return "Snow grains";
    if (code == 80) return "Slight Rain showers";
    if (code == 81) return "Moderate Rain showers";
    if (code == 82) return "Violent Rain showers";
    if (code == 85) return "Slight Snow showers";
    if (code == 86) return "Heavy Snow showers";
    if (code == 95) return "Slight Thunderstorm";
    if (code == 96) return "Thunderstorm with slight hail";
    if (code == 99) return "Thunderstorm with heavy hail";
  }
}
