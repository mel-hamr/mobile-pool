import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/models/location_model.dart';
import 'package:weather_app_v2_proj/provider/my_provider.dart';

class GeolocationHelper {

  Future determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;
    final provider = Provider.of<MyProvider>(context, listen: false);

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      provider.setPermission(false);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      provider.setPermission(false);

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        provider.setPermission(false);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      provider.setPermission(false);

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    provider.setPermission(true);

    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    List<Placemark> cc =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    LocationModel loc = LocationModel(
        cc[0].locality,
        cc[0].country,
        cc[0].administrativeArea,
        cc[0].subLocality,
        position.latitude,
        position.longitude);
    provider.setLocation(loc);
    return cc[0];
  }
}
