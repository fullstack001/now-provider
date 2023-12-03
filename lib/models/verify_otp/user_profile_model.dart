/// id : 12
/// provider_id : 48
/// dob : "Azy"
/// street_address : "Azy"
/// suite_number : "Azy"
/// city : "Azy"
/// state : "England"
/// business_name : null
/// founded_year : null
/// number_of_employees : null
/// created_at : "2021-07-14T21:36:04.000000Z"
/// updated_at : "2021-08-23T08:18:49.000000Z"
/// hourly_rate : null

class UserProfileModel {
  var id;
  var providerId;
  var dob;
  var streetAddress;
  var suiteNumber;
  var city;
  var state;
  dynamic businessName;
  dynamic foundedYear;
  dynamic numberOfEmployees;
  var createdAt;
  var updatedAt;
  dynamic hourlyRate;

  UserProfileModel({
      this.id, 
      this.providerId, 
      this.dob, 
      this.streetAddress, 
      this.suiteNumber, 
      this.city, 
      this.state, 
      this.businessName, 
      this.foundedYear, 
      this.numberOfEmployees, 
      this.createdAt, 
      this.updatedAt, 
      this.hourlyRate});

  UserProfileModel.fromJson(dynamic json) {
    id = json["id"];
    providerId = json["provider_id"];
    dob = json["dob"];
    streetAddress = json["street_address"];
    suiteNumber = json["suite_number"];
    city = json["city"];
    state = json["state"];
    businessName = json["business_name"];
    foundedYear = json["founded_year"];
    numberOfEmployees = json["number_of_employees"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    hourlyRate = json["hourly_rate"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["provider_id"] = providerId;
    map["dob"] = dob;
    map["street_address"] = streetAddress;
    map["suite_number"] = suiteNumber;
    map["city"] = city;
    map["state"] = state;
    map["business_name"] = businessName;
    map["founded_year"] = foundedYear;
    map["number_of_employees"] = numberOfEmployees;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["hourly_rate"] = hourlyRate;
    return map;
  }

}