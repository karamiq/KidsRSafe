import 'package:freezed_annotation/freezed_annotation.dart';

part 'moderation_model.freezed.dart';
part 'moderation_model.g.dart';

enum ModerationAction { approve, reject, flag, ban }

@freezed
abstract class ModerationModel with _$ModerationModel {
  const factory ModerationModel({
    required String uid,
    required String postId,
    required String submittedBy,
    required String status,
    required DateTime createdAt,
    String? assignedTo,
    ModerationAction? moderationAction,
    String? moderationReason,
    DateTime? moderatedAt,
  }) = _ModerationModel;

  factory ModerationModel.fromJson(Map<String, dynamic> json) => _$ModerationModelFromJson(json);
}
