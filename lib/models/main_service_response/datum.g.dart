// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainServiceModel _$MainServiceModelFromJson(Map<String, dynamic> json) =>
    MainServiceModel(
      id: json['id'] as int?,
      countryId: json['country_id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      ogTitle: json['og_title'],
      ogDescription: json['og_description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'] as String?,
      subServices: (json['sub_services'] as List<dynamic>?)
          ?.map((e) => MainSubService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainServiceModelToJson(MainServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country_id': instance.countryId,
      'name': instance.name,
      'status': instance.status,
      'og_title': instance.ogTitle,
      'og_description': instance.ogDescription,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'sub_services': instance.subServices,
    };
