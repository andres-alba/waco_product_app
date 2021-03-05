import 'package:waco_product_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waco_product_app/pages/sign_up.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  @override
  Widget build(BuildContext context) {
    _textField(
        TextEditingController controller, String labelText, bool obscureText) {
      return Material(
        elevation: 10.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: "andresalba.com",
                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                labelText: labelText,
                labelStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              Text(
                "Sign in to Waco Services and continue",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.blue, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                "Enter your email and password below to continue to Waco Services!",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.blue, fontSize: 18),
              ),
              SizedBox(height: 50),
              _textField(emailController, 'Email', false),
              SizedBox(height: 20),
              _textField(passwordController, 'Password', true),
              SizedBox(height: 50),
              Container(
                width: 200,
                height: 40,
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                  },
                  child: Text("Sign In"),
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: 200,
                height: 40,
                child: RaisedButton(
                  elevation: 10,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                  },
                  child: Text("Sign Up"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
