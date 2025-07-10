import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_model.freezed.dart';
part 'follow_model.g.dart';

@freezed
abstract class FollowModel with _$FollowModel {
  const factory FollowModel({
    required String followerId,
    required String followingId,
    required DateTime createdAt,
  }) = _FollowModel;

  factory FollowModel.fromJson(Map<String, dynamic> json) => _$FollowModelFromJson(json);
}
