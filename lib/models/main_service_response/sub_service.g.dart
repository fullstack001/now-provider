// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainSubService _$MainSubServiceFromJson(Map<String, dynamic> json) =>
    MainSubService(
      id: json['id'] as int?,
      serviceId: json['service_id'] as int?,
      name: json['name'] as String?,
      credit: json['credit'],
      status: json['status'] as int?,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['image'] as String?,
      terms: json['terms'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$MainSubServiceToJson(MainSubService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_id': instance.serviceId,
      'name': instance.name,
      'credit': instance.credit,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'terms': instance.terms,
      'isSelected': instance.isSelected,
    };
