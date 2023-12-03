/// start : "00"
/// end : "01"

class Slots {
  String? start;
  String? end;

  Slots({this.start, this.end});

  Slots.fromJson(dynamic json) {
    start = json["start"];
    end = json["end"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["start"] = start;
    map["end"] = end;
    return map;
  }
}
