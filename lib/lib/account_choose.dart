import 'package:flutter/material.dart';
import 'package:xavlogsigninpage/signin_page.dart';
import 'profile_elements.dart';

class AccountChoosePage extends StatefulWidget {
  const AccountChoosePage({super.key});
  @override
  State<AccountChoosePage> createState() => _AccountChoosePageState();
}

class _AccountChoosePageState extends State<AccountChoosePage> {
  //boolean variables for hover effect
  bool isSignInHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
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
                    Color(0xFF132BB2),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: constraints.maxHeight * 0.15),
                    child: Row(
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
                              'Your Campus Tether',  // Add your desired phrase here
                              style: TextStyle(
                                color: Color(0xFFD7A61F),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.07),
                  Container(
                    width: constraints.maxWidth * 0.9,
                    constraints: BoxConstraints(
                      maxWidth: 360,
                      minHeight: constraints.maxHeight * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'What kind of account are you signing in with?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF071D99),
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        _buildAccountButton(
                          'Student Account',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileElementsPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        _buildAccountButton(
                          'Organization Account',
                          () {
                            Text('Organization Account');
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => setState(() => isTermsHovered = true),
                        onExit: (_) => setState(() => isTermsHovered = false),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Back to Sign-in'),
                                  content: Text('Are you sure you want to go back to sign-in page?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Close dialog
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Just close dialog
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                          color: Color(0xFF071D99),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccountButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 280,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
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
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Jost',
          ),
        ),
      ),
    );
  }
}
