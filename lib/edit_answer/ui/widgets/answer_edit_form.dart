import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:questions_app/edit_answer/provider/answer_info_form_provider.dart';

class AnswerEditForm extends StatefulWidget {

  @required final String userEmail;
  @required final String ansRoute;
  @required final String questionBody;

  AnswerEditForm({
    this.userEmail,
    this.ansRoute,
    this.questionBody
  });

  @override
  _AnswerEditFormState createState() => _AnswerEditFormState();
}

class _AnswerEditFormState extends State<AnswerEditForm> {
  
  final TextEditingController ansBodyController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String alertTittle;
  String alertContent;
  Function backTo;
  Response response;

  @override
  void initState() { 
    super.initState();
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20,2,20,0),
              child: Text(widget.questionBody,
                style: TextStyle(
                  fontSize: 16
                ),
              )
            ),
            SizedBox(height: 25,),
            Text("Answer Body",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 26
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,2,20,0),
              child: TextFormField(
                controller: ansBodyController,
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
                  onTap: () {
                    AnswerPatchProvider().delAnswer(
                      widget.ansRoute
                    );
                  Navigator.of(context)
                  ..pop()
                  ..pop();
                  },
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
                          Icon(Icons.delete_forever_rounded,
                            color: Colors.white,
                          ),
                          Text("Delete",
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
                    AnswerPatchProvider().patchAnswer(
                      widget.ansRoute,
                      ansBodyController.text,
                      widget.userEmail
                    ).then((Response resp) {
                      setState(() {
                        response = resp;
                      });
                    });
                    if (response == null || response.statusCode == 200) {
                      setState(() {
                        alertTittle = "Updated Question";
                        alertContent = "Your question has been successfully updated.";
                        backTo = () {
                          Navigator.of(context)
                          ..pop()
                          ..pop()
                          ..pop();
                        };
                      });
                    } else {
                      setState(() {
                        alertTittle = "Error updating question";
                        alertContent = "Your question could not be Updated, please try again.";
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
                          Icon(Icons.cloud_upload_outlined,
                            color: Colors.white,
                          ),
                          Text("Update",
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
