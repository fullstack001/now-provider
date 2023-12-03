/// lat : 34.1444095302915
/// lng : -118.4007997697085

class Northeast {
  var lat;
  var lng;

  Northeast({
      this.lat, 
      this.lng});

  Northeast.fromJson(dynamic json) {
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