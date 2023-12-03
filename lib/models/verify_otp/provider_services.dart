import 'sub_service.dart';

class ProviderServices {
  int? id;
  int? providerId;
  int? serviceId;
  int? subServiceId;
  String? createdAt;
  String? updatedAt;
  var subService;
  var service;

  ProviderServices(
      {this.id,
      this.providerId,
      this.serviceId,
      this.subServiceId,
      this.createdAt,
      this.updatedAt,
      this.subService,
      this.service});

  ProviderServices.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    serviceId = json["service_id"];
    subServiceId = json["sub_service_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    subService = json["sub_service"] != null
        ? SubService.fromJson(json["sub_service"])
        : null;
    service = json["service"] ?? "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["service_id"] = serviceId;
    map["sub_service_id"] = subServiceId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (subService != null) {
      map["sub_service"] = subService.toJson();
    }
    map["service"] = service;
    return map;
  }
}
