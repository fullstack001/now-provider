/// id : 59
/// first_name : "nouman"
/// last_name : "amin"
/// email : "noumanamin33@gmail.com"
/// email_verified_at : null
/// phone : "+923008383978"
/// zip_code : "4545"
/// role : "USER"
/// status : "ACTIVE"
/// created_at : "2021-08-16T10:30:11.000000Z"
/// updated_at : "2021-08-16T10:30:11.000000Z"
/// phone_verification : 0
/// spend_each_month : null
/// provider_type : "Individual"

class UserDataModel {
  var id;
  var firstName;
  var lastName;
  var email;
  var address;
  dynamic emailVerifiedAt;
  var phone;
  var zipCode;
  var role;
  var status;
  var createdAt;
  var image;
  var updatedAt;
  var phoneVerification;
  dynamic spendEachMonth;
  var providerType;
  var rating;
  var feedback_count;

  UserDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.phone,
      this.zipCode,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.phoneVerification,
      this.spendEachMonth,
      this.providerType,
      this.rating,
      this.address,
      this.feedback_count});

  UserDataModel.fromJson(dynamic json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    address=json["address"];
    emailVerifiedAt = json["email_verified_at"];
    phone = json["phone"];
    zipCode = json["zip_code"];
    role = json["role"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    phoneVerification = json["phone_verification"];
    spendEachMonth = json["spend_each_month"];
    providerType = json["provider_type"];
    image = json["image"];
    rating = json["rating"];
    feedback_count = json["feedback_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["email"] = email;
    map["address"]=address;
    map["image"] = image;
    map["email_verified_at"] = emailVerifiedAt;
    map["phone"] = phone;
    map["zip_code"] = zipCode;
    map["role"] = role;
    map["status"] = status;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["phone_verification"] = phoneVerification;
    map["spend_each_month"] = spendEachMonth;
    map["provider_type"] = providerType;
    map["rating"] = rating;
    return map;
  }
}
