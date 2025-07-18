import 'package:app/core/utils/annotations/json_serializable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@JsonEnum(alwaysCreate: true)
enum PostStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected;
}

@JsonEnum(alwaysCreate: true)
enum PostType {
  @JsonValue('video')
  video,
  @JsonValue('photo')
  photo;
}

// Application model: contains full UserModel
@freezed
abstract class PostModel with _$PostModel {
  @jsonSerializable
  const factory PostModel({
    required String uid,
    required String title,
    required UserModel user,
    required PostType type,
    required List<String> urls,
    required String caption,
    int? duration,
    required PostStatus status,
    required DateTime createdAt,
    required int likes,
    required int saves,
    required int views,
    required int comments,
    String? moderatorUid,
    DateTime? moderatedAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}
