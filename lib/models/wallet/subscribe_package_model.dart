// To parse this JSON data, do
//
//     final subscribePackageResponse = subscribePackageResponseFromJson(jsonString);

class SubscribePackageResponse {
  SubscribePackageResponse({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  Data? data;
  String? message;

  factory SubscribePackageResponse.fromJson(Map<String, dynamic> json) =>
      SubscribePackageResponse(
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );
}

class Data {
  Data({
    this.providerId,
    this.paymentId,
    this.amount,
    this.amountCaptured,
    this.status,
    this.paymentMethod,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int? providerId;
  String? paymentId;
  String? amount;
  int? amountCaptured;
  String? status;
  String? paymentMethod;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        paymentId: json["payment_id"] == null ? null : json["payment_id"],
        amount: json["amount"] == null ? null : json["amount"],
        amountCaptured:
            json["amount_captured"] == null ? null : json["amount_captured"],
        status: json["status"] == null ? null : json["status"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );
}
