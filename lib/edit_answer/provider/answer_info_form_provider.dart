import 'dart:convert';
import 'package:http/http.dart' as http;

class AnswerPatchProvider {

  String _postBaseUrl = "https://firestore.googleapis.com";

  Future<http.Response> patchAnswer(
    String answerRoute,
    String ansBody,
    String ansCreator
  ) async {
  final http.Response resp = await http.patch(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/answers/$answerRoute",
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

  Future<http.Response> delAnswer(
    String answerRoute
  ) async {
  final http.Response resp = await http.delete(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/answers/$answerRoute",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return resp;
  }

}