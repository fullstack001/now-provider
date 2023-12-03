// To parse this JSON data, do
//
//     final providerProfileDetail = providerProfileDetailFromJson(jsonString);

import 'dart:convert';

import '../../socialsInfomodel.dart';

ProviderProfileDetail providerProfileDetailFromJson(String str) =>
    ProviderProfileDetail.fromJson(json.decode(str));

String providerProfileDetailToJson(ProviderProfileDetail data) =>
    json.encode(data.toJson());

class ProviderProfileDetail {
  ProviderProfileDetail({this.error, this.message, this.data, this.token});

  var error;
  var message;
  var data;
  var token;

  factory ProviderProfileDetail.fromJson(Map<String, dynamic> json) =>
      ProviderProfileDetail(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        token: json["token"] == null ? null : json["token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({this.provider, this.auth_token, this.expires_at});

  var provider;
  var auth_token;
  var expires_at;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        provider: json['user'] != null
            ? Provider.fromJson(json["user"])
            : json["provider"] == null
                ? null
                : Provider.fromJson(json["provider"]),
        auth_token: json["auth_token"] == null ? null : json["auth_token"],
        expires_at: json["expires_at"] == null ? null : json["expires_at"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider == null ? null : provider!.toJson(),
      };
}

class Provider {
  Provider(
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
      this.userFeedbacksCount,
      this.providerServiceRequestsCount,
      this.workedHours,
      this.providerProfile,
      this.schedules,
      this.blockedSlots,
      this.portfolios,
      this.providerServices,
      this.paymentMethods,
      this.plans,
      this.docsLicenses,
      this.zipCodes});

  var id;
  var paymentMethods;
  var firstName;
  var lastName;
  var email;
  var emailVerifiedAt;
  var phone;
  var zipCode;
  var role;
  var status;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var phoneVerification;
  var spendEachMonth;
  var providerType;
  var image;
  var bio;
  var accountType;
  var deviceToken;
  var osPlatform;
  var credit;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  dynamic zipCodes;
  var rating;
  var serviceType;
  dynamic socialId;
  dynamic socialType;
  dynamic verifiedAt;
  var userFeedbacksCount;
  var providerServiceRequestsCount;
  var workedHours;
  var providerProfile;
  var schedules;
  var blockedSlots;
  var portfolios;
  var providerServices;
  var plans;
  var docsLicenses;

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"] == null ? null : json["phone"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
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
        spendEachMonth:
            json["spend_each_month"] == null ? null : json["spend_each_month"],
        providerType:
            json["provider_type"] == null ? null : json["provider_type"],
        image: json["image"],
        bio: json["bio"] == null ? null : json["bio"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        osPlatform: json["os_platform"] == null ? null : json["os_platform"],
        credit: json["credit"] == null ? null : json["credit"],
        stripeId: json["stripe_id"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        rating: json["rating"] == null ? null : json["rating"],
        serviceType: json["service_type"] == null ? null : json["service_type"],
        socialId: json["social_id"],
        socialType: json["social_type"],
        verifiedAt: json["verified_at"],
        userFeedbacksCount: json["user_feedbacks_count"] == null
            ? null
            : json["user_feedbacks_count"],
        providerServiceRequestsCount:
            json["provider_service_requests_count"] == null
                ? null
                : json["provider_service_requests_count"],
        workedHours: json["worked_hours"] == null ? null : json["worked_hours"],
        providerProfile: json["provider_profile"] == null
            ? null
            : ProviderProfile.fromJson(json["provider_profile"]),
        schedules: json["schedules"] == null
            ? null
            : List<Schedule>.from(
                json["schedules"].map((x) => Schedule.fromJson(x))),
        // //todo
        paymentMethods: json["payment_methods"] == null
            ? null
            : List<PaymentMethods>.from(
                json["payment_methods"].map((x) => PaymentMethods.fromJson(x))),
        blockedSlots: json["blocked_slots"] == null
            ? null
            : List<BlockedSlot>.from(
                json["blocked_slots"].map((x) => BlockedSlot.fromJson(x))),
        portfolios: json["portfolios"] == null
            ? null
            : List<Portfolio>.from(
                json["portfolios"].map((x) => Portfolio.fromJson(x))),
        providerServices: json["provider_services"] == null
            ? null
            : List<ProviderService>.from(json["provider_services"]
                .map((x) => ProviderService.fromJson(x))),
        plans: json["plans"] == null
            ? null
            : List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
        docsLicenses: json["docs_licenses"] == null
            ? null
            : List<DocsLicense>.from(
                json["docs_licenses"].map((x) => DocsLicense.fromJson(x))),
        zipCodes: json["zip_codes"] == null
            ? null
            : List<ZipCode>.from(
                json["zip_codes"].map((x) => ZipCode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone == null ? null : phone,
        "zip_code": zipCode == null ? null : zipCode,
        "role": role == null ? null : role,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "phone_verification":
            phoneVerification == null ? null : phoneVerification,
        "spend_each_month": spendEachMonth == null ? null : spendEachMonth,
        "provider_type": providerType == null ? null : providerType,
        "image": image,
        "bio": bio == null ? null : bio,
        "account_type": accountType == null ? null : accountType,
        "device_token": deviceToken == null ? null : deviceToken,
        "os_platform": osPlatform == null ? null : osPlatform,
        "credit": credit == null ? null : credit,
        "stripe_id": stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "rating": rating == null ? null : rating,
        "service_type": serviceType == null ? null : serviceType,
        "social_id": socialId,
        "social_type": socialType,
        "verified_at": verifiedAt,
        "user_feedbacks_count":
            userFeedbacksCount == null ? null : userFeedbacksCount,
        "provider_service_requests_count": providerServiceRequestsCount == null
            ? null
            : providerServiceRequestsCount,
        "worked_hours": workedHours == null ? null : workedHours,
        "provider_profile":
            providerProfile == null ? null : providerProfile!.toJson(),
        "schedules": schedules == null
            ? null
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        //todo
        "payment_methods": paymentMethods == null
            ? null
            : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
        "blocked_slots": blockedSlots == null
            ? null
            : List<dynamic>.from(blockedSlots!.map((x) => x.toJson())),
        "portfolios": portfolios == null
            ? null
            : List<dynamic>.from(portfolios!.map((x) => x.toJson())),
        "provider_services": providerServices == null
            ? null
            : List<dynamic>.from(providerServices!.map((x) => x.toJson())),
        "plans": plans == null
            ? null
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "docs_licenses": docsLicenses == null
            ? null
            : List<dynamic>.from(docsLicenses.map((x) => x.toJson())),
      };
}

class BlockedSlot {
  BlockedSlot({
    this.id,
    this.providerId,
    this.date,
    this.fromTime,
    this.toTime,
  });

  var id;
  var providerId;
  var date;
  var fromTime;
  var toTime;

  factory BlockedSlot.fromJson(Map<String, dynamic> json) => BlockedSlot(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fromTime: json["from_time"] == null ? null : json["from_time"],
        toTime: json["to_time"] == null ? null : json["to_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "from_time": fromTime == null ? null : fromTime,
        "to_time": toTime == null ? null : toTime,
      };
}

class Plan {
  Plan({
    this.id,
    this.providerId,
    this.title,
    this.price,
    this.type,
    this.duration,
    this.off,
    this.description,
  });

  var id;
  var providerId;
  var title;
  var price;
  var type;
  var duration;
  var off;
  var description;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        title: json["title"] == null ? null : json["title"],
        price: json["price"] == null ? null : json["price"],
        type: json["type"] == null ? null : json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        off: json["off"] == null ? null : json["off"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "title": title == null ? null : title,
        "price": price == null ? null : price,
        "type": type == null ? null : type,
        "duration": duration == null ? null : duration,
        "off": off == null ? null : off,
        "description": description == null ? null : description,
      };
}

class Portfolio {
  Portfolio({
    this.id,
    this.providerId,
    this.image,
    this.description,
  });

  var id;
  var providerId;
  var image;
  var description;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "image": image == null ? null : image,
        "description": description == null ? null : description,
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
    this.country,
    this.state,
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
  var country;
  var state;
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
        dob: json["dob"],
        streetAddress:
            json["street_address"] == null ? null : json["street_address"],
        suiteNumber: json["suite_number"] == null ? null : json["suite_number"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        businessName:
            json["business_name"] == null ? null : json["business_name"],
        foundedYear: json["founded_year"] == null ? null : json["founded_year"],
        numberOfEmployees: json["number_of_employees"] == null
            ? null
            : json["number_of_employees"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        hourlyRate: json["hourly_rate"] == null ? null : json["hourly_rate"],
        startingRate: json["starting_rate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "earn": earn == null ? null : earn,
        "commission": commission == null ? null : commission,
        "total_earn": totalEarn == null ? null : totalEarn,
        "dob": dob,
        "street_address": streetAddress == null ? null : streetAddress,
        "suite_number": suiteNumber == null ? null : suiteNumber,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "business_name": businessName == null ? null : businessName,
        "founded_year": foundedYear == null ? null : foundedYear,
        "number_of_employees":
            numberOfEmployees == null ? null : numberOfEmployees,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "hourly_rate": hourlyRate == null ? null : hourlyRate,
        "starting_rate": startingRate,
      };
}

class ProviderService {
  ProviderService({
    this.id,
    this.providerId,
    this.serviceId,
    this.subServiceId,
    this.status,
    this.subService,
  });

  var id;
  var providerId;
  var serviceId;
  var subServiceId;
  var status;
  var subService;

  factory ProviderService.fromJson(Map<String, dynamic> json) =>
      ProviderService(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        status: json["status"] == null ? null : json["status"],
        subService: json["sub_service"] == null
            ? null
            : SubService.fromJson(json["sub_service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "service_id": serviceId == null ? null : serviceId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "status": status == null ? null : status,
        "sub_service": subService == null ? null : subService!.toJson(),
      };
}

class SubService {
  SubService({
    this.id,
    this.name,
  });

  var id;
  var name;

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Schedule {
  Schedule({
    this.id,
    this.providerId,
    this.day,
    this.fromTime,
    this.toTime,
    this.isCustom,
  });

  var id;
  var providerId;
  var day;
  var fromTime;
  var toTime;
  var isCustom;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        day: json["day"] == null ? null : json["day"],
        fromTime: json["from_time"] == null ? null : json["from_time"],
        toTime: json["to_time"] == null ? null : json["to_time"],
        isCustom: json["is_custom"] == null ? null : json["is_custom"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "provider_id": providerId == null ? null : providerId,
        "day": day == null ? null : day,
        "from_time": fromTime == null ? null : fromTime,
        "to_time": toTime == null ? null : toTime,
        "is_custom": isCustom == null ? null : isCustom,
      };
}

class PaymentMethods {
  PaymentMethods({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  var id;
  var name;
  var icon;
  var createdAt;
  var updatedAt;
  var pivot;

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "pivot": pivot == null ? null : pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    this.providerId,
    this.paymentMethodId,
  });

  var providerId;
  var paymentMethodId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        paymentMethodId: json["payment_method_id"] == null
            ? null
            : json["payment_method_id"],
      );

  Map<String, dynamic> toJson() => {
        "provider_id": providerId == null ? null : providerId,
        "payment_method_id": paymentMethodId == null ? null : paymentMethodId,
      };
}

class DocsLicense {
  DocsLicense({
    this.id,
    this.userId,
    this.type,
    this.name,
    this.url,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.quotationInfoId,
  });

  var id;
  var userId;
  var type;
  var name;
  var url;
  var verified;
  var createdAt;
  var updatedAt;
  var quotationInfoId;

  factory DocsLicense.fromJson(Map<String, dynamic> json) => DocsLicense(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        verified: json["verified"] == null ? null : json["verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        quotationInfoId: json["quotation_info_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "verified": verified == null ? null : verified,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "quotation_info_id": quotationInfoId,
      };
}
