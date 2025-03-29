import 'package:flutter/material.dart';
import 'package:xavlogdashboard/main.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class Mainpagedashboard extends StatelessWidget {
  const Mainpagedashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Homepage(),
    );
  }
}