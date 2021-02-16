import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff757575),
      title: Text("Questions and Answers",
        style: TextStyle(
          fontFamily: "Blackboard"
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {_showSnackBar();},
          iconSize: 32,
          icon: Icon(Icons.android,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  void _showSnackBar() {
    Scaffold.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: new Text("Developed by Jorge Greñas with Love <3"),
      width: 350.0,
      duration: Duration(seconds: 4, milliseconds: 500),
    ));
  }

}