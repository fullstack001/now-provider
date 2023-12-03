class VehicleAddData {
  var vehicleTypeId;
  String? name;
  String? model;
  String? number;
  String? condition;
  String? companyName;
  int? providerId;
  String? updatedAt;
  String? createdAt;
  int? id;

  VehicleAddData({
      this.vehicleTypeId, 
      this.name, 
      this.model, 
      this.number, 
      this.condition, 
      this.companyName, 
      this.providerId, 
      this.updatedAt, 
      this.createdAt, 
      this.id});

  VehicleAddData.fromJson(dynamic json) {
    vehicleTypeId = json["vehicle_type_id"];
    name = json["name"];
    model = json["model"];
    number = json["number"];
    condition = json["condition"];
    companyName = json["company_name"];
    providerId = json["provider_id"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["vehicle_type_id"] = vehicleTypeId;
    map["name"] = name;
    map["model"] = model;
    map["number"] = number;
    map["condition"] = condition;
    map["company_name"] = companyName;
    map["provider_id"] = providerId;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

}