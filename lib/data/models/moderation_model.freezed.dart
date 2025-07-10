// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moderation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModerationModel {
  String get uid;
  String get postId;
  String get submittedBy;
  String get status;
  DateTime get createdAt;
  String? get assignedTo;
  ModerationAction? get moderationAction;
  String? get moderationReason;
  DateTime? get moderatedAt;

  /// Create a copy of ModerationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModerationModelCopyWith<ModerationModel> get copyWith =>
      _$ModerationModelCopyWithImpl<ModerationModel>(
          this as ModerationModel, _$identity);

  /// Serializes this ModerationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModerationModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.submittedBy, submittedBy) ||
                other.submittedBy == submittedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.moderationAction, moderationAction) ||
                other.moderationAction == moderationAction) &&
            (identical(other.moderationReason, moderationReason) ||
                other.moderationReason == moderationReason) &&
            (identical(other.moderatedAt, moderatedAt) ||
                other.moderatedAt == moderatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, postId, submittedBy, status,
      createdAt, assignedTo, moderationAction, moderationReason, moderatedAt);

  @override
  String toString() {
    return 'ModerationModel(uid: $uid, postId: $postId, submittedBy: $submittedBy, status: $status, createdAt: $createdAt, assignedTo: $assignedTo, moderationAction: $moderationAction, moderationReason: $moderationReason, moderatedAt: $moderatedAt)';
  }
}

/// @nodoc
abstract mixin class $ModerationModelCopyWith<$Res> {
  factory $ModerationModelCopyWith(
          ModerationModel value, $Res Function(ModerationModel) _then) =
      _$ModerationModelCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String postId,
      String submittedBy,
      String status,
      DateTime createdAt,
      String? assignedTo,
      ModerationAction? moderationAction,
      String? moderationReason,
      DateTime? moderatedAt});
}

/// @nodoc
class _$ModerationModelCopyWithImpl<$Res>
    implements $ModerationModelCopyWith<$Res> {
  _$ModerationModelCopyWithImpl(this._self, this._then);

  final ModerationModel _self;
  final $Res Function(ModerationModel) _then;

  /// Create a copy of ModerationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? postId = null,
    Object? submittedBy = null,
    Object? status = null,
    Object? createdAt = null,
    Object? assignedTo = freezed,
    Object? moderationAction = freezed,
    Object? moderationReason = freezed,
    Object? moderatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      submittedBy: null == submittedBy
          ? _self.submittedBy
          : submittedBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedTo: freezed == assignedTo
          ? _self.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      moderationAction: freezed == moderationAction
          ? _self.moderationAction
          : moderationAction // ignore: cast_nullable_to_non_nullable
              as ModerationAction?,
      moderationReason: freezed == moderationReason
          ? _self.moderationReason
          : moderationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      moderatedAt: freezed == moderatedAt
          ? _self.moderatedAt
          : moderatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ModerationModel].
extension ModerationModelPatterns on ModerationModel {
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
    TResult Function(_ModerationModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ModerationModel() when $default != null:
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
    TResult Function(_ModerationModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ModerationModel():
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
    TResult? Function(_ModerationModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ModerationModel() when $default != null:
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
            String postId,
            String submittedBy,
            String status,
            DateTime createdAt,
            String? assignedTo,
            ModerationAction? moderationAction,
            String? moderationReason,
            DateTime? moderatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ModerationModel() when $default != null:
        return $default(
            _that.uid,
            _that.postId,
            _that.submittedBy,
            _that.status,
            _that.createdAt,
            _that.assignedTo,
            _that.moderationAction,
            _that.moderationReason,
            _that.moderatedAt);
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
            String postId,
            String submittedBy,
            String status,
            DateTime createdAt,
            String? assignedTo,
            ModerationAction? moderationAction,
            String? moderationReason,
            DateTime? moderatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ModerationModel():
        return $default(
            _that.uid,
            _that.postId,
            _that.submittedBy,
            _that.status,
            _that.createdAt,
            _that.assignedTo,
            _that.moderationAction,
            _that.moderationReason,
            _that.moderatedAt);
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
            String postId,
            String submittedBy,
            String status,
            DateTime createdAt,
            String? assignedTo,
            ModerationAction? moderationAction,
            String? moderationReason,
            DateTime? moderatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ModerationModel() when $default != null:
        return $default(
            _that.uid,
            _that.postId,
            _that.submittedBy,
            _that.status,
            _that.createdAt,
            _that.assignedTo,
            _that.moderationAction,
            _that.moderationReason,
            _that.moderatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ModerationModel implements ModerationModel {
  const _ModerationModel(
      {required this.uid,
      required this.postId,
      required this.submittedBy,
      required this.status,
      required this.createdAt,
      this.assignedTo,
      this.moderationAction,
      this.moderationReason,
      this.moderatedAt});
  factory _ModerationModel.fromJson(Map<String, dynamic> json) =>
      _$ModerationModelFromJson(json);

  @override
  final String uid;
  @override
  final String postId;
  @override
  final String submittedBy;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final String? assignedTo;
  @override
  final ModerationAction? moderationAction;
  @override
  final String? moderationReason;
  @override
  final DateTime? moderatedAt;

  /// Create a copy of ModerationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModerationModelCopyWith<_ModerationModel> get copyWith =>
      __$ModerationModelCopyWithImpl<_ModerationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ModerationModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModerationModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.submittedBy, submittedBy) ||
                other.submittedBy == submittedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.assignedTo, assignedTo) ||
                other.assignedTo == assignedTo) &&
            (identical(other.moderationAction, moderationAction) ||
                other.moderationAction == moderationAction) &&
            (identical(other.moderationReason, moderationReason) ||
                other.moderationReason == moderationReason) &&
            (identical(other.moderatedAt, moderatedAt) ||
                other.moderatedAt == moderatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, postId, submittedBy, status,
      createdAt, assignedTo, moderationAction, moderationReason, moderatedAt);

  @override
  String toString() {
    return 'ModerationModel(uid: $uid, postId: $postId, submittedBy: $submittedBy, status: $status, createdAt: $createdAt, assignedTo: $assignedTo, moderationAction: $moderationAction, moderationReason: $moderationReason, moderatedAt: $moderatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ModerationModelCopyWith<$Res>
    implements $ModerationModelCopyWith<$Res> {
  factory _$ModerationModelCopyWith(
          _ModerationModel value, $Res Function(_ModerationModel) _then) =
      __$ModerationModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String postId,
      String submittedBy,
      String status,
      DateTime createdAt,
      String? assignedTo,
      ModerationAction? moderationAction,
      String? moderationReason,
      DateTime? moderatedAt});
}

/// @nodoc
class __$ModerationModelCopyWithImpl<$Res>
    implements _$ModerationModelCopyWith<$Res> {
  __$ModerationModelCopyWithImpl(this._self, this._then);

  final _ModerationModel _self;
  final $Res Function(_ModerationModel) _then;

  /// Create a copy of ModerationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? postId = null,
    Object? submittedBy = null,
    Object? status = null,
    Object? createdAt = null,
    Object? assignedTo = freezed,
    Object? moderationAction = freezed,
    Object? moderationReason = freezed,
    Object? moderatedAt = freezed,
  }) {
    return _then(_ModerationModel(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      submittedBy: null == submittedBy
          ? _self.submittedBy
          : submittedBy // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedTo: freezed == assignedTo
          ? _self.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      moderationAction: freezed == moderationAction
          ? _self.moderationAction
          : moderationAction // ignore: cast_nullable_to_non_nullable
              as ModerationAction?,
      moderationReason: freezed == moderationReason
          ? _self.moderationReason
          : moderationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      moderatedAt: freezed == moderatedAt
          ? _self.moderatedAt
          : moderatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
