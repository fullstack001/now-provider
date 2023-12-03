class WorkedTimes {
  var id;
  var serviceRequestId;
  var isPaused;
  var startAt;
  dynamic endAt;
  var createdAt;
  var updatedAt;

  WorkedTimes({
      this.id, 
      this.serviceRequestId, 
      this.isPaused, 
      this.startAt, 
      this.endAt, 
      this.createdAt, 
      this.updatedAt});

  WorkedTimes.fromJson(dynamic json) {
    id = json["id"];
    serviceRequestId = json["service_request_id"];
    isPaused = json["is_paused"];
    startAt = json["start_at"];
    endAt = json["end_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["service_request_id"] = serviceRequestId;
    map["is_paused"] = isPaused;
    map["start_at"] = startAt;
    map["end_at"] = endAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}