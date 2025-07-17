import 'package:app/core/utils/annotations/json_serializable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_chat_model.freezed.dart';
part 'repo_chat_model.g.dart';

@freezed
abstract class RepoChatModel with _$RepoChatModel {
  @jsonSerializable
  const factory RepoChatModel({
    required String uid,
    required List<String> participants,
    required String lastMessage,
    required DateTime? lastMessageTime,
  }) = _RepoChatModel;

  factory RepoChatModel.fromJson(Map<String, dynamic> json) => _$RepoChatModelFromJson(json);
}
