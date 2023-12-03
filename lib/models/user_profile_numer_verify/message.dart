/// email : "The email field is required."
/// password : "The password field is required."
/// phone : "The phone field is required."

class Message {
  String? email;
  String? password;
  String? phone;

  Message({
      this.email, 
      this.password, 
      this.phone});

  Message.fromJson(dynamic json) {
    email = json["email"];
    password = json["password"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = email;
    map["password"] = password;
    map["phone"] = phone;
    return map;
  }

}