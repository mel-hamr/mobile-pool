import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _location = "";
  final _pageViewController = PageController();
  int _activePage = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.blue.shade900,
            title: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  onSubmitted: (input) {
                    setState(() {
                      _location = input;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    labelText: 'Enter location',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, // Border color when focused
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors
                            .blue.shade700, // Border color when not focused
                      ),
                    ),
                  ),
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
                  onPressed: () {
                    setState(() {
                      _location = "Geolocation";
                    });
                  },
                  icon: const Icon(
                    Icons.location_on_outlined,
                  ),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageViewController,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Currently",
                  style: textDecoration,
                ),
                Text(
                  _location,
                  style: textDecoration,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Today",
                  style: textDecoration,
                ),
                Text(
                  _location,
                  style: textDecoration,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Weekly",
                  style: textDecoration,
                ),
                Text(
                  _location,
                  style: textDecoration,
                ),
              ],
            ),
          ],
          onPageChanged: (index) {
            setState(() {
              _activePage = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue.shade900,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow.shade900,
          iconSize: 35,
          currentIndex: _activePage,
          onTap: (index) {
            _pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.watch_later),
              label: 'Currently',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.today,
                ),
                label: 'Today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'Weekly'),
          ],
        ),
      ),
    );
  }

  static const TextStyle textDecoration =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
}
