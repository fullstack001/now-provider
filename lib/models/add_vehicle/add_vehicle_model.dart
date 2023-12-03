class AddVehicleModel {
  var vehicleTypeId;
  var name;
  var model;
  var number;
  var condition;
  var companyName;
  var image;

  AddVehicleModel(
      {this.vehicleTypeId,
      this.name,
      this.model,
      this.number,
      this.condition,
      this.companyName,
      this.image,});

  AddVehicleModel.fromJson(dynamic json) {
    vehicleTypeId = json["vehicle_type_id"];
    name = json["name"];
    model = json["model"];
    number = json["number"];
    condition = json["condition"];
    companyName = json["company_name"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["vehicle_type_id"] = vehicleTypeId;
    map["image"] = image;
    map["name"] = name;
    map["model"] = model;
    map["number"] = number;
    map["condition"] = condition;
    map["company_name"] = companyName;
    return map;
  }
}
