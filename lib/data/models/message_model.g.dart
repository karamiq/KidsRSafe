// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      uid: json['uid'] as String,
      senderUid: json['senderUid'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      readBy:
          (json['readBy'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'senderUid': instance.senderUid,
      'text': instance.text,
      'timestamp': instance.timestamp.toIso8601String(),
      'readBy': instance.readBy,
    };
