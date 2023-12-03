/// type : "The type field is required."
/// street_address : "The street address field is required."
/// suite_number : "The suite number field is required."
/// state : "The state field is required."
/// city : "The city field is required."
/// zip_code : "The zip code field is required."

class ResponseErrors {
  var type;
  var streetAddress;
  var suiteNumber;
  var state;
  var city;
  var zipCode;
  var image;
  var bio;

  ResponseErrors({
    this.type,
    this.streetAddress,
    this.suiteNumber,
    this.state,
    this.city,
    this.zipCode,
    this.bio,
  });

  ResponseErrors.fromJson(dynamic json) {
    type = json["type"];
    streetAddress = json["street_address"];
    suiteNumber = json["suite_number"];
    state = json["state"];
    city = json["city"];
    zipCode = json["zip_code"];
    image = json["image"];
    bio = json["bio"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["street_address"] = streetAddress;
    map["suite_number"] = suiteNumber;
    map["state"] = state;
    map["city"] = city;
    map["zip_code"] = zipCode;
    map["image"] = image;
    map["bio"] = bio;
    return map;
  }
}
