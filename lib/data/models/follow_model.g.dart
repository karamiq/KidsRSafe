// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FollowModel _$FollowModelFromJson(Map<String, dynamic> json) => _FollowModel(
      followerId: json['followerId'] as String,
      followingId: json['followingId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FollowModelToJson(_FollowModel instance) =>
    <String, dynamic>{
      'followerId': instance.followerId,
      'followingId': instance.followingId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
