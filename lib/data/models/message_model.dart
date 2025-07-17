import 'package:app/core/utils/annotations/annotations_lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  @jsonSerializable
  const factory MessageModel({
    required String uid,
    required String senderUid,
    required String text,
    required DateTime timestamp,
    required List<String> readBy,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
