import 'package:flutter/material.dart';

class SignInLogo extends StatelessWidget {
  const SignInLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        color: Color(0xffFF7043),
        shape: BoxShape.circle
      ),
      child: Center(
        child: Text("¿¡",
        textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 100
          ),
        ),
      )
    );
  }
}
