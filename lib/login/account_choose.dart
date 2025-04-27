/// Account Choose Page
/// 
/// Purpose: Allows users to select between student or organization account types
/// 
/// Flow: 
/// 1. User navigates here from the sign-in page
/// 2. User selects their account type
/// 3. Based on selection, user is directed to the appropriate profile setup page
/// 
/// Backend Implementation Needed:
/// - Account type selection should be saved to user profile in database
/// - Authentication state should persist between screens
/// - User role-based permissions system should be implemented
library;

import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/dash_board/orgaccount_setup.dart';
import 'package:xavlogsigninpage/login/signin_page.dart';
import '../dash_board/student_profile_elements.dart';

class AccountChoosePage extends StatefulWidget {
  // Constructor with optional key parameter
  const AccountChoosePage({super.key});
  
  @override
  State<AccountChoosePage> createState() => _AccountChoosePageState();
}

class _AccountChoosePageState extends State<AccountChoosePage> {
  // Track which account type the user has selected
  String? selectedAccount;

  // Boolean variables for UI hover effects
  bool isSignInHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get device screen dimensions for responsive design
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // Calculate responsive dimensions based on screen size
    final logoSize = width * 0.45; // 45% of screen width
    final buttonWidth = width * 0.30; // 30% of screen width
    final contentPadding = width * 0.01; // 1% of screen width for padding
    final fontSize = width * 0.03; // Dynamic font size based on screen width

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              // Ensure container fills at least the screen height
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              width: MediaQuery.of(context).size.width,
              // Gradient background from blue to gold (Xavier colors)
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF132BB2), // Blue
                    Color(0xFFD7A61F), // Gold
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Logo container at the top
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: constraints.maxHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.03),
                        // XavLog logo centered
                        Center(
                          child: Image.asset(
                            'images/fulllogo.png',
                            width: logoSize,
                            height: logoSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  // Main white container for account selection
                  Container(
                    width: constraints.maxWidth * 0.9,
                    constraints: BoxConstraints(
                      maxWidth: height,
                      minHeight: constraints.maxHeight * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.03),
                        // Title text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: contentPadding * 2),
                          child: Text(
                            'What kind of account are you signing in with?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF071D99), // Dark blue
                              fontSize: fontSize * 1.8,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        // Student account radio option
                        _buildRadioOption(
                          'Student Account',
                          'student',
                          fontSize * 1.5,
                          contentPadding,
                        ),
                        SizedBox(height: height * 0.02),
                        // Organization account radio option
                        _buildRadioOption(
                          'Organization Account',
                          'organization',
                          fontSize * 1.5,
                          contentPadding,
                        ),
                        SizedBox(height: height * 0.05),
                        // Next button - disabled until an account type is selected
                        SizedBox(
                          width: buttonWidth,
                          child: ElevatedButton(
                            onPressed: selectedAccount == null
                                ? null // Disabled if no account type selected
                                : () {
                                    // Navigate to appropriate setup page based on selection
                                    // BACKEND TODO: Save account type selection to user profile
                                    if (selectedAccount == 'student') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileElementsPage(),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileOrganization(),
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD7A61F), // Gold
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.black,
                              elevation: 5, // Add shadow
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: fontSize * 1.2,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Jost',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.08),
                        // Back to Sign-in link with hover effect
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (event) => setState(() => isTermsHovered = true),
                          onExit: (event) => setState(() => isTermsHovered = false),
                          child: GestureDetector(
                            onTap: () {
                              // Confirmation dialog before going back
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Back to Sign-in',
                                      style: TextStyle(fontSize: fontSize * 1.5),
                                    ),
                                    content: Text(
                                      'Are you sure you want to go back to sign-in page?',
                                      style: TextStyle(fontSize: fontSize * 1.2),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close dialog
                                          // Navigate back to sign-in page
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SigninPage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Color(0xFF071D99),
                                            fontSize: fontSize * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context), // Close dialog
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color: Color(0xFF071D99),
                                            fontSize: fontSize * 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Back to Sign-in',
                              style: TextStyle(
                                color: isTermsHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                                fontSize: fontSize * 1.2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
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

  /// Helper method to build a radio option with consistent styling
  /// 
  /// @param text The display text for the radio option
  /// @param value The value this option represents
  /// @param fontSize The font size to use
  /// @param contentPadding Padding amount for content
  /// @return A styled RadioListTile widget
  Widget _buildRadioOption(
    String text,
    String value,
    double fontSize,
    double contentPadding,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: contentPadding * 3),
      child: RadioListTile<String>(
        title: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Color(0xFF071D99), // Dark blue
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        groupValue: selectedAccount,
        activeColor: Color(0xFFD7A61F), // Gold when selected
        onChanged: (String? value) {
          setState(() {
            selectedAccount = value;
          });
        },
      ),
    );
  }
}
