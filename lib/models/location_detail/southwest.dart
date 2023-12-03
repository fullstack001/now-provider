/// lat : 34.1417115697085
/// lng : -118.4034977302915

class Southwest {
  var lat;
  var lng;

  Southwest({
      this.lat, 
      this.lng});

  Southwest.fromJson(dynamic json) {
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