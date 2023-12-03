/// id : 11
/// question_id : 1
/// option : "20x20"
/// created_at : "2021-08-09T07:14:00.000000Z"
/// updated_at : "2021-08-09T07:14:00.000000Z"

class Option {
  var id;
  var questionId;
  var option;
  var createdAt;
  var updatedAt;

  Option({
      this.id, 
      this.questionId, 
      this.option, 
      this.createdAt, 
      this.updatedAt});

  Option.fromJson(dynamic json) {
    id = json["id"];
    questionId = json["question_id"];
    option = json["option"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["question_id"] = questionId;
    map["option"] = option;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}