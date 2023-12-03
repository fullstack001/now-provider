import 'package:fare_now_provider/models/response_errors.dart';
import 'package:fare_now_provider/models/signup_username/provider_profile_errors.dart';

/// error : false
/// message_signup_user_name : "success"

class SignUpUsernameResponse {
  var error;
  var messageSignupUserName;
  var profileErrors;

  SignUpUsernameResponse({this.error, this.messageSignupUserName});

  SignUpUsernameResponse.fromJson(dynamic json) {
    error = json["error"];
    if (error) {
      profileErrors = json["message"] == null
          ? null
          : ResponseErrors.fromJson(json["message"]);
    } else {
      messageSignupUserName = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = messageSignupUserName;
    return map;
  }
}
