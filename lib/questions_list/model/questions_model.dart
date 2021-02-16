// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

class QuestionsModel {
    QuestionsModel({
        this.documents,
    });

    List<Document> documents;

    factory QuestionsModel.fromRawJson(String str) => QuestionsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
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
        this.quesId,
        this.quesTittle,
        this.quesCreator,
        this.quesBody,
    });

    QuesId quesId;
    Ques quesTittle;
    Ques quesCreator;
    Ques quesBody;

    factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        quesId: QuesId.fromJson(json["quesID"]),
        quesTittle: Ques.fromJson(json["quesTittle"]),
        quesCreator: Ques.fromJson(json["quesCreator"]),
        quesBody: Ques.fromJson(json["quesBody"]),
    );

    Map<String, dynamic> toJson() => {
        "quesID": quesId.toJson(),
        "quesTittle": quesTittle.toJson(),
        "quesCreator": quesCreator.toJson(),
        "quesBody": quesBody.toJson(),
    };
}

class Ques {
    Ques({
        this.stringValue,
    });

    String stringValue;

    factory Ques.fromRawJson(String str) => Ques.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Ques.fromJson(Map<String, dynamic> json) => Ques(
        stringValue: json["stringValue"],
    );

    Map<String, dynamic> toJson() => {
        "stringValue": stringValue,
    };
}

class QuesId {
    QuesId({
        this.integerValue,
    });

    String integerValue;

    factory QuesId.fromRawJson(String str) => QuesId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QuesId.fromJson(Map<String, dynamic> json) => QuesId(
        integerValue: json["integerValue"],
    );

    Map<String, dynamic> toJson() => {
        "integerValue": integerValue,
    };
}
