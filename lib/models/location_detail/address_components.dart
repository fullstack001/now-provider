/// long_name : "12345"
/// short_name : "12345"
/// types : ["street_number"]

class AddressComponents {
  var longName;
  var shortName;
  var types;

  AddressComponents({
      this.longName, 
      this.shortName, 
      this.types});

  AddressComponents.fromJson(dynamic json) {
    longName = json["long_name"];
    shortName = json["short_name"];
    types = json["types"] != null ? json["types"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["long_name"] = longName;
    map["short_name"] = shortName;
    map["types"] = types;
    return map;
  }

}