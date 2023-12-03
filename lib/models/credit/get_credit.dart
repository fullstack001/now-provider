/// error : false
/// message : "success"
/// data : "5200"

class GetCredit {
  var error;
  var message;
  var data;

  GetCredit({
      this.error, 
      this.message, 
      this.data});

  GetCredit.fromJson(dynamic json) {
    error = json["error"];
    message = json["message"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["error"] = error;
    map["message"] = message;
    map["data"] = data;
    return map;
  }

}