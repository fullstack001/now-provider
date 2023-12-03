class TimerData {
  int? serviceRequestId;
  bool? isPaused;
  String? time;
  String? type;
  String? pauseTime;

  TimerData({
    this.serviceRequestId,
    this.isPaused,
    this.time,
    this.type,
    this.pauseTime,
  });

  TimerData.fromJson(dynamic json) {
    serviceRequestId = json["service_request_id"];
    isPaused = json["is_paused"];
    time = json["time"];
    type = json["type"];
    pauseTime = json["pause_time"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["service_request_id"] = serviceRequestId;
    map["is_paused"] = isPaused;
    map["time"] = time;
    map["type"] = type;
    map["pause_time"] = pauseTime;
    return map;
  }
}
