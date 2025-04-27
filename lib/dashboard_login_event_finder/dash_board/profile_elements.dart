import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/dashboard_login_event_finder/dash_board/home_page_dashboard.dart';
import 'package:xavlogsigninpage/dashboard_login_event_finder/login/login_page.dart';

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
                  // Add back button at the top
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20,
                      left: 20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFD7A61F),
                          size: 24,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Logo section
                  Container(
                    width: 360, // Fixed container width
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset(
                            'images/xavloglogo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'xavLog',
                              style: TextStyle(
                                color: Color(0xFFD7A61F),
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Jost',
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Your Campus Tether',
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
                  ),
                  // Profile form container
                  SizedBox(height: 20),
                  Container(
                    width: 320, // Fixed width
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Student\'s Profile',
                          style: TextStyle(
                            color: Color(0xFF071D99),
                            fontSize: 20, // Fixed font size
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
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
                        SizedBox(height: 40),
                        // Next button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                ),
                              );
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
