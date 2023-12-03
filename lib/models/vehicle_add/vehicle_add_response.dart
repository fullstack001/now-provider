import 'package:fare_now_provider/models/verify_otp/vehicles.dart';

class VehicleAddResponse {
  var error;
  var data;
  var message;

  VehicleAddResponse({this.error, this.data, this.message});

  VehicleAddResponse.fromJson(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Vehicles.fromJson(v));
      });
    }
    message = json["message"];
  }

  VehicleAddResponse.singObject(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      data = [];
      var datas = Vehicles.fromJson(json["data"]);
      if (datas != null) {
        data.add(datas);
      }
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }
}
