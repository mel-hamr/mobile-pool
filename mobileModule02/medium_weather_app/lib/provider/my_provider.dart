import 'package:flutter/material.dart';
import 'package:weather_app_v2_proj/models/location_model.dart';
import 'package:weather_app_v2_proj/models/weather_model.dart';

class MyProvider extends ChangeNotifier {
  LocationModel location = LocationModel.empty();
  WeatherModel weather = WeatherModel.empty();
  String city = '';
  int activePage = 0;
  bool permission = true;
  bool isConnected = true;

  setPermission(per) {
    permission = per;
    notifyListeners();
  }

  setIsConnected(con) {
    isConnected = con;
    notifyListeners();
  }

  setLocation(loc) {
    location.city = loc.city;
    location.country = loc.country;
    location.area = loc.area;
    location.sublocality = loc.sublocality;
    location.latitude = loc.latitude;
    location.longitude = loc.longitude;

    notifyListeners();
  }

  setWeather(w) {
    weather = w;
    notifyListeners();
  }

  setCity(c) {
    city = c;
    notifyListeners();
  }

  setActivePage(index) {
    activePage = index;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }
}
