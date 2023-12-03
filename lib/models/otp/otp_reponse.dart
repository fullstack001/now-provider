import 'success_message.dart';

/// error : true
/// success_message : {"phone":"The phone has already been taken."}

class OtpReponse {
  var error;
  var successMessage;
  var errorMessage;

  OtpReponse({this.error, this.successMessage,this.errorMessage});

  OtpReponse.fromJson(dynamic json) {
    error = json["error"];
    successMessage = json["message"] != null
        ? SuccessMessage.fromJson(json["message"])
        : null;
  }

  OtpReponse.errorJson(dynamic json) {
    error = json["error"];
    errorMessage = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (successMessage != null) {
      map["message"] = successMessage.toJson();
    }
    if (errorMessage != null) {
      map["message"] = errorMessage;
    }

    return map;
  }
}
