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
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // Calculate responsive dimensions
    final logoSize = width * 0.45; // 45% of screen width

    final contentPadding = width * 0.02; // 2% of screen width
    final fontSize = width * 0.03; 
    final backButtonSize = width * 0.07; // 7% of screen width

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: height,
              ),
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF132BB2),
                    Color(0xFFD7A61F),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Back button
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + contentPadding,
                      left: contentPadding,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: const Color(0xFFD7A61F),
                          size: backButtonSize, // Increased back button size
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Logo section with adjusted spacing
                  Center(
                    child: Image.asset(
                      'images/fulllogo.png',
                      width: logoSize,
                      height: logoSize,
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.9, // Adjusted container width
                    margin: EdgeInsets.symmetric(vertical: contentPadding * 2),
                    padding: EdgeInsets.all(contentPadding * 2.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Student\'s Profile',
                          style: TextStyle(
                            color: const Color(0xFF071D99),
                            fontSize: fontSize * 1.8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        // Form fields with adjusted sizes
                        ...[
                          'First Name',
                          'Last Name',
                          'Student ID',
                          'Department',
                          'Program of Study',
                        ].map((label) => Padding(
                          padding: EdgeInsets.only(bottom: height * 0.02),
                          child: TextField(
                            style: TextStyle(fontSize: fontSize * 1.2),
                            decoration: InputDecoration(
                              labelText: label,
                              labelStyle: TextStyle(fontSize: fontSize * 1.2),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: contentPadding,
                                vertical: contentPadding * 0.8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF071D99),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        )),
                        // Next button with adjusted size
                        SizedBox(height: height * 0.03),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: height * 0.05, // Increased height
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF071D99), Color(0xFF071D99)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize * 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        // Change Account link
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _isHovered = true),
                          onExit: (_) => setState(() => _isHovered = false),
                          child: GestureDetector(
                            onTap: () => _showChangeAccountDialog(context),
                            child: Text(
                              'Change Account',
                              style: TextStyle(
                                color: _isHovered 
                                    ? const Color(0xFFD7A61F) 
                                    : const Color(0xFF071D99),
                                fontSize: fontSize * 1.2,
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

  // Helper method for the dialog
  void _showChangeAccountDialog(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.012;
    
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Change Account',
          style: TextStyle(
            fontSize: fontSize * 1.8,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF071D99),
          ),
        ),
        content: Text(
          'Are you sure you want to change account?',
          style: TextStyle(fontSize: fontSize * 1.2),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: fontSize * 1.2,
                color: const Color(0xFF071D99),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: fontSize * 1.2,
                color: const Color(0xFFD7A61F),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
