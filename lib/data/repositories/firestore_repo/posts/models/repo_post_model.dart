// Repository model: contains only userUid
import 'package:app/core/utils/annotations/json_serializable.dart';
import 'package:app/data/models/post_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_post_model.freezed.dart';
part 'repo_post_model.g.dart';

@freezed
abstract class RepoPostModel with _$RepoPostModel {
  @jsonSerializable
  const factory RepoPostModel({
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
  }) = _RepoPostModel;

  factory RepoPostModel.fromJson(Map<String, dynamic> json) => _$RepoPostModelFromJson(json);
}
