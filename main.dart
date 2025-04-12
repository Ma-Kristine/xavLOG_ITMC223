/* Authored by: Ma. Kristine R. Mien
 Company: ASCEND
 Project: xavLog
 Feature: [XLG-005] Grades Tracker
 Description: 
   This feature lets users add their subjects, define grading partitions (like exams, quizzes, etc.), and input scores to compute their grades. 
   If a partition has sub-parts (e.g., quizzes under class standing), users can break it down further. 
   The system calculates the Cumulative Final Rating Score (CFRS), letter grade, numerical grade, and overall QPI based on the data. 
   Users can add, edit, or delete partitions anytime.
  */

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Rubik'),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0), // Adjust top padding for lower position
                child: Icon(Icons.menu),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0), // Adjust top padding for lower position
                child: Text(
                  'xavLOG',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
          toolbarHeight: 60.0, // Adjust toolbar height to lower the AppBar content
        ),
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 380,
                height: 81,
                color: Color(0xFF283AA3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        'QPI',
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w600,
                          fontSize: 35.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Text(
                        '0.00',
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w600,
                          fontSize: 35.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'No Subjects',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
