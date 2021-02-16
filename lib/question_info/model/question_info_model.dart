// To parse this JSON data, do
//
//     final questionInfoModel = questionInfoModelFromJson(jsonString);

import 'dart:convert';

class QuestionInfoModel {
    QuestionInfoModel({
        this.name,
        this.fields,
        this.createTime,
        this.updateTime,
    });

    String name;
    Fields fields;
    DateTime createTime;
    DateTime updateTime;

    factory QuestionInfoModel.fromRawJson(String str) => QuestionInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory QuestionInfoModel.fromJson(Map<String, dynamic> json) => QuestionInfoModel(
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
        this.quesBody,
        this.quesCreator,
        this.quesTittle,
    });

    QuesId quesId;
    Ques quesBody;
    Ques quesCreator;
    Ques quesTittle;

    factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        quesId: QuesId.fromJson(json["quesID"]),
        quesBody: Ques.fromJson(json["quesBody"]),
        quesCreator: Ques.fromJson(json["quesCreator"]),
        quesTittle: Ques.fromJson(json["quesTittle"]),
    );

    Map<String, dynamic> toJson() => {
        "quesID": quesId.toJson(),
        "quesBody": quesBody.toJson(),
        "quesCreator": quesCreator.toJson(),
        "quesTittle": quesTittle.toJson(),
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
