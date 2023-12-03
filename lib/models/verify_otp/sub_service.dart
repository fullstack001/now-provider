class SubService {
  int? id;
  int? serviceId;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? image;

  SubService({
      this.id, 
      this.serviceId, 
      this.name, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.image});

  SubService.fromJson(dynamic json) {
    id = json["id"];
    serviceId = json["service_id"];
    name = json["name"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["service_id"] = serviceId;
    map["name"] = name;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["image"] = image;
    return map;
  }

}