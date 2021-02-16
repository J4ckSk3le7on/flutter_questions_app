import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:questions_app/log_in/ui/sign_in_page.dart';
import 'package:questions_app/home_page_category_list/ui/home_page_list.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    
    if(firebaseUser != null) {
      return HomePage(
        userEmail: firebaseUser.email,
      );
    }
    
    return SignInPage();
  }
}