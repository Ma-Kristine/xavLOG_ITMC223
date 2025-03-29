import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/login_page.dart';

class ProfileElementsPage extends StatefulWidget {
  const ProfileElementsPage({super.key});
  @override
  State<ProfileElementsPage> createState() => _ProfileElementsPageState();
}

class _ProfileElementsPageState extends State<ProfileElementsPage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              // Minimum height ensures content is scrollable on smaller screens
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF132BB2),
                    Color(0xFF132BB2),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Logo section
                  Padding(
                    padding: EdgeInsets.only(top: 140),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: constraints.maxWidth * 0.12,
                          width: constraints.maxWidth * 0.12,
                          child: Image.asset('images/xavloglogo.png', fit: BoxFit.contain),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.02),
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
                                fontSize: constraints.maxWidth * 0.06,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Your Campus Tether',
                              style: TextStyle(
                                color: Color(0xFFD7A61F),
                                fontFamily: 'Jost',
                                fontSize: constraints.maxWidth * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Profile form container
                  Container(
                    width: constraints.maxWidth * 0.7,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.03,
                      horizontal: constraints.maxWidth * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: Color(0xFF071D99),
                            fontSize: constraints.maxWidth * 0.05,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        // Form fields
                        ...[
                          'First Name',
                          'Last Name',
                          'Student ID',
                          'Department',
                          'Program of Study',
                        ].map((label) => Padding(
                          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.02),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: label,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        // Next button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              //Add navigation to next page here when combined already, welcome page or dashboard
                            },
                            child: Container(
                              width: double.infinity,
                              height: constraints.maxHeight * 0.05,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF071D99), Color(0xFF071D99)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        // Change Account link
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _isHovered = true),
                          onExit: (_) => setState(() => _isHovered = false),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('Change Account'),
                                  content: Text('Are you sure you want to change account?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      ),
                                      child: Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'Change Account',
                              style: TextStyle(
                                color: _isHovered ? Color(0xFFD7A61F) : Color(0xFF071D99),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
