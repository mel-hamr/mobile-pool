import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_v2_proj/provider/my_provider.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({super.key, required this.pageViewController});
  final PageController pageViewController;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue.shade900,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.yellow.shade900,
      iconSize: 35,
      currentIndex: context.watch<MyProvider>().activePage,
      onTap: (index) {
        if (Provider.of<MyProvider>(context, listen: false).isConnected == true)
          pageViewController.animateToPage(index,
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
    );
  }
}
