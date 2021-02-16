import 'package:flutter/material.dart';

class CustomGlobalAppBar extends StatefulWidget {

  @required final String tittle;

  CustomGlobalAppBar({
    this.tittle
  });

  @override
  _CustomGlobalAppBarState createState() => _CustomGlobalAppBarState();
}

class _CustomGlobalAppBarState extends State<CustomGlobalAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff757575),
      title: Text(widget.tittle,
        style: TextStyle(
          fontFamily: "Blackboard"
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        iconSize: 32,
        icon: Icon(Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

}