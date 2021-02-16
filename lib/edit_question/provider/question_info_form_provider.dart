import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionPatchProvider {

  String _postBaseUrl = "https://firestore.googleapis.com";

  Future<http.Response> patchQuestion(
    String questionRoute,
    String quesBody,
    String quesCreator,
    String quesID,
    String quesTittle
  ) async {
  final http.Response resp = await http.patch(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/questions/$questionRoute",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        "fields": {
          "quesBody": {
            "stringValue": quesBody
          },
          "quesCreator": {
            "stringValue": quesCreator
          },
          "quesID": {
            "integerValue": quesID
          },
          "quesTittle": {
            "stringValue": quesTittle
          }
        }
      })
    );
    return resp;
  }

  Future<http.Response> delQuestion(
    String questionRoute,
  ) async {
  final http.Response resp = await http.delete(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/questions/$questionRoute",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return resp;
  }

  Future<http.Response> delQuestionAnswers(
    String answerCategory,
    String quesID,
  ) async {
    print(_postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/answers/$quesID/$answerCategory");
  final http.Response resp = await http.delete(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/answers/$quesID/$answerCategory",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return resp;
  }

}