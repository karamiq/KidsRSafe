import 'package:app/core/utils/annotations/json_serializable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@JsonEnum(alwaysCreate: true)
enum NotificationType {
  @JsonValue('post')
  post,
  @JsonValue('comment')
  comment,
  @JsonValue('like')
  like,
  @JsonValue('post_rejected')
  postRejected,
  @JsonValue('post_approved')
  postApproved,
  @JsonValue('post_pending')
  postPending;

  factory NotificationType.fromJson(String json) =>
      NotificationType.values.firstWhere((e) => e.toJson() == json);
  String toJson() => name;
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  @jsonSerializable
  const factory NotificationModel({
    required String uid,
    required String userUid,
    required String title,
    required String body,
    required DateTime createdAt,
    required NotificationType type,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}
