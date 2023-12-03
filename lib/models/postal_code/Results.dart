import 'package:fare_now_provider/models/location_detail/address_components.dart';

import 'Geometry.dart';

class Results {
  Results({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.postcodeLocalities,
    this.types,
  });

  Results.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      addressComponents = [];
      json['address_components'].forEach((v) {
        addressComponents.add(AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    placeId = json['place_id'];
    postcodeLocalities = json['postcode_localities'] != null
        ? json['postcode_localities'].cast<String>()
        : [];
    types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  var addressComponents;
  var formattedAddress;
  var geometry;
  var placeId;
  var postcodeLocalities;
  var types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressComponents != null) {
      map['address_components'] =
          addressComponents.map((v) => v.toJson()).toList();
    }
    map['formatted_address'] = formattedAddress;
    if (geometry != null) {
      map['geometry'] = geometry.toJson();
    }
    map['place_id'] = placeId;
    map['postcode_localities'] = postcodeLocalities;
    map['types'] = types;
    return map;
  }
}
