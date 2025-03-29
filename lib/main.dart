import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/signin_page.dart';

/* Authored by: Arsent Bico
Company: ASCEND
Project: xavLog
Feature: [XLG-001] Registration Page
Description: 
  This page will serve as the initial registration page/sign-in page for the xavLog application.
  The page will contain the following elements:
    - Logo of the application
    - Application name
    - Sign-in form
      - Email Address field
      - Password field
      - Sign-in button
    - Footer
      - Terms & Conditions
      - FAQs
  The page will be styled with the following:
    - Background color: #D7A61F
    - Logo: xavLog logo
    - Application name: xavLog
    - Sign-in form: White background with 10px border radius
    - Sign-in button: Gradient background with white text color
    - Footer: Terms & Conditions and FAQs will be clickable and styled with underline
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xavLog',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        fontFamily: 'Jost',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Jost'),
          bodyMedium: TextStyle(fontFamily: 'Jost'),
          titleLarge: TextStyle(fontFamily: 'Jost'),
          titleMedium: TextStyle(fontFamily: 'Jost'),
          labelLarge: TextStyle(fontFamily: 'Jost'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SigninPage(),
    );
  }
}

