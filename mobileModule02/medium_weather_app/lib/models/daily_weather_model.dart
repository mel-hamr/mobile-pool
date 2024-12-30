class DailyWeatherModel {
  final List<String> time;
  final List<double> maxTemps;
  final List<double> minTemps;
  final List<int> weathercodes;

  DailyWeatherModel({
    required this.time,
    required this.maxTemps,
    required this.minTemps,
    required this.weathercodes,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
        time: json['time'].cast<String>(),
        maxTemps: json['temperature_2m_max'].cast<double>(),
        minTemps: json['temperature_2m_min'].cast<double>(),
        weathercodes: (json['weather_code'].cast<int>()));
  }

  factory DailyWeatherModel.empty() {
    return DailyWeatherModel(
      time: [],
      maxTemps: [],
      minTemps: [],
      weathercodes: [],
    );
  }

  @override
  String toString() {
    return 'DailyWeatherModel{time: ${time[0]}, maxTemps: ${maxTemps[0]}, minTemps: ${minTemps[0]} , weathercodes ${weathercodes[0]} }';
  }
}
