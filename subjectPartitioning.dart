import 'package:flutter/material.dart';

class SubjectPartitioningScreen extends StatelessWidget {
  final String subjectName; // Receive subject name

  const SubjectPartitioningScreen({Key? key, required this.subjectName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subjectName)), // Show subject name in the title
      body: Center(
        child: Text(
          'Partitioning for $subjectName',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
