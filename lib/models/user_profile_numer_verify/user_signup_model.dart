import 'package:fare_now_provider/models/user_profile_numer_verify/error_message.dart';

/// error : true
/// message : {"email":"The email field is required.","password":"The password field is required.","phone":"The phone field is required."}

class UserSignupModel {
  bool? error;
  ErrorsMessage? message;
  String? successMessage;

  UserSignupModel({this.error, this.message});

  UserSignupModel.errorJson(dynamic json) {
    error = json["error"];
    message = json["message"] != null
        ? ErrorsMessage.fromJson(json['message'])
        : null;
  }

  UserSignupModel.fromJson(dynamic json) {
    error = json["error"];
    successMessage = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    if (message != null) {
      map["message"] = message!.toJson();
    }
    if (successMessage != null) {
      map["message"] = successMessage;
    }
    return map;
  }
}
