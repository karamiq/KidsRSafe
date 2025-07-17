import 'package:app/core/utils/annotations/json_serializable.dart';
import 'package:app/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  @jsonSerializable
  const factory ChatModel({
    required String uid,
    required UserModel oppositeUser,
    required String lastMessage,
    required DateTime lastMessageTime,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);
}
