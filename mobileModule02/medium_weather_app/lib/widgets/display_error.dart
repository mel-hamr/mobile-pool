import 'package:flutter/material.dart';

class DisplayError extends StatelessWidget {
  const DisplayError({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          error,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
