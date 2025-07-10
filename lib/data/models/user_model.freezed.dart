// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {
  String get uid;
  String get email;
  String get name;
  String get profilePicture;
  UserRole get role;
  DateTime get dateOfBirth;
  String? get parentEmail;
  DateTime get createdAt;
  UserStatus get status;
  String? get assignedModerator;
  bool get parentalApproved;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<UserModel> get copyWith =>
      _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.parentEmail, parentEmail) ||
                other.parentEmail == parentEmail) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedModerator, assignedModerator) ||
                other.assignedModerator == assignedModerator) &&
            (identical(other.parentalApproved, parentalApproved) ||
                other.parentalApproved == parentalApproved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      name,
      profilePicture,
      role,
      dateOfBirth,
      parentEmail,
      createdAt,
      status,
      assignedModerator,
      parentalApproved);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, profilePicture: $profilePicture, role: $role, dateOfBirth: $dateOfBirth, parentEmail: $parentEmail, createdAt: $createdAt, status: $status, assignedModerator: $assignedModerator, parentalApproved: $parentalApproved)';
  }
}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) =
      _$UserModelCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String email,
      String name,
      String profilePicture,
      UserRole role,
      DateTime dateOfBirth,
      String? parentEmail,
      DateTime createdAt,
      UserStatus status,
      String? assignedModerator,
      bool parentalApproved});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? name = null,
    Object? profilePicture = null,
    Object? role = null,
    Object? dateOfBirth = null,
    Object? parentEmail = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? assignedModerator = freezed,
    Object? parentalApproved = null,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      dateOfBirth: null == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      parentEmail: freezed == parentEmail
          ? _self.parentEmail
          : parentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      assignedModerator: freezed == assignedModerator
          ? _self.assignedModerator
          : assignedModerator // ignore: cast_nullable_to_non_nullable
              as String?,
      parentalApproved: null == parentalApproved
          ? _self.parentalApproved
          : parentalApproved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String uid,
            String email,
            String name,
            String profilePicture,
            UserRole role,
            DateTime dateOfBirth,
            String? parentEmail,
            DateTime createdAt,
            UserStatus status,
            String? assignedModerator,
            bool parentalApproved)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(
            _that.uid,
            _that.email,
            _that.name,
            _that.profilePicture,
            _that.role,
            _that.dateOfBirth,
            _that.parentEmail,
            _that.createdAt,
            _that.status,
            _that.assignedModerator,
            _that.parentalApproved);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String uid,
            String email,
            String name,
            String profilePicture,
            UserRole role,
            DateTime dateOfBirth,
            String? parentEmail,
            DateTime createdAt,
            UserStatus status,
            String? assignedModerator,
            bool parentalApproved)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel():
        return $default(
            _that.uid,
            _that.email,
            _that.name,
            _that.profilePicture,
            _that.role,
            _that.dateOfBirth,
            _that.parentEmail,
            _that.createdAt,
            _that.status,
            _that.assignedModerator,
            _that.parentalApproved);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String uid,
            String email,
            String name,
            String profilePicture,
            UserRole role,
            DateTime dateOfBirth,
            String? parentEmail,
            DateTime createdAt,
            UserStatus status,
            String? assignedModerator,
            bool parentalApproved)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(
            _that.uid,
            _that.email,
            _that.name,
            _that.profilePicture,
            _that.role,
            _that.dateOfBirth,
            _that.parentEmail,
            _that.createdAt,
            _that.status,
            _that.assignedModerator,
            _that.parentalApproved);
      case _:
        return null;
    }
  }
}

/// @nodoc

@jsonSerializable
class _UserModel implements UserModel {
  const _UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.profilePicture,
      required this.role,
      required this.dateOfBirth,
      required this.parentEmail,
      required this.createdAt,
      required this.status,
      required this.assignedModerator,
      this.parentalApproved = false});
  factory _UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String name;
  @override
  final String profilePicture;
  @override
  final UserRole role;
  @override
  final DateTime dateOfBirth;
  @override
  final String? parentEmail;
  @override
  final DateTime createdAt;
  @override
  final UserStatus status;
  @override
  final String? assignedModerator;
  @override
  @JsonKey()
  final bool parentalApproved;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.parentEmail, parentEmail) ||
                other.parentEmail == parentEmail) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedModerator, assignedModerator) ||
                other.assignedModerator == assignedModerator) &&
            (identical(other.parentalApproved, parentalApproved) ||
                other.parentalApproved == parentalApproved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      name,
      profilePicture,
      role,
      dateOfBirth,
      parentEmail,
      createdAt,
      status,
      assignedModerator,
      parentalApproved);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, name: $name, profilePicture: $profilePicture, role: $role, dateOfBirth: $dateOfBirth, parentEmail: $parentEmail, createdAt: $createdAt, status: $status, assignedModerator: $assignedModerator, parentalApproved: $parentalApproved)';
  }
}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) _then) =
      __$UserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String name,
      String profilePicture,
      UserRole role,
      DateTime dateOfBirth,
      String? parentEmail,
      DateTime createdAt,
      UserStatus status,
      String? assignedModerator,
      bool parentalApproved});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? name = null,
    Object? profilePicture = null,
    Object? role = null,
    Object? dateOfBirth = null,
    Object? parentEmail = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? assignedModerator = freezed,
    Object? parentalApproved = null,
  }) {
    return _then(_UserModel(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _self.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      dateOfBirth: null == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      parentEmail: freezed == parentEmail
          ? _self.parentEmail
          : parentEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      assignedModerator: freezed == assignedModerator
          ? _self.assignedModerator
          : assignedModerator // ignore: cast_nullable_to_non_nullable
              as String?,
      parentalApproved: null == parentalApproved
          ? _self.parentalApproved
          : parentalApproved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
