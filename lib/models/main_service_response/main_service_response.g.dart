// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainServiceResponse _$MainServiceResponseFromJson(Map<String, dynamic> json) =>
    MainServiceResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MainServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainServiceResponseToJson(
        MainServiceResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };
