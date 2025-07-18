// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      profilePicture: json['profilePicture'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      parentEmail: json['parentEmail'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      assignedModerator: json['assignedModerator'] as String?,
      parentalApproved: json['parentalApproved'] as bool? ?? false,
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
      'role': _$UserRoleEnumMap[instance.role]!,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'parentEmail': instance.parentEmail,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$UserStatusEnumMap[instance.status]!,
      'assignedModerator': instance.assignedModerator,
      'parentalApproved': instance.parentalApproved,
      'fcmTokens': instance.fcmTokens,
    };

const _$UserRoleEnumMap = {
  UserRole.kid: 'kid',
  UserRole.moderator: 'moderator',
  UserRole.admin: 'admin',
};

const _$UserStatusEnumMap = {
  UserStatus.pending: 'pending',
  UserStatus.approved: 'approved',
  UserStatus.rejected: 'rejected',
  UserStatus.banned: 'banned',
};
