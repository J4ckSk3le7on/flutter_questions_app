import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:questions_app/publish_answer/provider/answer_info_form_provider.dart';
import 'package:questions_app/question_info/model/question_info_model.dart';

class AnswerinfoForm extends StatefulWidget {

  @required final QuestionInfoModel questionInfo;
  @required final String questionCategory;
  @required final String userEmail;
  
  AnswerinfoForm({
    this.questionInfo,
    this.questionCategory,
    this.userEmail,
  });

  @override
  _AnswerinfoFormState createState() => _AnswerinfoFormState();
}

class _AnswerinfoFormState extends State<AnswerinfoForm> {
  
  final TextEditingController answerBodyController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String alertTittle;
  String alertContent;
  Function backTo;
  Response response;
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Question Body:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 26
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.questionInfo.fields.quesBody.stringValue,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Answer Body",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 26
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,2,20,0),
              child: TextFormField(
                controller: answerBodyController,
                maxLines: 7,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter a valid Body";
                  } if (value.length > 280) {
                    return "The Body must not have more than 280 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Body",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                        width: 1.5
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF757575),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF757575))
                    ),
                    height: 50,
                    width: 110,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close,
                            color: Colors.white,
                          ),
                          Text("Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {if(_formkey.currentState.validate()) {
                    AnswerPostProvider().postAnswer(
                      widget.questionCategory,
                      answerBodyController.text,
                      widget.userEmail,
                      widget.questionInfo.fields.quesId.integerValue.toString(),
                    ).then((Response resp) {
                      setState(() {
                        response = resp;
                      });
                    });
                    if (response == null || response.statusCode == 200) {
                      setState(() {
                        alertTittle = "Question uploaded";
                        alertContent = "Your question has been successfully uploaded.";
                        backTo = () {
                          Navigator.of(context)
                          ..pop()
                          ..pop();
                        };
                      });
                    } else {
                      setState(() {
                        alertTittle = "Error uploading question";
                        alertContent = "Your question could not be uploaded, please try again.";
                        backTo = () => Navigator.of(context).pop();
                      });
                    }
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(alertTittle),
                        content: Text(alertContent),
                        actions: [
                          FlatButton(
                            child: Text("Close"),
                            onPressed: backTo
                          )
                        ],
                      )
                    );
                  }},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFF7043),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xffFF7043))
                    ),
                    height: 50,
                    width: 110,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border,
                            color: Colors.white,
                          ),
                          Text("Post",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}