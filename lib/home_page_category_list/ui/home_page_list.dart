import 'package:flutter/material.dart';

import 'package:questions_app/home_page_category_list/ui/widgets/custom_appBar.dart';
import 'package:questions_app/home_page_category_list/ui/widgets/grid_button.dart';

class HomePage extends StatefulWidget {

  @required final String userEmail;

  HomePage({
    this.userEmail,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar()
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        padding: EdgeInsets.all(30),
        crossAxisSpacing: (30.0),
        mainAxisSpacing: 30.0,
        children: [
          BotonGrid().botton(context, Color(0xffFF7043), "Gaming",      widget.userEmail),
          BotonGrid().botton(context, Color(0xffFF7043), "Development", widget.userEmail),
          BotonGrid().botton(context, Color(0xffFF7043), "Abilities",   widget.userEmail),
          BotonGrid().botton(context, Color(0xffFF7043), "Music",       widget.userEmail),
          BotonGrid().botton(context, Color(0xffFF7043), "Locations",   widget.userEmail),
          BotonGrid().botton(context, Color(0xffFF7043), "Computers",   widget.userEmail),
          BotonGrid().botton(context, Color(0xffFF7043), "Cellphone",   widget.userEmail),
        ],
      ),
    );
  }
}