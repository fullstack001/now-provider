import 'package:fare_now_provider/models/services_model/main/sub_services.dart';

/// error : false
/// message : "success"
/// data : "abc"

class SubServiceResponse {
  var error;
  var message;
  var subServices;

  SubServiceResponse({this.error, this.message, this.subServices});

  SubServiceResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    if (json["data"] != null) {
      subServices = [];
      json["data"].forEach((v) {
        subServices.add(MainSubServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (subServices != null) {
      map["data"] = subServices.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
