import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/login_page.dart';
import 'account_choose.dart';
import 'terms_and_conditions.dart';
import 'faqs.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});
  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // Boolean variables for hover effects
  bool isSignInHovered = false;
  bool isLoginHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // Adjusted dimensions for better fit
    final logoSize = width * 0.45; 
    final buttonWidth = width * 0.30; 
    final contentPadding = width * 0.02;
    final fontSize = width * 0.03; 

    return Scaffold(
      body: Container(
        width: width,
        height: height,
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
            SizedBox(height: height * 0.02),
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
                      SizedBox(height: height * 0.05),
                      Text(
                        'Sign-in',
                        style: TextStyle(
                          color: const Color(0xFF071D99),
                          fontSize: fontSize * 2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
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
                      SizedBox(height: height * 0.03),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => isSignInHovered = true),
                        onExit: (_) => setState(() => isSignInHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AccountChoosePage(),
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
                                  isSignInHovered
                                      ? const Color(0xFF3352DF)
                                      : const Color(0xFF071D99),
                                  isSignInHovered
                                      ? const Color(0xFF3352DF)
                                      : const Color(0xFF071D99),
                                ],
                              ),
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: fontSize * 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        'Please use your assigned GBOX account to sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => isLoginHovered = true),
                          onExit: (_) => setState(() => isLoginHovered = false),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Log-in to my account',
                              style: TextStyle(
                                color: isLoginHovered
                                    ? const Color(0xFFD7A61F)
                                    : const Color(0xFF071D99),
                                fontSize: fontSize * 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => isTermsHovered = true),
                            onExit: (_) => setState(() => isTermsHovered = false),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsAndConditions(),
                                  ),
                                );
                              },
                              child: Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                  color: isTermsHovered
                                      ? const Color(0xFF0529CC)
                                      : const Color(0xFF071D99),
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ' | ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => isFAQsHovered = true),
                            onExit: (_) => setState(() => isFAQsHovered = false),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const FAQs(),
                                  ),
                                );
                              },
                              child: Text(
                                'FAQs',
                                style: TextStyle(
                                  color: isFAQsHovered
                                      ? const Color(0xFF0529CC)
                                      : const Color(0xFF071D99),
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
