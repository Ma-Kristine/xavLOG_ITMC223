/// Login Page
/// 
/// Purpose: Allows existing users to log in to their xavLog accounts
/// 
/// Flow:
/// 1. User enters their email and password
/// 2. User clicks "Log-in" button to authenticate
/// 3. Upon successful authentication, user is directed to their dashboard
/// 4. Users without accounts can navigate to sign-up page
/// 
/// Backend Implementation Needed:
/// - User authentication against database
/// - Password hashing and verification
/// - Session token generation and management
/// - Failed login attempt handling and account lockout
/// - Password recovery option (future enhancement)
library;

import 'package:flutter/material.dart';
import 'signin_page.dart';
import '../dash_board/home_page_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // UI state variables for interactive elements
  bool isLoginHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // Calculate responsive dimensions based on screen size
    final logoSize = width * 0.45; // Logo size is 45% of screen width
    final buttonWidth = width * 0.30; // Button width is 30% of screen width
    final contentPadding = width * 0.02; // Padding is 2% of screen width
    final fontSize = width * 0.03; // Font size scales with screen width

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // Xavier blue background color
        decoration: const BoxDecoration(
          color: Color(0xFF132BB2),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            // Logo at the top of the page
            Image.asset(
              'images/fulllogo.png',
              width: logoSize,
              height: logoSize,
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              // Triangle-peeked white container for login form
              child: ClipPath(
                clipper: TrianglePeekClipper(),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(width * 0.01),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: height * 0.02),
                      // Login page title
                      Text(
                        'Log-in',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 16, 16, 16),
                          fontSize: fontSize * 2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Email input field
                          SizedBox(
                            width: buttonWidth * 2,
                            child: TextField(
                              style: TextStyle(fontSize: fontSize * 1.2),
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: TextStyle(fontSize: fontSize * 1.2),
                                suffixIcon: Icon(
                                  Icons.email,
                                  size: fontSize * 1.4,
                                ),
                              ),
                              // BACKEND TODO: Implement email validation and checking against database
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          // Password input field with visibility toggle
                          SizedBox(
                            width: buttonWidth * 2,
                            child: TextField(
                              style: TextStyle(fontSize: fontSize * 1.2),
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(fontSize: fontSize * 1.2),
                                suffixIcon: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => setState(() => 
                                      isPasswordVisible = !isPasswordVisible
                                    ),
                                    child: Icon(
                                      isPasswordVisible 
                                          ? Icons.visibility 
                                          : Icons.visibility_off,
                                      size: fontSize * 1.4,
                                    ),
                                  ),
                                ),
                              ),
                              // BACKEND TODO: Implement password verification
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      // Login button with hover effect
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => isLoginHovered = true),
                        onExit: (_) => setState(() => isLoginHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            // BACKEND TODO: Implement login authentication logic
                            // - Validate credentials against database
                            // - Generate and store auth token
                            // - Handle failed login attempts
                            // - Track login activity for security
                            
                            // Navigate to user dashboard after successful login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: buttonWidth * 2,
                            padding: EdgeInsets.all(contentPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.01),
                              // Gold gradient for button
                              gradient: LinearGradient(
                                colors: [
                                  isLoginHovered
                                      ? const Color.fromARGB(255, 244, 202, 86)
                                      : const Color(0xFFBFA547),
                                  isLoginHovered
                                      ? const Color.fromARGB(255, 244, 202, 86)
                                      : const Color(0xFFBFA547),
                                ],
                              ),
                            ),
                            child: Text(
                              'Log-in',
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: fontSize * 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Helper text for users
                      Text(
                        'Please use your assigned GBOX account to Log-in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      // Sign-up option for new users
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account yet? ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // "Create now" link with hover effect
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => isTermsHovered = true),
                            onExit: (_) => setState(() => isTermsHovered = false),
                            child: GestureDetector(
                              onTap: () => _showCreateAccountDialog(context, fontSize),
                              child: Text(
                                'Create now',
                                style: TextStyle(
                                  color: isTermsHovered 
                                      ? const Color(0xFFD7A61F)
                                      : const Color.fromARGB(255, 16, 16, 16),
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * Shows a confirmation dialog for creating a new account
   * 
   * @param context The BuildContext for showing the dialog
   * @param fontSize The font size to use for consistent UI
   */
  void _showCreateAccountDialog(BuildContext context, double fontSize) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Create Account',
            style: TextStyle(
              color: const Color(0xFF071D99),
              fontWeight: FontWeight.bold,
              fontSize: fontSize * 1.5,
            ),
          ),
          content: Text(
            'Do you want to create a new account?',
            style: TextStyle(fontSize: fontSize),
          ),
          actions: [
            // "Yes" button - navigates to sign-in/registration page
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninPage(),
                  ),
                );
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: const Color(0xFF071D99),
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
            // "No" button - closes the dialog
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: const Color(0xFF071D99),
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/**
 * Custom Clipper for Triangle Peek Design
 * 
 * Creates a custom shape for the login container with a triangular
 * peek at the top, matching the design of the sign-in page for consistency.
 */
class TrianglePeekClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Calculate responsive triangle dimensions
    double triangleHeight = size.height * 0.15; // 15% of container height
    double triangleWidth = size.width;
    double startY = triangleHeight;

    // Create the path with a triangle at the top
    path.moveTo(0, startY);
    path.lineTo(triangleWidth / 2, 0);
    path.lineTo(triangleWidth, startY);
    path.lineTo(triangleWidth, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
