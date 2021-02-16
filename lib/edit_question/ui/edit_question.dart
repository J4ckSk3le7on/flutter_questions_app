import 'package:flutter/material.dart';
import 'package:questions_app/edit_question/ui/widgets/question_edit_form.dart';
import 'package:questions_app/global_widgets/custom_global_appBar.dart';

class EditQuestion extends StatefulWidget {

  @required final String userEmail;
  @required final String questionID;
  @required final String questionRoute;
  @required final String quesCategory;

  EditQuestion({
    this.userEmail,
    this.questionID,
    this.questionRoute,
    this.quesCategory
  });

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  @override
  Widget build(BuildContext context) {
    print("ID: " + widget.questionID);
    print("ROUTE: " + widget.questionRoute);
    print("CATEGORY: " + widget.quesCategory);
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomGlobalAppBar(
          tittle: "Edit Question",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuestionEditForm(
                userEmail: widget.userEmail,
                questionID: widget.questionID,
                questionRoute: widget.questionRoute,
                quesCategory: widget.quesCategory,
              ),
            ],
          )
        ),
      ),
    );
  }
}