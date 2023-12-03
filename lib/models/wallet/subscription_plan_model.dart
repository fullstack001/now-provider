class SubscriptionPlan {
  SubscriptionPlan({
    this.error,
    this.status,
    this.data,
    this.message,
  });

  bool? error;
  String? status;
  List<SubscriptionPlanData>? data;
  String? message;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        error: json["error"] == null ? null : json["error"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<SubscriptionPlanData>.from(
                json["data"].map((x) => SubscriptionPlanData.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
      );
}

class SubscriptionPlanData {
  SubscriptionPlanData({
    this.id,
    this.providerId,
    this.title,
    this.stripeId,
    this.stripeName,
    this.price,
    this.credit,
    this.type,
    this.duration,
    this.off,
    this.threshold,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  dynamic providerId;
  String? title;
  dynamic stripeId;
  String? stripeName;
  String? price;
  String? credit;
  dynamic type;
  dynamic duration;
  dynamic off;
  String? threshold;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory SubscriptionPlanData.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanData(
        id: json["id"] == null ? null : json["id"],
        providerId: json["provider_id"],
        title: json["title"] == null ? null : json["title"],
        stripeId: json["stripe_id"],
        stripeName: json["stripe_name"] == null ? null : json["stripe_name"],
        price: json["price"] == null ? null : json["price"],
        credit: json["credit"] == null ? null : json["credit"],
        type: json["type"],
        duration: json["duration"],
        off: json["off"],
        threshold: json["threshold"] == null ? null : json["threshold"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );
}
