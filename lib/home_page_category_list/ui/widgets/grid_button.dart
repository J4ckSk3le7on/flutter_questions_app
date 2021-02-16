import 'package:flutter/material.dart';
import 'package:questions_app/questions_list/ui/question_list_page.dart';

class BotonGrid {
  Widget botton(context, boxColor, String categoryName, String userEmail) {
    return GestureDetector(
      child: Container(
        height: 65,
        width: 190,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: Text(categoryName, 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17
            ),
          )
        ),
      ),
      onTap:() {Navigator.push(context, 
        MaterialPageRoute(builder: (context) => QuestionsList(
          categoryName: categoryName.toLowerCase(),
          userEmail: userEmail,
        )
      ));},
    );
  }
}