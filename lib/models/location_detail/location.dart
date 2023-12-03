/// lat : 34.1431542
/// lng : -118.402161

class Location {
  var lat;
  var lng;

  Location({
      this.lat, 
      this.lng});

  Location.fromJson(dynamic json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lat"] = lat;
    map["lng"] = lng;
    return map;
  }

}