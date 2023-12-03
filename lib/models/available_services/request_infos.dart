import 'option.dart';
import 'question.dart';

/// id : 1
/// service_request_id : 11
/// question_id : 1
/// option_id : 11
/// created_at : "2021-08-14T08:06:26.000000Z"
/// updated_at : "2021-08-14T08:06:26.000000Z"
/// question : {"id":1,"sub_service_id":1,"question":"What is Room size","created_at":"2021-08-09T06:40:24.000000Z","updated_at":"2021-08-09T06:40:24.000000Z"}
/// option : {"id":11,"question_id":1,"option":"20x20","created_at":"2021-08-09T07:14:00.000000Z","updated_at":"2021-08-09T07:14:00.000000Z"}

class RequestInfos {
  var id;
  var serviceRequestId;
  var questionId;
  var optionId;
  var createdAt;
  var updatedAt;
  var question;
  var option;

  RequestInfos(
      {this.id,
      this.serviceRequestId,
      this.questionId,
      this.optionId,
      this.createdAt,
      this.updatedAt,
      this.question,
      this.option});

  RequestInfos.fromJson(dynamic json) {
    id = json["id"];
    serviceRequestId = json["service_request_id"];
    questionId = json["question_id"];
    optionId = json["option_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    question =
        json["question"] != null ? Question.fromJson(json["question"]) : null;
    option = json["option"] != null ? Option.fromJson(json["option"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["service_request_id"] = serviceRequestId;
    map["question_id"] = questionId;
    map["option_id"] = optionId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (question != null) {
      map["question"] = question.toJson();
    }
    if (option != null) {
      map["option"] = option.toJson();
    }
    return map;
  }
}
