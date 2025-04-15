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
      home: AddSubjectScreen(),
    );
  }
}

class AddSubjectScreen extends StatefulWidget {
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  bool showOverlay = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(Icons.menu),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
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
            toolbarHeight: 60.0,
          ),
          body: Stack(
            children: [
              // Decorative Ellipses
              Positioned(
                top: MediaQuery.of(context).size.height * 0.33,
                left: MediaQuery.of(context).size.width * 0.30,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2CB4EC),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.14,
                left: -MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE14B5A),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.09,
                left: MediaQuery.of(context).size.width * 0.53,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEFB924),
                  ),
                ),
              ),
              Column(
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
              Positioned(
                bottom: 40.0,
                right: 20.0,
                child: Material(
                  elevation: 6.0,
                  shape: CircleBorder(),
                  color: Color(0xFF283AA3),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showOverlay = true;
                      });
                    },
                    child: Container(
                      width: 68.0,
                      height: 68.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 34.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Overlay covering appBar and body
        if (showOverlay)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showOverlay = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 375,
                        height: 380,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildInputField("Subject Code*"),
                              SizedBox(height: 18),
                              buildInputField("Subject Title"),
                              SizedBox(height: 18),
                              buildInputField("Units*"),
                              SizedBox(height: 18),
                              buildInputField("Description", isLarge: true),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0,
                        right: 17.0,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 21.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Widget buildInputField(String hintText, {bool isLarge = false}) {
  return Container(
    width: 323,
    height: isLarge ? 90.9 : 48.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 217, 217, 219),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          hintText,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF475569),
          ),
        ),
      ),
    ),
  );
}
