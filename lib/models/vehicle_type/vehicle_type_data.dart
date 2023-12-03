class VehicleTypeData {
  int? id;
  String? title;
  dynamic image;
  String? type;
  String? createdAt;
  String? updatedAt;
  bool? isSelected = false;

  VehicleTypeData(
      {this.id,
      this.title,
      this.image,
      this.type,
      this.createdAt,
      this.updatedAt});

  VehicleTypeData.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    image = json["image"];
    type = json["type"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["image"] = image;
    map["type"] = type;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }
}
