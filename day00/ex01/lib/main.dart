import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool pair = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    pair ? "Hello world!" : "A simple text",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue.shade600),
                      padding: WidgetStateProperty.all<EdgeInsetsDirectional>(
                          const EdgeInsetsDirectional.symmetric(
                              vertical: 10, horizontal: 25))),
                  onPressed: () {
                    setState(() {
                      pair = !pair;
                    });
                  },
                  child: const Text(
                    'Click me',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
