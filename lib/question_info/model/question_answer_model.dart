// To parse this JSON data, do
//
//     final questionAnswerModel = questionAnswerModelFromJson(jsonString);

import 'dart:convert';

class QuestionAnswerModel {
    QuestionAnswerModel({
        this.documents,
    });

    List<Document> documents;

    factory QuestionAnswerModel.fromRawJson(String str) => QuestionAnswerModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) => QuestionAnswerModel(
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
    };
}

class Document {
    Document({
        this.name,
        this.fields,
        this.createTime,
        this.updateTime,
    });

    String name;
    Fields fields;
    DateTime createTime;
    DateTime updateTime;

    factory Document.fromRawJson(String str) => Document.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        fields: Fields.fromJson(json["fields"]),
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields.toJson(),
        "createTime": createTime.toIso8601String(),
        "updateTime": updateTime.toIso8601String(),
    };
}

class Fields {
    Fields({
        this.ansCreator,
        this.ansBody,
    });

    Ans ansCreator;
    Ans ansBody;

    factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        ansCreator: Ans.fromJson(json["ansCreator"]),
        ansBody: Ans.fromJson(json["ansBody"]),
    );

    Map<String, dynamic> toJson() => {
        "ansCreator": ansCreator.toJson(),
        "ansBody": ansBody.toJson(),
    };
}

class Ans {
    Ans({
        this.stringValue,
    });

    String stringValue;

    factory Ans.fromRawJson(String str) => Ans.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Ans.fromJson(Map<String, dynamic> json) => Ans(
        stringValue: json["stringValue"],
    );

    Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
    };
}
