import 'package:app/core/utils/annotations/annotations_lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  @jsonSerializable
  const factory UserModel({
    required String uid,
    required String email,
    required String name,
    required String profilePicture,
    required UserRole role,
    required DateTime dateOfBirth,
    required String? parentEmail,
    required DateTime createdAt,
    required UserStatus status,
    required String? assignedModerator,
    @Default(false) bool parentalApproved,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@JsonEnum(alwaysCreate: true)
enum UserRole {
  @JsonValue('kid')
  kid,
  @JsonValue('moderator')
  moderator,
  @JsonValue('admin')
  admin;
}

@JsonEnum(alwaysCreate: true)
enum UserStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('banned')
  banned;
}
