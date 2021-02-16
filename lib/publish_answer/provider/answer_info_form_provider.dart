import 'dart:convert';
import 'package:http/http.dart' as http;

class AnswerPostProvider {

  String _postBaseUrl = "https://firestore.googleapis.com";

  Future<http.Response> postAnswer(
    String ansCategory,
    String ansBody,
    String ansCreator,
    String quesID,
  ) async {
  final http.Response resp = await http.post(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/answers/$ansCategory/$quesID",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        "fields": {
          "ansBody": {
            "stringValue": ansBody
          },
          "ansCreator": {
            "stringValue": ansCreator
          }
        }
      })
    );
    return resp;
  }

}