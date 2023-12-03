import 'slots.dart';

/// date : 5
/// slots : [{"start":"00","end":"01"},{"start":"00","end":"01"}]

class Dates {
  int? date;
  var slots;

  Dates({
      this.date, 
      this.slots});

  Dates.fromJson(dynamic json) {
    date = json["date"];
    if (json["slots"] != null) {
      slots = [];
      json["slots"].forEach((v) {
        slots.add(Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = date;
    if (slots != null) {
      map["slots"] = slots.map((v) => v.toJson()).toList();
    }
    return map;
  }

}