import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/helpers/weather_helper.dart';
import 'package:weather_app_v2_proj/models/location_model.dart';

import 'package:weather_app_v2_proj/provider/my_provider.dart';

Future fettchData(query) async {
  final String url =
      'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=10&language=en&format=json';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    if (json.containsKey('results')) {
      return json['results'];
    }
  }
  return null;
}

class MySearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: colorScheme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        backgroundColor: Colors.blue.shade900,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.white, fontSize: 18),
            border: InputBorder.none,
          ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
        fontSize: 20,
        color: Colors.white,
      )),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buidlSuggest();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buidlSuggest();
  }

  FutureBuilder<dynamic> buidlSuggest() {
    return FutureBuilder(
      future: fettchData(query),
      builder: (context, snapshot) {
        if (context.read<MyProvider>().isConnected == false) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: AutoSizeText(
                'Error : Please make sure your device is connected to the internet',
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
                maxFontSize: 20,
                minFontSize: 10,
              ),
            ),
          );
        }
        if (snapshot.data == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<MyProvider>().isConnected = false;
          });
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: AutoSizeText(
                'Error fetching data',
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
                maxFontSize: 20,
                minFontSize: 10,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: AutoSizeText(
                'Error fetching data',
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
                maxFontSize: 20,
                minFontSize: 10,
              ),
            ),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: AutoSizeText(
                'No locations found',
                style: TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
                maxFontSize: 20,
                minFontSize: 10,
              ),
            ),
          );
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<MyProvider>().isConnected = true;
        });
        final locations = snapshot.data;
        final provider = Provider.of<MyProvider>(context, listen: true);
        return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final LocationModel city =
                  LocationModel.fromJson(locations[index]);
              return ListTile(
                onTap: () {
                  WeatherHelper()
                      .fetchWeatherData(city.latitude, city.longitude)
                      .then((curr) {
                    provider.location = city;
                    provider.weather = curr;
                    provider.permission = true;
                    provider.notify();
                    close(context, null);
                  });
                  // close(context, null);
                },
                leading: AutoSizeText(
                  '${city.city} | ${city.sublocality} | ${city.country}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 10,
                  maxFontSize: 20,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            });
      },
    );
  }
}
