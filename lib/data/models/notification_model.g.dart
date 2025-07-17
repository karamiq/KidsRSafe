// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      uid: json['uid'] as String,
      userUid: json['userUid'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: NotificationType.fromJson(json['type'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userUid': instance.userUid,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt.toIso8601String(),
      'type': instance.type.toJson(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.post: 'post',
  NotificationType.comment: 'comment',
  NotificationType.like: 'like',
  NotificationType.postRejected: 'post_rejected',
  NotificationType.postApproved: 'post_approved',
  NotificationType.postPending: 'post_pending',
};
