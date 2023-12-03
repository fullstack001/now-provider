import 'location.dart';
import 'viewport.dart';

/// location : {"lat":34.1431542,"lng":-118.402161}
/// viewport : {"northeast":{"lat":34.1444095302915,"lng":-118.4007997697085},"southwest":{"lat":34.1417115697085,"lng":-118.4034977302915}}

class Geometry {
  var location;
  var viewport;

  Geometry({
      this.location, 
      this.viewport});

  Geometry.fromJson(dynamic json) {
    location = json["location"] != null ? Location.fromJson(json["location"]) : null;
    viewport = json["viewport"] != null ? Viewport.fromJson(json["viewport"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (location != null) {
      map["location"] = location.toJson();
    }
    if (viewport != null) {
      map["viewport"] = viewport.toJson();
    }
    return map;
  }

}