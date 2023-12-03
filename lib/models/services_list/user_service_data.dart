import 'package:fare_now_provider/models/services_list/user_sub_services.dart';

/// id : 1
/// name : "Cleaning Services"
/// user_sub_services : [{"id":1,"name":"Home Cleaning","service_id":1,"provider_sub_services":[]},{"id":2,"name":"Room cleaning","service_id":1,"provider_sub_services":[{"id":375,"sub_service_id":2,"status":1}]},{"id":11,"name":"Commercial Cleaning Service","service_id":1,"provider_sub_services":[{"id":368,"sub_service_id":11,"status":0}]},{"id":16,"name":"Vacation Rental Cleaning","service_id":1,"provider_sub_services":[]},{"id":17,"name":"Affordable Maids","service_id":1,"provider_sub_services":[]},{"id":18,"name":"Apartment Cleaning","service_id":1,"provider_sub_services":[]},{"id":19,"name":"Bedroom Cleaning","service_id":1,"provider_sub_services":[]},{"id":20,"name":"Maid Service","service_id":1,"provider_sub_services":[]},{"id":21,"name":"House Keeping","service_id":1,"provider_sub_services":[]},{"id":28,"name":"Kitchen Cleaning","service_id":1,"provider_sub_services":[]},{"id":29,"name":"Living Room Cleaning","service_id":1,"provider_sub_services":[]},{"id":30,"name":"Local Cleaning Service","service_id":1,"provider_sub_services":[]},{"id":31,"name":"Same Day Cleaning","service_id":1,"provider_sub_services":[]},{"id":36,"name":"Move in and out Cleaning","service_id":1,"provider_sub_services":[]},{"id":37,"name":"Room Cleaning","service_id":1,"provider_sub_services":[]},{"id":38,"name":"Home Cleaning","service_id":1,"provider_sub_services":[]},{"id":39,"name":"Office Cleaning","service_id":1,"provider_sub_services":[]},{"id":40,"name":"Kitchen Cleaning","service_id":1,"provider_sub_services":[]},{"id":41,"name":"Sanitization/Fumigation","service_id":1,"provider_sub_services":[]},{"id":42,"name":"House Cleaning Service","service_id":1,"provider_sub_services":[]},{"id":43,"name":"Home Sanitization","service_id":1,"provider_sub_services":[]},{"id":44,"name":"Commercial Sanitization","service_id":1,"provider_sub_services":[]}]

class UserServiceData {
  UserServiceData({
    this.id,
    this.name,
    this.userSubServices,
  });

  UserServiceData.fromJson(dynamic json) {
    bool stus = json['status'] ?? false;
    id = json['id'];
    name = json['name'];
    status = stus ? 1 : 0;
    if (json['sub_services'] != null) {
      userSubServices = [];
      json['sub_services'].forEach((v) {
        userSubServices?.add(UserSubServices.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  int? status;
  bool expand = false;
  List<UserSubServices>? userSubServices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (userSubServices != null) {
      map['sub_services'] = userSubServices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
