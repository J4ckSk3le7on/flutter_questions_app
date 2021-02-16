import 'package:flutter/material.dart';
import 'package:questions_app/edit_answer/ui/widgets/answer_edit_form.dart';
import 'package:questions_app/global_widgets/custom_global_appBar.dart';

class EditAnswer extends StatefulWidget {

  @required final String userEmail;
  @required final String ansRoute;
  @required final String questionBody;

  EditAnswer({
    this.userEmail,
    this.ansRoute,
    this.questionBody
  });

  @override
  _EditAnswertate createState() => _EditAnswertate();
}

class _EditAnswertate extends State<EditAnswer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDED),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomGlobalAppBar(
          tittle: "Edit Answer",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnswerEditForm(
                userEmail: widget.userEmail,
                ansRoute: widget.ansRoute,
                questionBody: widget.questionBody,
              ),
            ],
          )
        ),
      ),
    );
  }
}