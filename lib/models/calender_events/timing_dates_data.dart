import 'time_slots.dart';

/// id : 4
/// provider_id : 48
/// year : "2021"
/// month : "8"
/// date : "5"
/// created_at : "2021-08-10T13:29:53.000000Z"
/// updated_at : "2021-08-10T13:29:53.000000Z"
/// time_slots : [{"id":7,"provider_schedule_id":4,"start":"00","end":"01","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z"},{"id":8,"provider_schedule_id":4,"start":"02","end":"03","created_at":"2021-08-10T13:29:53.000000Z","updated_at":"2021-08-10T13:29:53.000000Z"}]

class TimingDatesData {
  var id;
  var providerId;
  var year;
  var month;
  var date;
  var createdAt;
  var updatedAt;
  var timeSlots;

  TimingDatesData({
      this.id, 
      this.providerId, 
      this.year, 
      this.month, 
      this.date, 
      this.createdAt, 
      this.updatedAt, 
      this.timeSlots});

  TimingDatesData.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    year = json["year"];
    month = json["month"];
    date = json["date"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    if (json["time_slots"] != null) {
      timeSlots = [];
      json["time_slots"].forEach((v) {
        timeSlots.add(TimeSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["year"] = year;
    map["month"] = month;
    map["date"] = date;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (timeSlots != null) {
      map["time_slots"] = timeSlots.map((v) => v.toJson()).toList();
    }
    return map;
  }

}