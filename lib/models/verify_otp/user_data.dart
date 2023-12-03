import 'user.dart';

/// user : {"id":19,"first_name":null,"last_name":null,"email":"noumanamin33@gmail.com","email_verified_at":null,"phone":"+923008383978","zip_code":null,"role":"PROVIDER","status":"ACTIVE","created_at":"2021-07-11T07:37:12.000000Z","updated_at":"2021-07-11T07:37:43.000000Z","phone_verification":1,"spend_each_month":null,"provider_type":"Individual"}
/// auth_token : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTQ3MWY3YzY5OTJlZjgyNjVlYTI2ZGQwYTJiYzNkNmFlOGViMjczMmI3NmMxOTkzNTJjYzY0NzI5MmY2MTg5ZmUxYWNmOTFiYTA3MGMzOWQiLCJpYXQiOjE2MjU5ODkwNjMsIm5iZiI6MTYyNTk4OTA2MywiZXhwIjoxNjU3NTI1MDYzLCJzdWIiOiIxOSIsInNjb3BlcyI6W119.OSlqtdzEHQ284WfkiRozmWIQIR5KCFSzJsxrUjWDejvwyLUESNL1_UHdXONYEFF0l_AqUoNCUzNtszHmsRqFfGScY2ZsHReZaCYdvfPlYSgn8CYxFKCfIGO-jO9hYUrS9lYwR0vI8d8XeZ5x2clf6LS02mmVtl9BUmE_hKEsDzbADmVVj3t_hXrA4oDGuEmUY6H0hZ7vDS1ffJJBw3K89pc6Q3vQg4InIZf3ckZM4L8FuWvBIPdwXpOafT-ZxOXxp_Uq4pXuMhKb0lyIphzwFVXxR3bB5p7dzMVZtdugO0qO0ZvkXDI9SBPPIkxbnQGEfOZXfNxhFmvDobE1DPiuj8rn0c-p8GBPk5tNlx-T5cf90XNN-7cMbtndOQiPWG6pj3ReDoOBdWVHfKZ9nudCgxlG-Zar827DeGYzWYNrr0XgZmJxM6BQbcG1TyXaPlV-b5F_VAATr6_2kk9k8x_eCiHc2pmwTuiJecLs8plmbHWOG3JD6Bc5-WmGBL-Uw1AjITtVA4nljUsglgOXxthrjhVXStEO39bG4BqfBColHv0jq-612RWGFGhaBSk2XX05OooinqInuxFZyW_ll5t8iaSO1Qk3ybkSiZOtnQUdr5cmHTMQNf9oRcZ1PShnbY3bWDJbvAa0W6-MadCdTzNuSXI77oDSwmyVNivEglSDcOk"
/// expires_at : "2022-07-11 07:37:43"

class UserData {
  var user;
  var authToken;
  var expiresAt;

  UserData({this.user, this.authToken, this.expiresAt});

  UserData.fromJson(dynamic json) {
    if (json["user"] == null) {
      user = User.fromJson(json);
    } else {
      user = json["user"] != null ? User.fromJson(json["user"]) : null;
      authToken = json["auth_token"];
      expiresAt = json["expires_at"];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (user != null) {
      map["user"] = user?.toJson();
    }
    map["auth_token"] = authToken;
    map["expires_at"] = expiresAt;
    return map;
  }
}
