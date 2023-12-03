//     final socialsInfoModel = socialsInfoModelFromMap(jsonString);

import 'dart:convert';

import 'models/verify_otp/provider_profile_detail.dart';

SocialsInfoModel socialsInfoModelFromMap(String str) =>
    SocialsInfoModel.fromMap(json.decode(str));

String socialsInfoModelToMap(SocialsInfoModel data) =>
    json.encode(data.toMap());

class SocialsInfoModel {
  SocialsInfoModel({
    this.error,
    this.message,
    this.data,
  });

  var error;
  var message;
  var data;

  factory SocialsInfoModel.fromMap(Map<String, dynamic> json) =>
      SocialsInfoModel(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
      };
}

class Data {
  Data({
    this.user,
    this.authToken,
    this.expiresAt,
  });

  var user;
  var authToken;
  var expiresAt;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        authToken: json["auth_token"] == null ? null : json["auth_token"],
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user == null ? null : user.toMap(),
        "auth_token": authToken == null ? null : authToken,
        "expires_at": expiresAt == null ? null : expiresAt.toIso8601String(),
      };
}

class User {
  User(
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
      this.deletedAt,
      this.phoneVerification,
      this.spendEachMonth,
      this.providerType,
      this.image,
      this.bio,
      this.accountType,
      this.deviceToken,
      this.osPlatform,
      this.credit,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.rating,
      this.serviceType,
      this.socialId,
      this.socialType,
      this.verifiedAt,
      this.providerProfile,
      this.zipCodes});

  var id;
  var firstName;
  var lastName;
  var email;
  dynamic emailVerifiedAt;
  var phone;
  dynamic zipCode;
  var role;
  var status;
  var createdAt;
  var updatedAt;
  dynamic deletedAt;
  var phoneVerification;
  dynamic spendEachMonth;
  var providerType;
  dynamic image;
  dynamic bio;
  var accountType;
  dynamic deviceToken;
  dynamic osPlatform;
  dynamic credit;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  var rating;
  dynamic serviceType;
  var socialId;
  var socialType;
  dynamic verifiedAt;
  var providerProfile;
  var zipCodes;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"] == null ? null : json["phone"],
        zipCode: json["zip_code"],
        role: json["role"] == null ? null : json["role"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        phoneVerification: json["phone_verification"] == null
            ? null
            : json["phone_verification"],
        spendEachMonth: json["spend_each_month"],
        providerType:
            json["provider_type"] == null ? null : json["provider_type"],
        image: json["image"],
        bio: json["bio"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        deviceToken: json["device_token"],
        osPlatform: json["os_platform"],
        credit: json["credit"],
        stripeId: json["stripe_id"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        rating: json["rating"] == null ? null : json["rating"],
        serviceType: json["service_type"],
        socialId: json["social_id"] == null ? null : json["social_id"],
        socialType: json["social_type"] == null ? null : json["social_type"],
        verifiedAt: json["verified_at"],
        providerProfile: json["provider_profile"] == null
            ? null
            : ProviderProfile.fromJson(json["provider_profile"]),
        zipCodes: json["zip_codes"] == null
            ? null
            : List<ZipCode>.from(
                json["zip_codes"].map((x) => ZipCode.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone == null ? null : phone,
        "zip_code": zipCode,
        "role": role == null ? null : role,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "phone_verification":
            phoneVerification == null ? null : phoneVerification,
        "spend_each_month": spendEachMonth,
        "provider_type": providerType == null ? null : providerType,
        "image": image,
        "bio": bio,
        "account_type": accountType == null ? null : accountType,
        "device_token": deviceToken,
        "os_platform": osPlatform,
        "credit": credit,
        "stripe_id": stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "rating": rating == null ? null : rating,
        "service_type": serviceType,
        "social_id": socialId == null ? null : socialId,
        "social_type": socialType == null ? null : socialType,
        "verified_at": verifiedAt,
      };
}

class ProviderProfile {
  ProviderProfile({
    this.id,
    this.providerId,
    this.earn,
    this.commission,
    this.totalEarn,
    this.dob,
    this.streetAddress,
    this.suiteNumber,
    this.city,
    this.state,
    this.country,
    this.businessName,
    this.foundedYear,
    this.numberOfEmployees,
    this.createdAt,
    this.updatedAt,
    this.hourlyRate,
    this.startingRate,
  });

  var id;
  var providerId;
  var earn;
  var commission;
  var totalEarn;
  var dob;
  var streetAddress;
  var suiteNumber;
  var city;
  var state;
  var country;
  var businessName;
  var foundedYear;
  var numberOfEmployees;
  var createdAt;
  var updatedAt;
  var hourlyRate;
  var startingRate;

  factory ProviderProfile.fromJson(Map<String, dynamic> json) =>
      ProviderProfile(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        earn: json["earn"] == null ? null : json["earn"],
        commission: json["commission"] == null ? null : json["commission"],
        totalEarn: json["total_earn"] == null ? null : json["total_earn"],
        dob: json["dob"] == null ? null : json["dob"],
        streetAddress:
            json["street_address"] == null ? null : json["street_address"],
        suiteNumber: json["suite_number"] == null ? null : json["suite_number"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        businessName: json["business_name"],
        foundedYear: json["founded_year"],
        numberOfEmployees: json["number_of_employees"],
        hourlyRate: json["hourly_rate"] == null ? null : json["hourly_rate"],
        startingRate: json["starting_rate"],
      );
}

class ZipCode {
  ZipCode({
    this.id,
    this.code,
  });

  var id;
  var code;

  factory ZipCode.fromJson(Map<String, dynamic> json) => ZipCode(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
      );
}
