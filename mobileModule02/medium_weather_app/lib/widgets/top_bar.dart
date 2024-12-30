import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/helpers/geolocation_helper.dart';
import 'package:weather_app_v2_proj/helpers/weather_helper.dart';
import 'package:weather_app_v2_proj/provider/my_provider.dart';
import 'package:weather_app_v2_proj/widgets/searchDelegate.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: false);

    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.blue.shade900,
      title: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            readOnly: true,
            textInputAction: TextInputAction.done,
            onTap: () async {
              if (Provider.of<MyProvider>(context, listen: false).isConnected ==
                  true)
                await showSearch(
                    context: context, delegate: MySearchDelegate());
            },
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ),
      actions: [
        const VerticalDivider(
          color: Colors.white,
          thickness: 0.8,
          endIndent: 20,
          indent: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            onPressed: () async {
              if (Provider.of<MyProvider>(context, listen: false).isConnected ==
                  true) {
                try {
                  await GeolocationHelper().determinePosition(context);
                  provider.setCity(provider.location.city);
                  await WeatherHelper()
                      .fetchWeatherData(provider.location.latitude,
                          provider.location.longitude)
                      .then((curr) {
                    provider.weather = curr;
                    provider.permission = true;
                    provider.notify();
                  });
                } catch (e) {
                  provider.setPermission(false);
                }
              }
            },
            icon: const Icon(
              Icons.location_on_outlined,
            ),
            color: Colors.white,
            iconSize: 30,
          ),
        ),
      ],
    );
  }
}
