import 'package:flutter/material.dart';
import 'package:questions_app/edit_answer/ui/edit_answer.dart';
import 'package:questions_app/question_info/model/question_answer_model.dart';
import 'package:questions_app/question_info/model/question_info_model.dart';
import 'package:questions_app/question_info/provider/question_info_provider.dart';

class QuestionAnswersCard extends StatefulWidget {
  
  @required final String questionCategory;
  @required final QuestionInfoModel questionInfo;
  @required final String userEmail;

  QuestionAnswersCard({
    this.questionCategory,
    this.questionInfo,
    this.userEmail
  });

  @override
  _QuestionAnswersCardState createState() => _QuestionAnswersCardState();
}

class _QuestionAnswersCardState extends State<QuestionAnswersCard> {

  List<Document> allAnswers;
  Widget loadAnswers;

  @override
  void initState() { 
    super.initState();
    setState(() {
      loadAnswers = Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF7043)),
        ),
      );
    });
    Future.delayed(Duration(seconds: 2), () {
      QuestionInfoProvider().getQuestionAnswersInfo(
        widget.questionCategory,
        widget.questionInfo.fields.quesId.integerValue.toString()
      ).then((answersFromServer) {
        setState(() {
          allAnswers = answersFromServer;
        });
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Answers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ),
              Icon(Icons.arrow_downward_sharp,
                size: 30,
              ),
            ],
          ),
          Container(
            height: 5,
            width: 280,
            color: Color(0xff9E9E9E),
          ),
          Expanded(child: weHaveData())
        ],
      ),
    );
  }

  Widget weHaveData() {
    if (allAnswers == null) {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          loadAnswers = Text("No one has answered this question.");
        });
      });
      return loadAnswers;
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          backgroundColor: Color(0xffFF7043),
          color: Colors.white,
          onRefresh: _refreshList,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allAnswers.length,
            itemBuilder: (context, index) {
              return answerBuilder(
                allAnswers,
                index
              );
            },
          ),
        ),
      );
    }
  }

  Future<void> _refreshList() async {
    QuestionInfoProvider().getQuestionAnswersInfo(
      widget.questionCategory,
      widget.questionInfo.fields.quesId.integerValue.toString()
    ).then((answersFromServer) {
      setState(() {
        allAnswers = answersFromServer;
      });
    });
  }

  Widget answerBuilder(List<Document> allAnswers, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,8,0,8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xff9E9E9E))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                allAnswers[index].fields.ansBody.stringValue,
                style: TextStyle(
                  fontSize: 16
                ),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: editAnswerButton(
                allAnswers,
                index
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget editAnswerButton(List<Document> allAnswers, int index) {
    if (allAnswers == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFF7043)),
        ),
      );
    }
    if (allAnswers[index].fields.ansCreator.stringValue == widget.userEmail) {
      return GestureDetector(
        onTap: () {Navigator.push(context, 
            MaterialPageRoute(builder: (context) => EditAnswer(
              ansRoute: allAnswers[index].name.substring(66),
              userEmail: widget.userEmail,
              questionBody: widget.questionInfo.fields.quesBody.stringValue,
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
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(5,0,0,0),
        child: Text(
          "By: " + allAnswers[index].fields.ansCreator.stringValue
        ),
      );
    }
  }

}
