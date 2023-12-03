import 'buy_credit_data.dart';

/// error : false
/// buy_credit_data : {"provider_id":139,"payment_id":"ch_3JXOETCiKsbMzZ4L0PDyebvz","amount":"100","amount_captured":10000,"status":"succeeded","payment_method":"visa","updated_at":"2021-09-08T10:42:21.000000Z","created_at":"2021-09-08T10:42:21.000000Z","id":5}
/// message : "OK"

class BuyCreditResponse {
  var error;
  var buyCreditData;
  var message;

  BuyCreditResponse({this.error, this.buyCreditData, this.message});

  BuyCreditResponse.fromJson(dynamic json) {
    error = json["error"];
    buyCreditData =
        json["data"] != null ? BuyCreditData.fromJson(json["data"]) : null;
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (buyCreditData != null) {
      map["data"] = buyCreditData.toJson();
    }
    map["message"] = message;
    return map;
  }
}
