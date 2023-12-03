import 'dart:io';

class PortfioData {
  PortfioData(
      {this.id,
      this.title,
      this.providerId,
      this.url,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.status});

  PortfioData.fromJson(dynamic json) {
    id = json['id'];
    title = json["title"];
    providerId = json['provider_id'];
    url = json['image'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  var id;
  var providerId;
  var url;
  var description;
  var createdAt;
  var updatedAt;
  var image;
  var title;
  var status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['provider_id'] = providerId;
    map['image'] = url;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['status'] = status;
    return map;
  }
}
