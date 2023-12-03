/// provider_id : 368
/// service_id : 1
/// sub_service_id : 2
/// updated_at : "2022-05-24T09:44:30.000000Z"
/// created_at : "2022-05-24T09:44:30.000000Z"
/// id : 375

class ServiceUpdateData {
  ServiceUpdateData({
      this.providerId, 
      this.serviceId, 
      this.subServiceId, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  ServiceUpdateData.fromJson(dynamic json) {
    providerId = json['provider_id'];
    serviceId = json['service_id'];
    subServiceId = json['sub_service_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? providerId;
  int? serviceId;
  int? subServiceId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['provider_id'] = providerId;
    map['service_id'] = serviceId;
    map['sub_service_id'] = subServiceId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}