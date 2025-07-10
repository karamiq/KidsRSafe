import 'package:freezed_annotation/freezed_annotation.dart';

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

  factory PostStatus.fromJson(String json) => PostStatus.values.firstWhere((e) => e.toJson() == json);
  String toJson() => name;
}

@JsonEnum(alwaysCreate: true)
enum PostType {
  @JsonValue('video')
  video,
  @JsonValue('photo')
  photo;

  factory PostType.fromJson(String json) => PostType.values.firstWhere((e) => e.toJson() == json);
  String toJson() => name;
}

@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required String uid,
    required String title,
    required String userUid,
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
