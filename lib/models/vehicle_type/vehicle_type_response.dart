import 'vehicle_type_data.dart';

class VehicleTypeResponse {
  bool? error;
  var vehicleTypeData;
  String? message;

  VehicleTypeResponse({this.error, this.vehicleTypeData, this.message});

  VehicleTypeResponse.fromJson(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      vehicleTypeData = [];
      json["data"].forEach((v) {
        vehicleTypeData.add(VehicleTypeData.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (vehicleTypeData != null) {
      map["vehicle_type_data"] =
          vehicleTypeData.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }
}
