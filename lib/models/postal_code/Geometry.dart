import 'Bounds.dart';
import 'Location.dart';
import 'Viewport.dart';

class Geometry {
  Geometry({
      this.bounds, 
      this.location, 
      this.locationType, 
      this.viewport,});

  Geometry.fromJson(dynamic json) {
    bounds = json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
  var bounds;
  var location;
  var locationType;
  var viewport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bounds != null) {
      map['bounds'] = bounds.toJson();
    }
    if (location != null) {
      map['location'] = location.toJson();
    }
    map['location_type'] = locationType;
    if (viewport != null) {
      map['viewport'] = viewport.toJson();
    }
    return map;
  }

}