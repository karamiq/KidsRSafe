import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String uid,
    required String userId,
    required String postId,
    required String content,
    String? parentCommentId,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(0) int likes,
    @Default(0) int replies,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}
