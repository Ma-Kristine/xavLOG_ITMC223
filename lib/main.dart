import 'package:flutter/material.dart';
import 'initialPage.dart'; // Import your renamed file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,

      home: InitialPage(), // Load your renamed page
    );
  }
}
