/// service_request_id : 301
/// start_at : "2021-09-23T11:13:19.706183Z"
/// updated_at : "2021-09-23T11:13:19.000000Z"
/// created_at : "2021-09-23T11:13:19.000000Z"
/// id : 1

class StartServiceData {
  int? serviceRequestId;
  String? startAt;
  String? updatedAt;
  String? createdAt;
  int? id;

  StartServiceData({
      this.serviceRequestId, 
      this.startAt, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  StartServiceData.fromJson(dynamic json) {
    serviceRequestId = json["service_request_id"];
    startAt = json["start_at"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["service_request_id"] = serviceRequestId;
    map["start_at"] = startAt;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}