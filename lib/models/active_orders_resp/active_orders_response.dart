import 'active_orders_data.dart';

class ActiveOrdersResponse {
  var error;
  var activeOrdersData;
  var message;

  ActiveOrdersResponse({
      this.error, 
      this.activeOrdersData, 
      this.message});

  ActiveOrdersResponse.fromJson(dynamic json) {
    error = json["error"];
    if (json["data"] != null) {
      activeOrdersData = [];
      json["data"].forEach((v) {
        activeOrdersData.add(ActiveOrdersData.fromJson(v));
      });
    }
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (activeOrdersData != null) {
      map["active_orders_data"] = activeOrdersData.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    return map;
  }

}