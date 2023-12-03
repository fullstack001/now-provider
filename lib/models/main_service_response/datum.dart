import 'package:equatable/equatable.dart';
import 'sub_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class MainServiceModel extends Equatable {
  final int? id;
  @JsonKey(name: 'country_id')
  final int? countryId;
  final String? name;
  final int? status;
  @JsonKey(name: 'og_title')
  final dynamic ogTitle;
  @JsonKey(name: 'og_description')
  final dynamic ogDescription;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;
  final String? image;
  @JsonKey(name: 'sub_services')
  final List<MainSubService>? subServices;

  MainServiceModel({
    this.id,
    this.countryId,
    this.name,
    this.status,
    this.ogTitle,
    this.ogDescription,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.subServices,
  });
  // bool expand = false;

  factory MainServiceModel.fromJson(Map<String, dynamic> json) =>
      _$MainServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainServiceModelToJson(this);

  MainServiceModel copyWith({
    int? id,
    int? countryId,
    String? name,
    int? status,
    dynamic ogTitle,
    dynamic ogDescription,
    dynamic createdAt,
    dynamic updatedAt,
    String? image,
    List<MainSubService>? subServices,
  }) {
    return MainServiceModel(
      id: id ?? this.id,
      countryId: countryId ?? this.countryId,
      name: name ?? this.name,
      status: status ?? this.status,
      ogTitle: ogTitle ?? this.ogTitle,
      ogDescription: ogDescription ?? this.ogDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      subServices: subServices ?? this.subServices,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      countryId,
      name,
      status,
      ogTitle,
      ogDescription,
      createdAt,
      updatedAt,
      image,
      subServices,
    ];
  }
}
