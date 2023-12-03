/// image : "The image format is invalid."

class ProviderProfileErrors {
  String? image;

  ProviderProfileErrors({
      this.image});

  ProviderProfileErrors.fromJson(dynamic json) {
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = image;
    return map;
  }

}