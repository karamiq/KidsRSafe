// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LikeModel _$LikeModelFromJson(Map<String, dynamic> json) => _LikeModel(
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LikeModelToJson(_LikeModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'postId': instance.postId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
