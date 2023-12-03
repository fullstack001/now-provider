import 'data.dart';

class OrderStatusResponse {
  var error;
  var data;
  var message;

  OrderStatusResponse({
      this.error, 
      this.data, 
      this.message});

  OrderStatusResponse.fromJson(dynamic json) {
    error = json["error"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["message"] = message;
    return map;
  }

}