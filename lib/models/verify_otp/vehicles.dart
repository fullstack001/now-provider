import 'package:fare_now_provider/models/verify_otp/vehicle_type.dart';

class Vehicles {
  var id;
  var providerId;
  var vehicleTypeId;
  var name;
  var model;
  var number;
  var condition;
  var companyName;
  var createdAt;
  var updatedAt;
  var vehicleType;

  Vehicles({
    this.id,
    this.providerId,
    this.vehicleTypeId,
    this.name,
    this.model,
    this.number,
    this.condition,
    this.companyName,
    this.createdAt,
    this.updatedAt,
    this.vehicleType,
  });

  Vehicles.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    vehicleTypeId = json["vehicle_type_id"];
    name = json["name"];
    model = json["model"];
    number = json["number"];
    vehicleType = json["vehicle_type"] != null ? VehicleType.fromJson(json["vehicle_type"]) : null;
    condition = json["condition"];
    companyName = json["company_name"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["vehicle_type_id"] = vehicleTypeId;
    map["name"] = name;
    map["model"] = model;
    map["number"] = number;
    map["condition"] = condition;
    map["company_name"] = companyName;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (vehicleType != null) {
      map["vehicle_type"] = vehicleType.toJson();
    }
    return map;
  }
}
