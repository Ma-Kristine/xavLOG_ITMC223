import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'home_page_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // Adjusted responsive dimensions
    final logoSize = width * 0.45;
    final buttonWidth = width * 0.30;
    final contentPadding = width * 0.02;
    final fontSize = width * 0.03; // Reduced for better scaling

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xFF132BB2),
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
            Image.asset(
              'images/fulllogo.png',
              width: logoSize,
              height: logoSize,
            ),
            SizedBox(height: height * 0.02),
            Expanded(
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
                          // Email field
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
                            ),
                          ),
                          SizedBox(height: height * 0.02), // Reduced spacing between fields
                          // Password field
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
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => isLoginHovered = true),
                        onExit: (_) => setState(() => isLoginHovered = false),
                        child: GestureDetector(
                          onTap: () {
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
                      // Create account row
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

class TrianglePeekClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Make triangle height responsive
    double triangleHeight = size.height * 0.15; // 15% of container height
    double triangleWidth = size.width;
    double startY = triangleHeight;

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
