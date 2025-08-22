import 'package:flutter/material.dart';
import 'package:flutter_application_1/examples/value_notifier_counter_screen.dart';
import 'package:flutter_application_1/pages/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
