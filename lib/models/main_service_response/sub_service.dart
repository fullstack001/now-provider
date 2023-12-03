import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_service.g.dart';

@JsonSerializable()
class MainSubService extends Equatable {
  final int? id;
  @JsonKey(name: 'service_id')
  final int? serviceId;
  final String? name;
  final dynamic credit;
  final int? status;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;
  final String? image;
  final String? terms;
  final bool isSelected;

  const MainSubService({
    this.id,
    this.serviceId,
    this.name,
    this.credit,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.terms,
    this.isSelected = false,
  });

  factory MainSubService.fromJson(Map<String, dynamic> json) {
    return _$MainSubServiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MainSubServiceToJson(this);

  MainSubService copyWith({
    int? id,
    int? serviceId,
    String? name,
    dynamic credit,
    int? status,
    dynamic createdAt,
    dynamic updatedAt,
    String? image,
    String? terms,
    bool? isSelected,
  }) {
    return MainSubService(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      name: name ?? this.name,
      credit: credit ?? this.credit,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      terms: terms ?? this.terms,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      serviceId,
      name,
      credit,
      status,
      createdAt,
      updatedAt,
      image,
      terms,
      isSelected,
    ];
  }
}
