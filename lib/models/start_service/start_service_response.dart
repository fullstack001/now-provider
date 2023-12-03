import 'start_service_data.dart';

/// error : false
/// start_service_data : {"service_request_id":301,"start_at":"2021-09-23T11:13:19.706183Z","updated_at":"2021-09-23T11:13:19.000000Z","created_at":"2021-09-23T11:13:19.000000Z","id":1}
/// message : "OK"

class StartServiceResponse {
  var error;
  var startServiceData;
  var message;

  StartServiceResponse({this.error, this.startServiceData, this.message});

  StartServiceResponse.fromJson(dynamic json) {
    error = json["error"];
    startServiceData =
        json["data"] != null ? StartServiceData.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (startServiceData != null) {
      map["data"] = startServiceData.toJson();
    }
    map["message"] = message;
    return map;
  }
}
