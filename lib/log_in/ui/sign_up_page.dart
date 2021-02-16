import 'package:flutter/material.dart';

import 'package:questions_app/log_in/ui/widgets/logo.dart';
import 'package:questions_app/log_in/ui/widgets/sign_up_form.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDEDED),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SignInLogo(),
              SizedBox(height: 40,),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
