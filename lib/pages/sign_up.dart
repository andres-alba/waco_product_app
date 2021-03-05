import 'package:flutter/material.dart';
import 'package:waco_product_app/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final snackBar = SnackBar(content: Text('Passwords do not match!'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              Text(
                "Sign Up to Waco Services!!",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.blue, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                "Enter an email and password below to create an Account!",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.blue, fontSize: 14),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                ),
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                onPressed: () {
                  if (confirmPassword() == true) {
                    context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text("Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool confirmPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }
}
