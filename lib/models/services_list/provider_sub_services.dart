/// id : 375
/// sub_service_id : 2
/// status : 1

class ProviderSubServices {
  ProviderSubServices({
      this.id, 
      this.subServiceId, 
      this.status,});

  ProviderSubServices.fromJson(dynamic json) {
    id = json['id'];
    subServiceId = json['sub_service_id'];
    status = json['status'];
  }
  int? id;
  int? subServiceId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sub_service_id'] = subServiceId;
    map['status'] = status;
    return map;
  }

}