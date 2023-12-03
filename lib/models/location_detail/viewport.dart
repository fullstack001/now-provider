import 'northeast.dart';
import 'southwest.dart';

/// northeast : {"lat":34.1444095302915,"lng":-118.4007997697085}
/// southwest : {"lat":34.1417115697085,"lng":-118.4034977302915}

class Viewport {
  var northeast;
  var southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(dynamic json) {
    northeast = json["northeast"] != null
        ? Northeast.fromJson(json["northeast"])
        : null;
    southwest = json["southwest"] != null
        ? Southwest.fromJson(json["southwest"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (northeast != null) {
      map["northeast"] = northeast.toJson();
    }
    if (southwest != null) {
      map["southwest"] = southwest.toJson();
    }
    return map;
  }
}
