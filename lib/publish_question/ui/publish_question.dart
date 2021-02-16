import 'package:flutter/material.dart';
import 'package:questions_app/publish_question/ui/widgets/question_info_form.dart';
import 'package:questions_app/global_widgets/custom_global_appBar.dart';

class PublishQuestion extends StatefulWidget {
  @required final String userEmail;

  PublishQuestion({
    this.userEmail
  });

  @override
  _PublishQuestionState createState() => _PublishQuestionState();
}

class _PublishQuestionState extends State<PublishQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomGlobalAppBar(
          tittle: "Publish Question",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuestioninfoForm(
                userEmail: widget.userEmail,
              ),
            ],
          )
        ),
      ),
    );
  }
}