import 'package:fare_now_provider/models/services_list/provider_sub_services.dart';

/// id : 1
/// name : "Home Cleaning"
/// service_id : 1
/// provider_sub_services : []

class UserSubServices {
  UserSubServices({
      this.id, 
      this.name, 
      this.serviceId, 
      this.providerSubServices,});

  UserSubServices.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    serviceId = json['service_id'];
    if (json['provider_sub_services'] != null) {
      providerSubServices = [];
      json['provider_sub_services'].forEach((v) {
        providerSubServices?.add(ProviderSubServices.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  int? serviceId;
  List<ProviderSubServices>? providerSubServices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['service_id'] = serviceId;
    if (providerSubServices != null) {
      map['provider_sub_services'] = providerSubServices?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}