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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration( //background color
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF132BB2),
                Color(0xFF132BB2),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
            )
          ),
          child: Column(
            children: [ //list of children
              Container( //box of first row
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 140),
                child: Row( //first row, logo and name
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
                            fontFamily: 'Jost',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ), //end of first row
              SizedBox(height: 60),
              Container( //second row, sign-in form or sig-in box
                width: 325,
                height: 480,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column( // sig-in heading, email, password, sign-in button, footer
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text('Sign-in',
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
                          suffixIcon: Icon(Icons.email, 
                          size: 17,),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        obscureText: !isPasswordVisible, //toggle visibility based on state
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: MouseRegion( //icon for password visibility
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible; //toggle visibility
                                });
                              },
                              child: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off, //condition for icon if visible or not
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    MouseRegion( //sign-in button, for hover effect
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
                        child: Container( //box of sign-in button
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                isSignInHovered ? Color(0xFF0529CC) : Color(0xFF071D99),//if-else statement
                                isSignInHovered ? Color(0xFF0529CC) : Color(0xFF071D99),
                              ]
                              )
                          ),
                          child: Padding( //text of sign-in button
                            padding: EdgeInsets.all(12),
                            child: Text('Sign In',
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
                    SizedBox(height: 30,),
                    Container( //gbox account prompt text
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
                    Row( //row of terms and conditions and FAQs
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text( //bar to separate terms and conditions and FAQs
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
                                              builder: (context) => SigninPage(),  // Navigate to SigninPage
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
            ],//end of children list
          ),
        )
      )
    );
  } //Build widget

} // Whole class of LoginPage
