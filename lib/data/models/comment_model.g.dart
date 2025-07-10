// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      uid: json['uid'] as String,
      userId: json['userId'] as String,
      postId: json['postId'] as String,
      content: json['content'] as String,
      parentCommentId: json['parentCommentId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      replies: (json['replies'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userId': instance.userId,
      'postId': instance.postId,
      'content': instance.content,
      'parentCommentId': instance.parentCommentId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'likes': instance.likes,
      'replies': instance.replies,
    };
