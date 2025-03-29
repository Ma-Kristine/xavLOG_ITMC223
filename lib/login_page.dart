import 'package:flutter/material.dart';
import 'account_choose.dart';
import 'signin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignInHovered = false;
  bool isTermsHovered = false;
  bool isFAQsHovered = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
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
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ClipPath(
                  clipper: TrianglePeekClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                        Text(
                          'Log-in',
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
                              suffixIcon: Icon(
                                Icons.email,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  child: Icon(
                                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        MouseRegion(
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
                            child: Container(
                              alignment: Alignment.center,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    isSignInHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                                    isSignInHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Log In',
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
                        SizedBox(height: 30),
                        Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account yet?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5),
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
                                        title: Text(
                                          'Create Account',
                                          style: TextStyle(
                                            color: Color(0xFF071D99),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text('Do you want to create a new account?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
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
                                              Navigator.pop(context);
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
                                  'Create now',
                                  style: TextStyle(
                                    color: isTermsHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrianglePeekClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    
    double triangleHeight = 130.0;
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
