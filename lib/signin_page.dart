import 'package:flutter/material.dart';
import 'account_choose.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  //boolean variables for hover effect
  bool isSignInHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration( //background color
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF132BB2),
                Color(0xFF132BB2),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
            )
          ),
          child: Column(
            children: [ //list of children
              Container( //box of first row
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 140),
                child: Row( //first row, logo and name
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('images/xavloglogo.png', fit: BoxFit.contain),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'xavLog',
                          style: TextStyle(
                            color: Color(0xFFD7A61F),
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Jost',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Your Campus Tether',  // Add your desired phrase here, if we are still going to change it or what
                          style: TextStyle(
                            color: Color(0xFFD7A61F),
                            fontFamily: 'Jost',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ), //end of first row
              SizedBox(height: 60),
              Container( //second row, sign-in form or sig-in box
                width: 325,
                height: 480,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column( // sig-in heading, email, password, sign-in button, footer
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text('Sign-in',
                      style: TextStyle(
                        color: Color(0xFF071D99),
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
              
                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          suffixIcon: Icon(Icons.email, 
                          size: 17,),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: !isPasswordVisible, //toggle visibility based on state
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: MouseRegion( //icon for password visibility
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible; //toggle visibility
                                });
                              },
                              child: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off, //condition for icon if visible or not
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    MouseRegion( //sign-in button, for hover effect
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => isSignInHovered = true),
                      onExit: (_) => setState(() => isSignInHovered = false),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountChoosePage(),
                            ),
                          );
                        },
                        child: Container( //box of sign-in button
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                isSignInHovered ? Color(0xFF0529CC) : Color(0xFF071D99),//if-else statement
                                isSignInHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                              ]
                              )
                          ),
                          child: Padding( //text of sign-in button
                            padding: EdgeInsets.all(12),
                            child: Text('Sign In',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container( //gbox account prompt text
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Please use your assigned GBOX account to sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Row( //row of terms and conditions and FAQs
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion( //upon clicking, will show terms and conditions pop-up
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => isTermsHovered = true),
                          onExit: (_) => setState(() => isTermsHovered = false),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Terms & Conditions'),
                                    content: Text('Terms and Conditions Stuff'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text( //terms and conditions text
                              'Terms & Conditions',
                              style: TextStyle(
                                color: isTermsHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        Text( //bar to separate terms and conditions and FAQs
                          ' | ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        MouseRegion( //upon clicking, will show FAQs pop-up
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => isFAQsHovered = true),
                          onExit: (_) => setState(() => isFAQsHovered = false),
                          child: GestureDetector( //pop-up for FAQs
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('FAQs',
                                      style: TextStyle(
                                        color: Color(0xFF071D99),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [ //List of FAQs
                                          _buildFaqSection('General Questions', [
                                            {'Q': 'What is xavLOG?', 
                                             'A': 'xavLOG is a mobile and web application designed for Ateneo de Naga University (ADNU) students. It helps them track their academic progress, manage schedules, join social study groups, find campus events, and buy or sell items in the campus marketplace.'},
                                            {'Q': 'Who can use xavLOG?', 
                                             'A': 'xavLOG is exclusively for ADNU students. You must have a valid ADNU student account to sign up and use the app.'},
                                            {'Q': 'Is xavLOG free to use?', 
                                             'A': 'Yes! All xavLOG features, including the grade tracker, attendance tracker, and social collaboration tools, are free for ADNU students.'},
                                            {'Q': 'What platforms is xavLOG available on?', 
                                             'A': 'xavLOG is available as a mobile app (Android and iOS) and a web application that you can access through your browser.'},
                                          ]),
                                          _buildFaqSection('Academic Features', [
                                            {'Q': 'How does the Grade Tracker work?', 
                                             'A': 'Students manually input their scores for tasks, quizzes, and exams. The system automatically computes their current standing based on the weights of each assessment type.'},
                                             {'Q': 'Can I edit my grades after inputting them?', 
                                             'A': 'Yes, you can modify or update your grades at any time. However, xavLOG does not replace the official grading system of ADNU; it only helps students monitor their academic progress.'},
                                             {'Q': 'How does the Attendance Tracker function?', 
                                             'A': 'Students manually log their attendance for each subject. The system records the attendance history and provides insights into attendance trends.'},
                                             {'Q': 'Does xavLOG calculate my final grade for the semester?', 
                                             'A': 'xavLOG provides an estimated grade standing based on the inputs you provide. However, your official grades will still come from ADNU\'s grading system.'},
                                            //ADD OTHER QUESTION IF NALAYOUT NA
                                          ]),
                                          _buildFaqSection('Social and Engagement Features', [
                                            {'Q': 'How do social groups work?', 
                                             'A': 'Students can create or join study groups within the app. These groups allow students to collaborate on assignments, discuss lessons, and share academic resources.'},
                                             {'Q': 'Can I create private study groups?', 
                                             'A': 'Yes, study groups can be public or private, depending on the group creator\'s settings.'},
                                             {'Q': 'What is the Event Finder?', 
                                             'A': 'The Event Finder helps students discover university events, such as academic seminars, club activities, and student-led initiatives.'},
                                             {'Q': 'How do I join an event?', 
                                             'A': 'You can mark yourself as "Interested" or "Attending" on an event page. Event organizers may also provide registration links if necessary.'},
                                            //ADD OTHER QUESTION IF NALAYOUT NA
                                          ]),
                                          // Add other sections similarly
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Close',
                                          style: TextStyle(
                                            color: Color(0xFF071D99),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text( //text of FAQs
                              'FAQs',
                              style: TextStyle(
                                color: isFAQsHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],//end of children list
          ),
        )
      )
    );
  } //Build widget

  Widget _buildFaqSection(String title, List<Map<String, String>> faqs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF071D99),
            ),
          ),
        ),
        ...faqs.map((faq) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(faq['Q']!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(faq['A']!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ))
      ],
    );
  }
} // Whole class of SigninPage
