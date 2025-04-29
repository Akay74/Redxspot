import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'hot_alerts_screen.dart';
import './widgets/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
