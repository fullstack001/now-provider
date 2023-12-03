import 'package:fare_now_provider/models/documents/documet_data.dart';
import 'package:fare_now_provider/models/verify_otp/provider_services.dart';
import 'package:fare_now_provider/models/verify_otp/user_profile_model.dart';
import 'package:fare_now_provider/models/verify_otp/vehicles.dart';
import 'package:fare_now_provider/screens/profile_screen.dart';

/// id : 19
/// first_name : null
/// last_name : null
/// email : "noumanamin33@gmail.com"
/// email_verified_at : null
/// phone : "+923008383978"
/// zip_code : null
/// role : "PROVIDER"
/// status : "ACTIVE"
/// created_at : "2021-07-11T07:37:12.000000Z"
/// updated_at : "2021-07-11T07:37:43.000000Z"
/// phone_verification : 1
/// spend_each_month : null
/// provider_type : "Individual"

class User {
  var id;
  var firstName;
  var lastName;
  var credit;
  var email;
  var emailVerifiedAt;
  var phone;
  var zipCode;
  var role;
  var status;
  var createdAt;
  var updatedAt;
  var image;
  var bio;
  var phoneVerification;
  var spendEachMonth;
  var providerType;
  var userProfileModel;
  var providerServices;
  var serviceType;
  var vehicles;
  var document;
  var timeSlots;
  var slotsss;
  var socialType;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.credit,
    this.emailVerifiedAt,
    this.phone,
    this.zipCode,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.phoneVerification,
    this.spendEachMonth,
    this.providerType,
    this.userProfileModel,
    this.image,
    this.bio,
    this.providerServices,
    this.serviceType,
    this.vehicles,
    this.document,
    this.timeSlots,
    this.slotsss,
    this.socialType,
  });

  User.fromJson(dynamic json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    credit = json["credit"];
    emailVerifiedAt = json["email_verified_at"];
    phone = json["phone"];
    zipCode = json["zip_code"];
    role = json["role"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serviceType = json["service_type"];
    phoneVerification = json["phone_verification"];
    spendEachMonth = json["spend_each_month"];
    providerType = json["provider_type"];
    image = json["image"];
    bio = json["bio"];
    socialType = json['social_type'] ?? "";
    timeSlots = checkSlotBool(json);
    slotsFlag = timeSlots;
    slotsss = json["provider_schedules"];
    if (json["vehicles"] == null) {
      slotsss = false;
    }
    if (json["vehicles"] != null) {
      vehicles = [];
      json["vehicles"].forEach((v) {
        vehicles.add(Vehicles.fromJson(v));
      });
    }
    if (json["docs_licenses"] == null) {
      document = [];
    } else if (json["docs_licenses"] != null) {
      document = [];
      json["docs_licenses"].forEach((v) {
        document.add(DocumetData.fromJson(v));
      });

      documentFlag = document.isEmpty;
    }
    userProfileModel = json["provider_profile"] == null
        ? null
        : UserProfileModel.fromJson(json["provider_profile"]);

    if (json["provider_services"] != null) {
      providerServices = [];
      json["provider_services"].forEach((v) {
        providerServices.add(ProviderServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["service_type"] = serviceType;
    map["email"] = email;
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
    map["image"] = image;
    map["bio"] = bio;
    map["social_type"] = socialType;
    map["credit"] = credit;
    if (providerServices != null) {
      map["provider_services"] =
          providerServices.map((v) => v.toJson()).toList();
    }
    if (document != null) {
      map["docs_licenses"] = document.map((v) => v.toJson()).toList();
    }
    if (slotsss != null) {
      map["provider_schedules"] = slotsss;
    }
    map["provider_profile"] =
        userProfileModel == null ? null : userProfileModel.toJson();

    if (vehicles != null) {
      map["vehicles"] = vehicles.map((v) => v.toJson()).toList();
    }
    return map;
  }

  bool checkSlotBool(json) {
    if (json["provider_schedules"] == null) {
      return false;
    }
    if (!(json["provider_schedules"] is bool)) {
      if ((json["provider_schedules"] ?? []).isEmpty) {
        return false;
      }
    } else if (json["provider_schedules"] is bool) {
      return (json["provider_schedules"] ?? false) ? true : false;
    }
    return true;
  }
}
