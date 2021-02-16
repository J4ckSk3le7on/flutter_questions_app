import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:questions_app/questions_list/model/questions_model.dart';

class QuestionsGetProvider {

  String _baseUrl = "firestore.googleapis.com";

  Future<List<Document>> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final questionsRoute = new QuestionsModel.fromJson(decodedData);
    List<Document> allQuestions = questionsRoute.documents;
    return allQuestions.toList();
  }

  Future<List<Document>> getQuestions(String categoryName) async {
    final url = Uri.https(_baseUrl, "/v1/projects/questions-app-jack/databases/(default)/documents/questions/$categoryName/list");
    final resp = await _processResp(url);
    return(resp);
  }

}