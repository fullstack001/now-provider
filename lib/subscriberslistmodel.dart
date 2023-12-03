//     final subscribersListModel = subscribersListModelFromMap(jsonString);

import 'dart:convert';

SubscribersListModel subscribersListModelFromMap(String str) =>
    SubscribersListModel.fromMap(json.decode(str));

String subscribersListModelToMap(SubscribersListModel data) =>
    json.encode(data.toMap());

class SubscribersListModel {
  SubscribersListModel({
    this.error,
    this.message,
    this.data,
    this.links,
    this.meta,
  });

  var error;
  var message;
  var data;
  var links;
  var meta;

  factory SubscribersListModel.fromMap(Map<String, dynamic> json) =>
      SubscribersListModel(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        links: json["links"] == null ? null : Links.fromMap(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromMap(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
        "links": links == null ? null : links.toMap(),
        "meta": meta == null ? null : meta.toMap(),
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.planId,
    this.serviceRequestId,
    this.type,
    this.duration,
    this.off,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.serviceRequest,
    this.subscriptionHistories,
  });

  var id;
  var userId;
  var planId;
  var serviceRequestId;
  var type;
  var duration;
  var off;
  var startDate;
  var endDate;
  var status;
  var createdAt;
  var updatedAt;
  dynamic deletedAt;
  var user;
  var serviceRequest;
  var subscriptionHistories;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        planId: json["plan_id"] == null ? null : json["plan_id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        type: json["type"] == null ? null : json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        off: json["off"] == null ? null : json["off"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        serviceRequest: json["service_request"] == null
            ? null
            : ServiceRequest.fromMap(json["service_request"]),
        subscriptionHistories: json["subscription_histories"] == null
            ? null
            : List<SubscriptionHistory>.from(json["subscription_histories"]
                .map((x) => SubscriptionHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "plan_id": planId == null ? null : planId,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "type": type == null ? null : type,
        "duration": duration == null ? null : duration,
        "off": off == null ? null : off,
        "start_date": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "user": user == null ? null : user.toMap(),
        "service_request":
            serviceRequest == null ? null : serviceRequest.toMap(),
        "subscription_histories": subscriptionHistories == null
            ? null
            : List<dynamic>.from(subscriptionHistories.map((x) => x.toMap())),
      };
}

class ServiceRequest {
  ServiceRequest({
    this.id,
    this.userId,
    this.subServiceId,
    this.date,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.providerId,
    this.quotationInfoId,
    this.hours,
    this.isQuotation,
    this.directContact,
    this.isReplied,
    this.isCompleted,
    this.workedHours,
    this.workingStatus,
    this.subService,
    this.paymentStatus,
    this.paidAmount,
    this.payableAmount,
    this.type,
  });

  var id;
  var userId;
  var subServiceId;
  dynamic date;
  var address;
  var status;
  var createdAt;
  var updatedAt;
  var providerId;
  dynamic quotationInfoId;
  var hours;
  var isQuotation;
  var directContact;
  var isReplied;
  var isCompleted;
  dynamic workedHours;
  dynamic workingStatus;
  var subService;
  dynamic paymentStatus;
  var paidAmount;
  dynamic payableAmount;
  var type;

  factory ServiceRequest.fromMap(Map<String, dynamic> json) => ServiceRequest(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        subServiceId:
            json["sub_service_id"] == null ? null : json["sub_service_id"],
        date: json["date"],
        address: json["address"] == null ? null : json["address"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        quotationInfoId: json["quotation_info_id"],
        hours: json["hours"] == null ? null : json["hours"],
        isQuotation: json["is_quotation"] == null ? null : json["is_quotation"],
        directContact:
            json["direct_contact"] == null ? null : json["direct_contact"],
        isReplied: json["is_replied"] == null ? null : json["is_replied"],
        isCompleted: json["is_completed"] == null ? null : json["is_completed"],
        workedHours: json["worked_hours"],
        workingStatus: json["working_status"],
        subService: json["sub_service"] == null ? null : json["sub_service"],
        paymentStatus: json["payment_status"],
        paidAmount: json["paid_amount"] == null ? null : json["paid_amount"],
        payableAmount: json["payable_amount"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "sub_service_id": subServiceId == null ? null : subServiceId,
        "date": date,
        "address": address == null ? null : address,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "provider_id": providerId == null ? null : providerId,
        "quotation_info_id": quotationInfoId,
        "hours": hours == null ? null : hours,
        "is_quotation": isQuotation == null ? null : isQuotation,
        "direct_contact": directContact == null ? null : directContact,
        "is_replied": isReplied == null ? null : isReplied,
        "is_completed": isCompleted == null ? null : isCompleted,
        "worked_hours": workedHours,
        "working_status": workingStatus,
        "sub_service": subService == null ? null : subService,
        "payment_status": paymentStatus,
        "paid_amount": paidAmount == null ? null : paidAmount,
        "payable_amount": payableAmount,
        "type": type == null ? null : type,
      };
}

class SubscriptionHistory {
  SubscriptionHistory({
    this.id,
    this.providersSubscriptionId,
    this.serviceRequestId,
    this.transactionId,
    this.deductionDate,
    this.discount,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  var id;
  var providersSubscriptionId;
  var serviceRequestId;
  var transactionId;
  var deductionDate;
  dynamic discount;
  var status;
  dynamic description;
  var createdAt;
  var updatedAt;
  dynamic deletedAt;

  factory SubscriptionHistory.fromMap(Map<String, dynamic> json) =>
      SubscriptionHistory(
        id: json["id"] == null ? null : json["id"],
        providersSubscriptionId: json["providers_subscription_id"] == null
            ? null
            : json["providers_subscription_id"],
        serviceRequestId: json["service_request_id"] == null
            ? null
            : json["service_request_id"],
        transactionId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        deductionDate: json["deduction_date"] == null
            ? null
            : DateTime.parse(json["deduction_date"]),
        discount: json["discount"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "providers_subscription_id":
            providersSubscriptionId == null ? null : providersSubscriptionId,
        "service_request_id":
            serviceRequestId == null ? null : serviceRequestId,
        "transaction_id": transactionId == null ? null : transactionId,
        "deduction_date": deductionDate == null
            ? null
            : "${deductionDate.year.toString().padLeft(4, '0')}-${deductionDate.month.toString().padLeft(2, '0')}-${deductionDate.day.toString().padLeft(2, '0')}",
        "discount": discount,
        "status": status == null ? null : status,
        "description": description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class User {
  User({
    this.id,
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
  });

  var id;
  var firstName;
  var lastName;
  var email;
  dynamic emailVerifiedAt;
  var phone;
  var zipCode;
  var role;
  var status;
  var createdAt;
  var updatedAt;
  dynamic deletedAt;
  var phoneVerification;
  dynamic spendEachMonth;
  var providerType;
  var image;
  var bio;
  var accountType;
  var deviceToken;
  dynamic osPlatform;
  dynamic credit;
  var stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  var rating;
  dynamic serviceType;
  dynamic socialId;
  dynamic socialType;
  dynamic verifiedAt;

  factory User.fromMap(Map<String, dynamic> json) => User(
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
        spendEachMonth: json["spend_each_month"],
        providerType:
            json["provider_type"] == null ? null : json["provider_type"],
        image: json["image"] == null ? null : json["image"],
        bio: json["bio"] == null ? null : json["bio"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        osPlatform: json["os_platform"],
        credit: json["credit"],
        stripeId: json["stripe_id"] == null ? null : json["stripe_id"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        rating: json["rating"] == null ? null : json["rating"],
        serviceType: json["service_type"],
        socialId: json["social_id"],
        socialType: json["social_type"],
        verifiedAt: json["verified_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone == null ? null : phone,
        "zip_code": zipCode == null ? null : zipCode,
        "role": role == null ? null : role,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "phone_verification":
            phoneVerification == null ? null : phoneVerification,
        "spend_each_month": spendEachMonth,
        "provider_type": providerType == null ? null : providerType,
        "image": image == null ? null : image,
        "bio": bio == null ? null : bio,
        "account_type": accountType == null ? null : accountType,
        "device_token": deviceToken == null ? null : deviceToken,
        "os_platform": osPlatform,
        "credit": credit,
        "stripe_id": stripeId == null ? null : stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "rating": rating == null ? null : rating,
        "service_type": serviceType,
        "social_id": socialId,
        "social_type": socialType,
        "verified_at": verifiedAt,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  var first;
  var last;
  var prev;
  dynamic next;

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        first: json["first"] == null ? null : json["first"],
        last: json["last"] == null ? null : json["last"],
        prev: json["prev"] == null ? null : json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toMap() => {
        "first": first == null ? null : first,
        "last": last == null ? null : last,
        "prev": prev == null ? null : prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  var currentPage;
  var from;
  var lastPage;
  var path;
  var perPage;
  var to;
  var total;

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null : currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}
