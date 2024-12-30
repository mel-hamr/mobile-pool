import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/helpers/geolocation_helper.dart';
import 'package:weather_app_v2_proj/helpers/weather_helper.dart';
import 'package:weather_app_v2_proj/provider/my_provider.dart';
import 'package:weather_app_v2_proj/widgets/Currently.dart';
import 'package:weather_app_v2_proj/widgets/Today.dart';
import 'package:weather_app_v2_proj/widgets/Weekly.dart';
import 'package:weather_app_v2_proj/widgets/bot_nav_bar.dart';
import 'package:weather_app_v2_proj/widgets/display_error.dart';
import 'package:weather_app_v2_proj/widgets/top_bar.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _pageViewController = PageController();

  get connectivityResult => null;

  listenToconnection() {
    var provider = Provider.of<MyProvider>(context, listen: false);

    InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          provider.setIsConnected(true);
          // The internet is now connected
          break;
        case InternetStatus.disconnected:
          provider.setIsConnected(false);

          // The internet is now disconnected
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        var provider = Provider.of<MyProvider>(context, listen: false);
        await GeolocationHelper().determinePosition(context);
        await WeatherHelper()
            .fetchWeatherData(
                provider.location.latitude, provider.location.longitude)
            .then((curr) {
          provider.weather = curr;
          provider.permission = true;
          provider.notify();

        }).catchError((e) {
          print(e);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: false);
    listenToconnection();

    return Consumer<MyProvider>(
        builder: (context, value, child) => MaterialApp(
              home: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: const PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: TopBar(),
                ),
                body: provider.isConnected == false
                    ? const DisplayError(
                        error:
                            "Your device is not connected to the internet !!")
                    : PageView(
                        controller: _pageViewController,
                        children: const <Widget>[
                          CurrentlyWidget(),
                          TodayWidget(),
                          WeeklyWidget()
                        ],
                        onPageChanged: (index) {
                          provider.setActivePage(index);
                        },
                      ),
                bottomNavigationBar: BotNavBar(
                  pageViewController: _pageViewController,
                ),
              ),
            ));
  }
}
