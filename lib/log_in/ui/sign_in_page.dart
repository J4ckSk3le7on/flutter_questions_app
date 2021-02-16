import 'package:flutter/material.dart';

import 'package:questions_app/log_in/ui/widgets/logo.dart';
import 'package:questions_app/log_in/ui/widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}
