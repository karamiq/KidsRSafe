// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moderation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModerationModel _$ModerationModelFromJson(Map<String, dynamic> json) =>
    _ModerationModel(
      uid: json['uid'] as String,
      postId: json['postId'] as String,
      submittedBy: json['submittedBy'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      assignedTo: json['assignedTo'] as String?,
      moderationAction: $enumDecodeNullable(
          _$ModerationActionEnumMap, json['moderationAction']),
      moderationReason: json['moderationReason'] as String?,
      moderatedAt: json['moderatedAt'] == null
          ? null
          : DateTime.parse(json['moderatedAt'] as String),
    );

Map<String, dynamic> _$ModerationModelToJson(_ModerationModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'postId': instance.postId,
      'submittedBy': instance.submittedBy,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'assignedTo': instance.assignedTo,
      'moderationAction': _$ModerationActionEnumMap[instance.moderationAction],
      'moderationReason': instance.moderationReason,
      'moderatedAt': instance.moderatedAt?.toIso8601String(),
    };

const _$ModerationActionEnumMap = {
  ModerationAction.approve: 'approve',
  ModerationAction.reject: 'reject',
  ModerationAction.flag: 'flag',
  ModerationAction.ban: 'ban',
};
