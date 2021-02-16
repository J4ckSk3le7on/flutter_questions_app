// To parse this JSON data, do
//
//     final questionsCategoryModel = questionsCategoryModelFromJson(jsonString);

import 'dart:convert';

class QuestionsCategoryModel {
    QuestionsCategoryModel({
        this.documents,
    });

    List<DocumentCategory> documents;

    factory QuestionsCategoryModel.fromRawJson(String str) => QuestionsCategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QuestionsCategoryModel.fromJson(Map<String, dynamic> json) => QuestionsCategoryModel(
        documents: List<DocumentCategory>.from(json["documents"].map((x) => DocumentCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
    };
}

class DocumentCategory {
    DocumentCategory({
        this.name,
        this.createTime,
        this.updateTime,
    });

    String name;
    DateTime createTime;
    DateTime updateTime;

    factory DocumentCategory.fromRawJson(String str) => DocumentCategory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DocumentCategory.fromJson(Map<String, dynamic> json) => DocumentCategory(
        name: json["name"],
        createTime: DateTime.parse(json["createTime"]),
        updateTime: DateTime.parse(json["updateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "createTime": createTime.toIso8601String(),
        "updateTime": updateTime.toIso8601String(),
    };
}
