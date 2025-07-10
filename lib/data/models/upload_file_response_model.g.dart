// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadFileResponseModel _$UploadFileResponseModelFromJson(
        Map<String, dynamic> json) =>
    _UploadFileResponseModel(
      path: json['path'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$UploadFileResponseModelToJson(
        _UploadFileResponseModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'url': instance.url,
    };
