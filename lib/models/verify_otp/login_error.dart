/// user_name : "Username or password do not match."

class LoginError {
  String? userName;

  LoginError({
      this.userName});

  LoginError.fromJson(dynamic json) {
    userName = json["user_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_name"] = userName;
    return map;
  }

}