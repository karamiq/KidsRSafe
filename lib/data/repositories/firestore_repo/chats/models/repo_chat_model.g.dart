// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RepoChatModel _$RepoChatModelFromJson(Map<String, dynamic> json) =>
    _RepoChatModel(
      uid: json['uid'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: json['lastMessageTime'] == null
          ? null
          : DateTime.parse(json['lastMessageTime'] as String),
    );

Map<String, dynamic> _$RepoChatModelToJson(_RepoChatModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'participants': instance.participants,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime?.toIso8601String(),
    };
