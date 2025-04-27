import 'package:flutter/material.dart';
import 'home_page_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Removes debug banner
      title: 'xavLog Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF071D99)),
        primaryIconTheme: const IconThemeData(color: Color(0xFF071D99)),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}