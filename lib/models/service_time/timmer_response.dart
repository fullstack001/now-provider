import 'timer_data.dart';

class TimmerResponse {
  var timerData;

  TimmerResponse({
      this.timerData});

  TimmerResponse.fromJson(dynamic json) {
    if (json["timer_data"] != null) {
      timerData = [];
      json["timer_data"].forEach((v) {
        timerData.add(TimerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (timerData != null) {
      map["timer_data"] = timerData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}