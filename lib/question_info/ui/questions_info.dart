import 'package:flutter/material.dart';
import 'package:questions_app/edit_question/ui/edit_question.dart';
import 'package:questions_app/publish_answer/ui/publish_answer.dart';
import 'package:questions_app/global_widgets/custom_global_appBar.dart';
import 'package:questions_app/question_info/model/question_info_model.dart';
import 'package:questions_app/question_info/provider/question_info_provider.dart';
import 'package:questions_app/question_info/ui/widgets/question_answers_card.dart';
import 'package:questions_app/question_info/ui/widgets/question_card.dart';

class QuestionInfoPage extends StatefulWidget {

  @required final String questionID;
  @required final String questionCategory;
  @required final String userEmail;

  QuestionInfoPage({
    this.questionCategory,
    this.questionID,
    this.userEmail
  });

  @override
  _QuestionInfoPageState createState() => _QuestionInfoPageState();
}

class _QuestionInfoPageState extends State<QuestionInfoPage> {

  QuestionInfoModel questionInfo;

  @override
  void initState() { 
    super.initState();
    QuestionInfoProvider().getQuestionInfo(widget.questionID).then((questionFromServer) {
      setState(() {
        questionInfo = questionFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      floatingActionButton: GestureDetector(
        onTap: () {Navigator.push(context, 
          MaterialPageRoute(builder: (context) => PublishAnswer(
            questionInfo: questionInfo,
            questionCategory: widget.questionCategory,
            userEmail: widget.userEmail
          )
        ));},
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFF7043),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffFF7043))
          ),
          height: 35,
          width: 90,
          child: Center(
            child: Text("Answer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomGlobalAppBar(
          tittle: widget.questionCategory.toUpperCase(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuestionCard(
            questionInfo: questionInfo,
            userEmail: widget.userEmail
          ),
          editQuestionButton(),
          Expanded(
            child: QuestionAnswersCard(
              questionCategory: widget.questionCategory,
              questionInfo: questionInfo,
              userEmail: widget.userEmail,
            ),
          ),
        ],
      ),
    );
  }

  Widget editQuestionButton() {
    if (questionInfo == null) {
      return SizedBox(
        height: 50,
      );
    }
    if (questionInfo.fields.quesCreator.stringValue == widget.userEmail) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5,0,0,0),
        child: GestureDetector(
          onTap: () {Navigator.push(context, 
            MaterialPageRoute(builder: (context) => EditQuestion(
              userEmail: widget.userEmail,
              questionID: questionInfo.fields.quesId.integerValue.toString(),
              questionRoute: widget.questionID,
              quesCategory: widget.questionCategory,
            )
          ));},
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffFF7043),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xffFF7043))
            ),
            height: 30,
            width: 55,
            child: Center(
              child: Text("Edit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
            ),
          )
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5,0,0,0),
        child: Text(
          "By: " + questionInfo.fields.quesCreator.stringValue 
        ),
      );
    }
  }

}