/// id : 1
/// service_id : 1
/// name : "Affordable Cleaning Service"
/// status : 1
/// created_at : "2021-06-02T17:13:15.000000Z"
/// updated_at : "2021-06-02T17:13:15.000000Z"

class SubService {
  var id;
  var serviceId;
  var name;
  var status;
  var createdAt;
  var updatedAt;

  SubService(
      {this.id,
      this.serviceId,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt});

  SubService.fromJson(dynamic json) {
    id = json["id"];
    serviceId = json["service_id"];
    name = json["name"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["service_id"] = serviceId;
    map["name"] = name;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}
