import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/profile_organization.dart';
import 'package:xavlogsigninpage/signin_page.dart';
import 'student_profile_elements.dart';

class AccountChoosePage extends StatefulWidget {
  const AccountChoosePage({super.key});
  @override
  State<AccountChoosePage> createState() => _AccountChoosePageState();
}

class _AccountChoosePageState extends State<AccountChoosePage> {
  // Add a variable to track selected account type
  String? selectedAccount;

  //boolean variables for hover effect
  bool isSignInHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

     // Calculate responsive dimensions
    final logoSize = width * 0.45; // 45% of screen width
    final buttonWidth = width * 0.30; // 20% of screen width
    final contentPadding = width * 0.01; // 2% of screen width
    final fontSize = width * 0.03; 

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: constraints.maxHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.03),
                        Center( //XAVLOG LOGO
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: contentPadding * 2),
                          child: Text(
                            'What kind of account are you signing in with?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF071D99),
                              fontSize: fontSize * 1.8,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        _buildRadioOption(
                          'Student Account',
                          'student',
                          fontSize * 1.5,
                          contentPadding,
                        ),
                        SizedBox(height: height * 0.02),
                        _buildRadioOption(
                          'Organization Account',
                          'organization',
                          fontSize * 1.5,
                          contentPadding,
                        ),
                        SizedBox(height: height * 0.05),
                        SizedBox(
                          width: buttonWidth,
                          child: ElevatedButton(
                            onPressed: selectedAccount == null
                                ? null
                                : () {
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
                              backgroundColor: Color(0xFFD7A61F),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.black,
                              elevation: 5,
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
                        SizedBox(height: height * 0.08), // space after next button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (event) => setState(() => isTermsHovered = true),
                          onExit: (event) => setState(() => isTermsHovered = false),
                          child: GestureDetector(
                            onTap: () {
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
                                          Navigator.pop(context);
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
                                        onPressed: () => Navigator.pop(context),
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
                        SizedBox(height: height * 0.03), // Add bottom spacing
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
            color: Color(0xFF071D99),
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        groupValue: selectedAccount,
        activeColor: Color(0xFFD7A61F),
        onChanged: (String? value) {
          setState(() {
            selectedAccount = value;
          });
        },
      ),
    );
  }
}
