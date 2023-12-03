/// id : 7
/// provider_schedule_id : 4
/// start : "00"
/// end : "01"
/// created_at : "2021-08-10T13:29:53.000000Z"
/// updated_at : "2021-08-10T13:29:53.000000Z"

class TimeSlots {
  var id;
  var providerScheduleId;
  var start;
  var end;
  var createdAt;
  var updatedAt;

  TimeSlots({
      this.id, 
      this.providerScheduleId, 
      this.start, 
      this.end, 
      this.createdAt, 
      this.updatedAt});

  TimeSlots.fromJson(dynamic json) {
    id = json["id"];
    providerScheduleId = json["provider_schedule_id"];
    start = json["start"];
    end = json["end"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_schedule_id"] = providerScheduleId;
    map["start"] = start;
    map["end"] = end;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}