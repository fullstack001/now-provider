import 'Northeast.dart';
import 'Southwest.dart';

class Viewport {
  Viewport({
      this.northeast, 
      this.southwest,});

  Viewport.fromJson(dynamic json) {
    northeast = json['northeast'] != null ? Northeast.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? Southwest.fromJson(json['southwest']) : null;
  }
  var northeast;
  var southwest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (northeast != null) {
      map['northeast'] = northeast.toJson();
    }
    if (southwest != null) {
      map['southwest'] = southwest.toJson();
    }
    return map;
  }

}