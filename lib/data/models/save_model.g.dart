// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaveModel _$SaveModelFromJson(Map<String, dynamic> json) => _SaveModel(
      userUid: json['userUid'] as String,
      postUid: json['postUid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SaveModelToJson(_SaveModel instance) =>
    <String, dynamic>{
      'userUid': instance.userUid,
      'postUid': instance.postUid,
      'createdAt': instance.createdAt.toIso8601String(),
    };
