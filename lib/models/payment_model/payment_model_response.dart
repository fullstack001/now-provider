import 'payment_model_data.dart';

/// error : false
/// message : "success"
/// payment_model_data : {"id":12,"provider_id":48,"dob":"Azy","street_address":"Azy","suite_number":"Azy","city":"Azy","state":"England","business_name":null,"founded_year":null,"number_of_employees":null,"created_at":"2021-07-14T21:36:04.000000Z","updated_at":"2021-08-23T08:05:06.000000Z","hourly_rate":123}

class PaymentModelResponse {
  var error;
  var message;
  var paymentModelData;

  PaymentModelResponse({this.error, this.message, this.paymentModelData});

  PaymentModelResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    paymentModelData =
        json["data"] != null ? PaymentModelData.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (paymentModelData != null) {
      map["data"] = paymentModelData.toJson();
    }
    return map;
  }
}
