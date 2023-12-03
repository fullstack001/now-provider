class AllNotificationDataModel {
  AllNotificationDataModel({
    this.title,
    this.body,
    this.userId,
    this.serviceRequestId,
    this.type,
  });

  AllNotificationDataModel.fromJson(json) {
    var jsonData = json is List
        ? (getJson(json) ?? []).length == 0
            ? []
            : json[0]
        : json;
    title = jsonData['title'];
    body = jsonData['body'];
    userId = jsonData['user_id'];
    serviceRequestId = jsonData['service_request_id'];
    type = jsonData['type'];
  }

  var title;
  var body;
  var userId;
  var serviceRequestId;
  var type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['body'] = body;
    map['user_id'] = userId;
    map['service_request_id'] = serviceRequestId;
    map['type'] = type;
    return map;
  }

  getJson(List<dynamic> json) {
    return json;
  }
}
