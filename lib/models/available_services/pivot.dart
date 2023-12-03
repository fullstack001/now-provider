/// service_request_id : 11
/// time_slot_id : 25

class Pivot {
  var serviceRequestId;
  var timeSlotId;

  Pivot({
      this.serviceRequestId, 
      this.timeSlotId});

  Pivot.fromJson(dynamic json) {
    serviceRequestId = json["service_request_id"];
    timeSlotId = json["time_slot_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["service_request_id"] = serviceRequestId;
    map["time_slot_id"] = timeSlotId;
    return map;
  }

}