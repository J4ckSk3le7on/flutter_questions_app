import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:questions_app/question_info/model/question_answer_model.dart';
import 'package:questions_app/question_info/model/question_info_model.dart';

class QuestionInfoProvider {

  String _getBaseUrl = "firestore.googleapis.com";

  Future<QuestionInfoModel> _processResp(Uri url) async {
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final questionInfo = new QuestionInfoModel.fromJson(decodedData);
    QuestionInfoModel question = questionInfo;
    return question;
  }

  Future<QuestionInfoModel> getQuestionInfo(String questionID) async {
    final url = Uri.https(_getBaseUrl, "/v1/projects/questions-app-jack/databases/(default)/documents/questions/$questionID");
    final resp = await _processResp(url);
    return(resp);
  }

  Future<List<Document>> _processAnswersResp(Uri url) async {
    final resp = await http.get(url);
    final decodedData = jsonDecode(resp.body);
    final questionAnswersInfo = new QuestionAnswerModel.fromJson(decodedData);
    List<Document> allQuestionAnswers = questionAnswersInfo.documents;
    return allQuestionAnswers;
  }

  Future<List<Document>> getQuestionAnswersInfo(String answerCategory, String questionID) async {
    final url = Uri.https(_getBaseUrl, "/v1/projects/questions-app-jack/databases/(default)/documents/answers/$answerCategory/$questionID");
    final resp = await _processAnswersResp(url);
    return(resp);
  }

}