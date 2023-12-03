

import 'package:fare_now_provider/models/services_list/user_service_data.dart';

/// error : false
/// message : "success"
/// user_service_data : [{"id":1,"name":"Cleaning Services","user_sub_services":[{"id":1,"name":"Home Cleaning","service_id":1,"provider_sub_services":[]},{"id":2,"name":"Room cleaning","service_id":1,"provider_sub_services":[{"id":375,"sub_service_id":2,"status":1}]},{"id":11,"name":"Commercial Cleaning Service","service_id":1,"provider_sub_services":[{"id":368,"sub_service_id":11,"status":0}]},{"id":16,"name":"Vacation Rental Cleaning","service_id":1,"provider_sub_services":[]},{"id":17,"name":"Affordable Maids","service_id":1,"provider_sub_services":[]},{"id":18,"name":"Apartment Cleaning","service_id":1,"provider_sub_services":[]},{"id":19,"name":"Bedroom Cleaning","service_id":1,"provider_sub_services":[]},{"id":20,"name":"Maid Service","service_id":1,"provider_sub_services":[]},{"id":21,"name":"House Keeping","service_id":1,"provider_sub_services":[]},{"id":28,"name":"Kitchen Cleaning","service_id":1,"provider_sub_services":[]},{"id":29,"name":"Living Room Cleaning","service_id":1,"provider_sub_services":[]},{"id":30,"name":"Local Cleaning Service","service_id":1,"provider_sub_services":[]},{"id":31,"name":"Same Day Cleaning","service_id":1,"provider_sub_services":[]},{"id":36,"name":"Move in and out Cleaning","service_id":1,"provider_sub_services":[]},{"id":37,"name":"Room Cleaning","service_id":1,"provider_sub_services":[]},{"id":38,"name":"Home Cleaning","service_id":1,"provider_sub_services":[]},{"id":39,"name":"Office Cleaning","service_id":1,"provider_sub_services":[]},{"id":40,"name":"Kitchen Cleaning","service_id":1,"provider_sub_services":[]},{"id":41,"name":"Sanitization/Fumigation","service_id":1,"provider_sub_services":[]},{"id":42,"name":"House Cleaning Service","service_id":1,"provider_sub_services":[]},{"id":43,"name":"Home Sanitization","service_id":1,"provider_sub_services":[]},{"id":44,"name":"Commercial Sanitization","service_id":1,"provider_sub_services":[]}]},{"id":2,"name":"Handyman Services","sub_services":[{"id":6,"name":"Plumbing","service_id":2,"provider_sub_services":[]},{"id":7,"name":"Electrician","service_id":2,"provider_sub_services":[]},{"id":8,"name":"Gardening","service_id":2,"provider_sub_services":[]},{"id":25,"name":"Kitchen hood","service_id":2,"provider_sub_services":[]},{"id":32,"name":"Home Furniture and Assembly","service_id":2,"provider_sub_services":[]},{"id":45,"name":"Painting","service_id":2,"provider_sub_services":[]}]},{"id":3,"name":"Moving Services","sub_services":[{"id":3,"name":"Apartment Moving","service_id":3,"provider_sub_services":[]},{"id":4,"name":"House moving","service_id":3,"provider_sub_services":[]},{"id":5,"name":"Office Moving","service_id":3,"provider_sub_services":[]},{"id":12,"name":"Office Moving","service_id":3,"provider_sub_services":[]},{"id":33,"name":"Furniture Rearrangement","service_id":3,"provider_sub_services":[]},{"id":34,"name":"Junk Removal Services","service_id":3,"provider_sub_services":[]},{"id":35,"name":"Packing","service_id":3,"provider_sub_services":[]}]},{"id":4,"name":"Electrical Services","sub_services":[{"id":9,"name":"TV Repairs","service_id":4,"provider_sub_services":[]},{"id":13,"name":"AC Repair","service_id":4,"provider_sub_services":[]},{"id":14,"name":"Refrigerator Repair","service_id":4,"provider_sub_services":[]},{"id":22,"name":"TV Wall Mount & Installation","service_id":4,"provider_sub_services":[]},{"id":23,"name":"Ceiling Fan","service_id":4,"provider_sub_services":[]},{"id":24,"name":"Smart Home","service_id":4,"provider_sub_services":[]},{"id":26,"name":"Indoor Lighting","service_id":4,"provider_sub_services":[]},{"id":27,"name":"Outdoor Lighting","service_id":4,"provider_sub_services":[]}]}]

class UserServiceModel {
  UserServiceModel({
      this.error, 
      this.message, 
      this.userServiceData,});

  UserServiceModel.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      userServiceData = [];
      json['data'].forEach((v) {
        userServiceData?.add(UserServiceData.fromJson(v));
      });
    }
  }
  bool? error;
  String? message;
  List<UserServiceData>? userServiceData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    if (userServiceData != null) {
      map['data'] = userServiceData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}