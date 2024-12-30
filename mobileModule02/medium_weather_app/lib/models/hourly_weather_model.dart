class HourlyWeatherModel {
  final List<String> time;
  final List<double> temps;
  final List<double> windspeed;
  final List<int> weathercode;

  HourlyWeatherModel({
    required this.time,
    required this.temps,
    required this.windspeed,
    required this.weathercode,
  });

  static List<T> takeFirst24<T>(List<T> list) => list.take(24).toList();

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: takeFirst24(json['time'].cast<String>()),
      temps: takeFirst24(json['temperature_2m'].cast<double>()),
      windspeed: takeFirst24(json['wind_speed_10m'].cast<double>()),
      weathercode: takeFirst24(json['weather_code'].cast<int>()),
    );
  }

  factory HourlyWeatherModel.empty() {
    return HourlyWeatherModel(
      time: [],
      temps: [],
      windspeed: [],
      weathercode: [],
    );
  }

  @override
  String toString() {
    return 'HourlyWeatherModel{time: ${time[0]}, Temp: ${temps[0]}, windspeed: ${windspeed[0]} , weathercodes ${weathercode[0]} }';
  }
}
