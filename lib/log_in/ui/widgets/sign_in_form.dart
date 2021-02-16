import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:questions_app/log_in/provider/auth_service.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Function backAction;
  Widget optionButton;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign In",
            style: TextStyle(
              fontSize: 18
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,2,20,0),
            child: TextFormField(
              controller: emailController,
              maxLines: 1,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Enter a valid Email";
                } if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                  return "Enter a valid Email";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Email",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                      color: Color(0xffFF7043),
                      width: 1.5
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,2,20,0),
            child: TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                      color: Color(0xffFF7043),
                      width: 1.5
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              _submit();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffFF7043),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xffFF7043))
              ),
              height: 60,
              width: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                    color: Colors.white,
                  ),
                  Text("Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submit() async {
    if (_formkey.currentState.validate()) {
      context.read<AuthService>().signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
      ).then((String userFromServer) {
        print(userFromServer);
        if (userFromServer.endsWith("ed.")) {
          setState(() {
            optionButton = FlatButton(
              child: Text("Sign me up !!!",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, 'sign_up'),
            );
          });
        } else {
          setState(() {
            optionButton = FlatButton(
            child: Text("Close"),
              onPressed: () => Navigator.of(context).pop()
            );
          });
        }
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Sign In Error"),
            content: Text(userFromServer),
            actions: [
              optionButton
            ],
          )
        );
      });
    }
  }

}


