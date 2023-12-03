import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'main_service_response.g.dart';

@JsonSerializable()
class MainServiceResponse extends Equatable {
  final bool? error;
  final String? message;
  final List<MainServiceModel>? data;

  const MainServiceResponse({this.error, this.message, this.data});

  factory MainServiceResponse.fromJson(Map<String, dynamic> json) {
    return _$MainServiceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MainServiceResponseToJson(this);

  MainServiceResponse copyWith({
    bool? error,
    String? message,
    List<MainServiceModel>? data,
  }) {
    return MainServiceResponse(
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [error, message, data];
}
