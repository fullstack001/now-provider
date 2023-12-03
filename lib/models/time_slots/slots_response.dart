import 'dates.dart';

/// year : 2021
/// month : 1
/// dates : [{"date":5,"slots":[{"start":"00","end":"01"},{"start":"00","end":"01"}]},{"date":6,"slots":[{"start":"00","end":"01"},{"start":"00","end":"01"}]},{"date":7,"slots":[{"start":"00","end":"01"},{"start":"00","end":"01"}]}]

class SlotsResponse {
  var year;
  var month;
  var dates;

  SlotsResponse({this.year, this.month, this.dates});

  SlotsResponse.fromJson(dynamic json) {
    year = json["year"];
    month = json["month"];
    if (json["dates"] != null) {
      dates = [];
      json["dates"].forEach((v) {
        dates.add(Dates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["year"] = year;
    map["month"] = month;
    if (dates != null) {
      map["dates"] = dates.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
