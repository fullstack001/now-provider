/// phone : "The phone has already been taken."

class SuccessMessage {
  var phone;

  SuccessMessage({
      this.phone});

  SuccessMessage.fromJson(dynamic json) {
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["phone"] = phone;
    return map;
  }

}