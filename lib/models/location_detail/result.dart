import 'address_components.dart';
import 'geometry.dart';
import 'plus_code.dart';

/// address_components : [{"long_name":"12345","short_name":"12345","types":["street_number"]},{"long_name":"Ventura Boulevard","short_name":"Ventura Blvd","types":["route"]},{"long_name":"North Hollywood","short_name":"NoHo","types":["neighborhood","political"]},{"long_name":"Los Angeles","short_name":"Los Angeles","types":["locality","political"]},{"long_name":"Los Angeles County","short_name":"Los Angeles County","types":["administrative_area_level_2","political"]},{"long_name":"California","short_name":"CA","types":["administrative_area_level_1","political"]},{"long_name":"United States","short_name":"US","types":["country","political"]},{"long_name":"91604","short_name":"91604","types":["postal_code"]}]
/// adr_address : "<span class=\"street-address\">12345 Ventura Blvd</span>, <span class=\"locality\">North Hollywood</span>, <span class=\"region\">CA</span> <span class=\"postal-code\">91604</span>, <span class=\"country-name\">USA</span>"
/// formatted_address : "12345 Ventura Blvd, North Hollywood, CA 91604, USA"
/// geometry : {"location":{"lat":34.1431542,"lng":-118.402161},"viewport":{"northeast":{"lat":34.1444095302915,"lng":-118.4007997697085},"southwest":{"lat":34.1417115697085,"lng":-118.4034977302915}}}
/// icon : "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/geocode-71.png"
/// name : "12345 Ventura Blvd"
/// place_id : "ChIJMfcU-fq9woARwhFTK-5eYA8"
/// plus_code : {"compound_code":"4HVX+74 North Hollywood, Los Angeles, CA, USA","global_code":"85634HVX+74"}
/// reference : "ChIJMfcU-fq9woARwhFTK-5eYA8"
/// types : ["street_address"]
/// url : "https://maps.google.com/q=12345+Ventura+Blvd,+North+Hollywood,+CA+91604,+USA&ftid=0x80c2bdfaf914f731:0xf605eee2b5311c2"
/// utc_offset : -420
/// vicinity : "Los Angeles"

class Result {
  var addressComponents;
  var adrAddress;
  var formattedAddress;
  var geometry;
  var icon;
  var name;
  var placeId;
  var plusCode;
  var reference;
  var types;
  var url;
  var utcOffset;
  var vicinity;

  Result(
      {this.addressComponents,
      this.adrAddress,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.name,
      this.placeId,
      this.plusCode,
      this.reference,
      this.types,
      this.url,
      this.utcOffset,
      this.vicinity});

  Result.fromJson(dynamic json) {
    if (json["address_components"] != null) {
      addressComponents = [];
      json["address_components"].forEach((v) {
        addressComponents.add(AddressComponents.fromJson(v));
      });
    }
    adrAddress = json["adr_address"];
    formattedAddress = json["formatted_address"];
    geometry =
        json["geometry"] != null ? Geometry.fromJson(json["geometry"]) : null;
    icon = json["icon"];
    name = json["name"];
    placeId = json["place_id"];
    plusCode =
        json["plus_code"] != null ? PlusCode.fromJson(json["plus_code"]) : null;
    reference = json["reference"];
    types = json["types"] != null ? json["types"].cast<String>() : [];
    url = json["url"];
    utcOffset = json["utc_offset"];
    vicinity = json["vicinity"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (addressComponents != null) {
      map["address_components"] =
          addressComponents.map((v) => v.toJson()).toList();
    }
    map["adr_address"] = adrAddress;
    map["formatted_address"] = formattedAddress;
    if (geometry != null) {
      map["geometry"] = geometry.toJson();
    }
    map["icon"] = icon;
    map["name"] = name;
    map["place_id"] = placeId;
    if (plusCode != null) {
      map["plus_code"] = plusCode.toJson();
    }
    map["reference"] = reference;
    map["types"] = types;
    map["url"] = url;
    map["utc_offset"] = utcOffset;
    map["vicinity"] = vicinity;
    return map;
  }
}
