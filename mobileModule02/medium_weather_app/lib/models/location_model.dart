import 'package:geocoding/geocoding.dart';

class LocationModel {
  String city = '';
  String country = '';
  String area = '';
  String sublocality = '';
  double latitude = 0;
  double longitude = 0;

  LocationModel(
    lcity,
    lcountry,
    larea,
    lsublocality,
    llatitude,
    llongitude,
  ) {
    city = lcity;
    country = lcountry;
    area = larea;
    sublocality = lsublocality;
    latitude = llatitude;
    longitude = llongitude;
  }
  static fillFields(Placemark pos, lat, long) {

    return LocationModel(pos.locality!, pos.country!, pos.administrativeArea!,
        pos.subLocality!, lat, long);
  }

  @override
  String toString() {
    return 'LocationModel{city: $city, country: $country, \n area: $area, sublocality: $sublocality}\n lat : $latitude , long : $longitude';
  }

  LocationModel.empty()
      : city = '',
        country = '',
        area = '',
        sublocality = '',
        latitude = 0,
        longitude = 0;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      json['name'] ?? '',
      json['country'] ?? '',
      json['admin1'] ?? '',
      json['admin1'] ?? '',
      json['latitude'] ?? '',
      json['longitude'] ?? '',
    );
  }
}
