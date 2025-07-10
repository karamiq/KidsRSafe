// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
      uid: json['uid'] as String,
      title: json['title'] as String,
      userUid: json['userUid'] as String,
      type: PostType.fromJson(json['type'] as String),
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      caption: json['caption'] as String,
      duration: (json['duration'] as num?)?.toInt(),
      status: PostStatus.fromJson(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      likes: (json['likes'] as num).toInt(),
      saves: (json['saves'] as num).toInt(),
      views: (json['views'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
      moderatorUid: json['moderatorUid'] as String?,
      moderatedAt: json['moderatedAt'] == null
          ? null
          : DateTime.parse(json['moderatedAt'] as String),
    );

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'userUid': instance.userUid,
      'type': instance.type,
      'urls': instance.urls,
      'caption': instance.caption,
      'duration': instance.duration,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'likes': instance.likes,
      'saves': instance.saves,
      'views': instance.views,
      'comments': instance.comments,
      'moderatorUid': instance.moderatorUid,
      'moderatedAt': instance.moderatedAt?.toIso8601String(),
    };

const _$PostStatusEnumMap = {
  PostStatus.pending: 'pending',
  PostStatus.approved: 'approved',
  PostStatus.rejected: 'rejected',
};

const _$PostTypeEnumMap = {
  PostType.video: 'video',
  PostType.photo: 'photo',
};
