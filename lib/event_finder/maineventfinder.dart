/// Event Finder Main Application
/// 
/// Purpose: Entry point and configuration for the Event Finder standalone module.
/// This can be used for testing the event finder separately from the main application.
/// 
/// Backend Implementation Needed:
/// - Authentication integration when used as part of the main application
/// - Theme coordination with the main application settings
/// - Analytics tracking for event feature usage
library;

import 'package:flutter/material.dart';
import 'eventfinderpage_reg.dart';

void main() {
  // BACKEND: Should initialize analytics, crash reporting, and authentication services
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // DYNAMIC: App title should be configurable based on deployment context
      title: 'xavLog Event Finder',
      
      // DYNAMIC: Theme should be coordinated with main app theme or user preferences
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF132BB2)),
        fontFamily: 'Jost',
        useMaterial3: true,
      ),
      
      // Main event finder page as the home screen
      home: const EventFinderPage(),
      
      // DYNAMIC: Routes should be registered for deep linking
      // BACKEND: Route guards should be implemented for authentication
    );
  }
}
