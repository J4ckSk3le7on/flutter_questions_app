import 'package:flutter/material.dart';
import 'package:questions_app/question_info/model/question_info_model.dart';

class QuestionCard extends StatelessWidget {

  @required final QuestionInfoModel questionInfo;
  @required final String userEmail;

  const QuestionCard({
    this.questionInfo,
    this.userEmail
  });

  @override
  Widget build(BuildContext context) {
    if (questionInfo == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF7043)),
        ),
      );
    } else {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,25),
            child: Text(
              questionInfo.fields.quesTittle.stringValue,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 5,
            width: 225,
            color: Color(0xff9E9E9E),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,25,0,0),
            child: Text(
              questionInfo.fields.quesBody.stringValue,
              style: TextStyle(
                fontSize: 16
              ),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
    } 
  }
}