import 'provider_zipcode_data.dart';

/// error : false
/// message : "success"
/// provider_zipcode_data : [{"id":34,"code":"1234","created_at":"2021-08-24T13:03:32.000000Z","updated_at":"2021-08-24T13:03:32.000000Z"},{"id":35,"code":"5678","created_at":"2021-08-24T13:03:32.000000Z","updated_at":"2021-08-24T13:03:32.000000Z"},{"id":36,"code":"9012","created_at":"2021-08-24T13:03:32.000000Z","updated_at":"2021-08-24T13:03:32.000000Z"}]

class ProviderZipcodeResponse {
  var error;
  var message;
  var providerZipcodeData;

  ProviderZipcodeResponse({this.error, this.message, this.providerZipcodeData});

  ProviderZipcodeResponse.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    if (json["data"] != null) {
      providerZipcodeData = [];
      json["data"].forEach((v) {
        providerZipcodeData.add(ProviderZipcodeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    if (providerZipcodeData != null) {
      map["provider_zipcode_data"] =
          providerZipcodeData.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
