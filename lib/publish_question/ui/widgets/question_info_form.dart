import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:questions_app/publish_question/model/question_category_model.dart';
import 'package:questions_app/publish_question/provider/question_info_form_provider.dart';

class QuestioninfoForm extends StatefulWidget {

  @required final String userEmail;

  QuestioninfoForm({
    this.userEmail
  });

  @override
  _QuestioninfoFormState createState() => _QuestioninfoFormState();
}

class _QuestioninfoFormState extends State<QuestioninfoForm> {
  
  final TextEditingController questionTittleController = TextEditingController();
  final TextEditingController questionBodyController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String alertTittle;
  String alertContent;
  Function backTo;
  Response response;
  int quesIndex;
  List<DocumentCategory> questionCategory = List();
  String selectedValue;
  String quesCreator;

  @override
  void initState() { 
    super.initState();
    QuestionPostProvider().getQuestionsCategory().then((categoryFromServer) {
      setState(() {
        questionCategory = categoryFromServer;
        selectedValue = categoryFromServer.first.name.substring(68);
        quesCreator = widget.userEmail;
      });
    });
  }

  @override
  void dispose() { 
    super.dispose();
  }
  
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
            Text("Question Tittle",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 26
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,2,20,0),
              child: TextFormField(
                controller: questionTittleController,
                maxLines: 2,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter a valid Tittle";
                  } if (value.length > 60) {
                    return "The Title must not have more than 60 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Tittle",
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
            SizedBox(height: 25,),
            Text("Question Body",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 26
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,2,20,0),
              child: TextFormField(
                controller: questionBodyController,
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
            Container(
              height: 60,
              width: 160,
              child: DropdownButtonFormField(
                hint: Text("Select category"),
                value: selectedValue,
                onChanged: (String newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: questionCategory.map((DocumentCategory map){
                  return DropdownMenuItem(
                    value: map.name.substring(68),
                    child: Text(map.name.substring(68)),
                  );
                }).toList()
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
                    QuestionPostProvider().getQuestionsIndex(selectedValue)
                    .then((indexFromServer) {
                      setState(() {
                        quesIndex = indexFromServer.length;                        
                      });
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      QuestionPostProvider().postQuestion(
                        selectedValue.trim(),
                        questionBodyController.text,
                        quesCreator,
                        quesIndex,
                        questionTittleController.text
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
                    });
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
