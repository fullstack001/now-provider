

import 'package:fare_now_provider/models/service_update/service_updateData.dart';

/// error : false
/// message : "success"
/// service_update_data : {"provider_id":368,"service_id":1,"sub_service_id":2,"updated_at":"2022-05-24T09:44:30.000000Z","created_at":"2022-05-24T09:44:30.000000Z","id":375}

class ServiceUpdateModel {
  ServiceUpdateModel({
      this.error, 
      this.message, 
      this.serviceUpdateData,});

  ServiceUpdateModel.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    serviceUpdateData = json['data'] != null ? ServiceUpdateData.fromJson(json['data']) : null;
  }
  bool? error;
  String? message;
  ServiceUpdateData? serviceUpdateData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    if (serviceUpdateData != null) {
      map['data'] = serviceUpdateData?.toJson();
    }
    return map;
  }

}