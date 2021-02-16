import 'package:flutter/material.dart';
import 'package:questions_app/question_info/ui/questions_info.dart';
import 'package:questions_app/questions_list/model/questions_model.dart';

class QuestionCard extends StatefulWidget {
  @required final String questionCategory;
  @required final int index;
  @required final List<Document> questions;
  @required final String userEmail;

  QuestionCard({
    this.questionCategory,
    this.index,
    this.questions,
    this.userEmail
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: () {Navigator.push(context, 
            MaterialPageRoute(builder: (context) => QuestionInfoPage(
              questionCategory: widget.questionCategory,
              questionID: widget.questions[widget.index].name.substring(68),
              userEmail: widget.userEmail,
            )
        ));},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18)
          ),
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(widget.questions[widget.index].fields.quesTittle.stringValue,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(widget.questions[widget.index].fields.quesBody.stringValue,
              maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }
}