import 'service_data.dart';

/// error : false
/// message : "success"
/// data : [{"id":1,"name":"Cleaning","status":1,"created_at":"2021-06-02T17:12:53.000000Z","updated_at":"2021-06-02T17:12:53.000000Z","sub_services":[{"id":1,"service_id":1,"name":"Affordable Cleaning Service","status":1,"created_at":"2021-06-02T17:13:15.000000Z","updated_at":"2021-06-02T17:13:15.000000Z"}]}]

class MainServviceResponse {
  var error;
  var message;
  var data;

  MainServviceResponse({
      this.error, 
      this.message, 
      this.data});

  MainServviceResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}