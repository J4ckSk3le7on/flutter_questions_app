import 'package:flutter/material.dart';
import 'package:questions_app/publish_answer/ui/widgets/answers_info_form.dart';
import 'package:questions_app/global_widgets/custom_global_appBar.dart';
import 'package:questions_app/question_info/model/question_info_model.dart';

class PublishAnswer extends StatefulWidget {

  @required final QuestionInfoModel questionInfo;
  @required final String questionCategory;
  @required final String userEmail;
  
  PublishAnswer({
    this.questionInfo,
    this.questionCategory,
    this.userEmail
  });

  @override
  _PublishAnswerState createState() => _PublishAnswerState();
}

class _PublishAnswerState extends State<PublishAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomGlobalAppBar(
          tittle: "Answer Question",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnswerinfoForm(
                questionInfo: widget.questionInfo,
                questionCategory: widget.questionCategory,
                userEmail: widget.userEmail,
              ),
            ],
          )
        ),
      ),
    );
  }
}