/// body : "New hourly request by Nouman"
/// service_request_id : "209"
/// title : "New request received"
/// user_id : "140"

class NotificationModel {
  var body;
  var serviceRequestId;
  var title;
  var userId;
  var type; //todo new
  var show;

  NotificationModel(
      {this.body, this.serviceRequestId, this.title, this.show, this.userId});

  NotificationModel.fromJson(dynamic json) {
    body = json["body"];
    serviceRequestId = json["service_request_id"];
    title = json["title"];
    userId = json["user_id"];
    type = json["type"];
    show = json["show"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["body"] = body;
    map["service_request_id"] = serviceRequestId;
    map["title"] = title;
    map["user_id"] = userId;
    map["type"] = type;
    map["show"] = show??false;
    return map;
  }
}
