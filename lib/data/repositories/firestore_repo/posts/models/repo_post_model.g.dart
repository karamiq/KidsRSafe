// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RepoPostModel _$RepoPostModelFromJson(Map<String, dynamic> json) =>
    _RepoPostModel(
      uid: json['uid'] as String,
      title: json['title'] as String,
      userUid: json['userUid'] as String,
      type: $enumDecode(_$PostTypeEnumMap, json['type']),
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
      caption: json['caption'] as String,
      duration: (json['duration'] as num?)?.toInt(),
      status: $enumDecode(_$PostStatusEnumMap, json['status']),
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

Map<String, dynamic> _$RepoPostModelToJson(_RepoPostModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'userUid': instance.userUid,
      'type': _$PostTypeEnumMap[instance.type]!,
      'urls': instance.urls,
      'caption': instance.caption,
      'duration': instance.duration,
      'status': _$PostStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'likes': instance.likes,
      'saves': instance.saves,
      'views': instance.views,
      'comments': instance.comments,
      'moderatorUid': instance.moderatorUid,
      'moderatedAt': instance.moderatedAt?.toIso8601String(),
    };

const _$PostTypeEnumMap = {
  PostType.video: 'video',
  PostType.photo: 'photo',
};

const _$PostStatusEnumMap = {
  PostStatus.pending: 'pending',
  PostStatus.approved: 'approved',
  PostStatus.rejected: 'rejected',
};
