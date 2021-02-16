import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:questions_app/publish_question/model/question_category_model.dart';
import 'package:questions_app/questions_list/model/questions_model.dart';

class QuestionPostProvider {

  String _postBaseUrl = "https://firestore.googleapis.com";

  Future<http.Response> postQuestion(
    String categoryName,
    String quesBody,
    String quesCreator,
    int quesID,
    String quesTittle,
  ) async {
  final http.Response resp = await http.post(
      _postBaseUrl + "/v1/projects/questions-app-jack/databases/(default)/documents/questions/$categoryName/list",
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

  String _getBaseUrl = "firestore.googleapis.com";

  Future<List<Document>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final questionsIndexRoute = new QuestionsModel.fromJson(decodedData);
    List<Document> allQuestions = questionsIndexRoute.documents;
    return allQuestions.toList();
  }

  Future<List<Document>> getQuestionsIndex(String categoryName) async {
    final url = Uri.https(_getBaseUrl, "/v1/projects/questions-app-jack/databases/(default)/documents/questions/$categoryName/list");
    final resp = await _processResp(url);
    return(resp);
  }

  Future<List<DocumentCategory>> _processCategoryResp(Uri url) async {
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final questionsRoute = new QuestionsCategoryModel.fromJson(decodedData);
    List<DocumentCategory> allQuestionsCategory = questionsRoute.documents;
    return allQuestionsCategory.toList();
  }

  Future<List<DocumentCategory>> getQuestionsCategory() async {
    final url = Uri.https(_getBaseUrl, "/v1/projects/questions-app-jack/databases/(default)/documents/questions");
    final resp = await _processCategoryResp(url);
    return(resp);
  }

}