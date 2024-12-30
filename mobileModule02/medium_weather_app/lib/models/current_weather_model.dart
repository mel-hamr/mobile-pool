class CurrentWeatherModel {
  final double temp;
  final double windspeed;
  final int weathercode;

  CurrentWeatherModel({
    this.temp = double.maxFinite,
    this.windspeed = double.maxFinite,
    this.weathercode = 0,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      temp: json['temperature_2m'],
      windspeed: json['wind_speed_10m'],
      weathercode: json['weather_code'],
    );
  }

  factory CurrentWeatherModel.empty() {
    return CurrentWeatherModel(
      temp: 0,
      windspeed: 0,
      weathercode: 0,
    );
  }

  @override
  String toString() {
    return 'CurrentWeatherModel{temp: $temp, windspeed: $windspeed, weathercode: $weathercode}';
  }
}
