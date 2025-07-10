// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaveModel {
  String get userUid;
  String get postUid;
  DateTime get createdAt;

  /// Create a copy of SaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SaveModelCopyWith<SaveModel> get copyWith =>
      _$SaveModelCopyWithImpl<SaveModel>(this as SaveModel, _$identity);

  /// Serializes this SaveModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SaveModel &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.postUid, postUid) || other.postUid == postUid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userUid, postUid, createdAt);

  @override
  String toString() {
    return 'SaveModel(userUid: $userUid, postUid: $postUid, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $SaveModelCopyWith<$Res> {
  factory $SaveModelCopyWith(SaveModel value, $Res Function(SaveModel) _then) =
      _$SaveModelCopyWithImpl;
  @useResult
  $Res call({String userUid, String postUid, DateTime createdAt});
}

/// @nodoc
class _$SaveModelCopyWithImpl<$Res> implements $SaveModelCopyWith<$Res> {
  _$SaveModelCopyWithImpl(this._self, this._then);

  final SaveModel _self;
  final $Res Function(SaveModel) _then;

  /// Create a copy of SaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userUid = null,
    Object? postUid = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      userUid: null == userUid
          ? _self.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      postUid: null == postUid
          ? _self.postUid
          : postUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [SaveModel].
extension SaveModelPatterns on SaveModel {
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
    TResult Function(_SaveModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SaveModel() when $default != null:
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
    TResult Function(_SaveModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaveModel():
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
    TResult? Function(_SaveModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaveModel() when $default != null:
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
    TResult Function(String userUid, String postUid, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SaveModel() when $default != null:
        return $default(_that.userUid, _that.postUid, _that.createdAt);
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
    TResult Function(String userUid, String postUid, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaveModel():
        return $default(_that.userUid, _that.postUid, _that.createdAt);
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
    TResult? Function(String userUid, String postUid, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SaveModel() when $default != null:
        return $default(_that.userUid, _that.postUid, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SaveModel implements SaveModel {
  const _SaveModel(
      {required this.userUid, required this.postUid, required this.createdAt});
  factory _SaveModel.fromJson(Map<String, dynamic> json) =>
      _$SaveModelFromJson(json);

  @override
  final String userUid;
  @override
  final String postUid;
  @override
  final DateTime createdAt;

  /// Create a copy of SaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveModelCopyWith<_SaveModel> get copyWith =>
      __$SaveModelCopyWithImpl<_SaveModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SaveModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveModel &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
            (identical(other.postUid, postUid) || other.postUid == postUid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userUid, postUid, createdAt);

  @override
  String toString() {
    return 'SaveModel(userUid: $userUid, postUid: $postUid, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$SaveModelCopyWith<$Res>
    implements $SaveModelCopyWith<$Res> {
  factory _$SaveModelCopyWith(
          _SaveModel value, $Res Function(_SaveModel) _then) =
      __$SaveModelCopyWithImpl;
  @override
  @useResult
  $Res call({String userUid, String postUid, DateTime createdAt});
}

/// @nodoc
class __$SaveModelCopyWithImpl<$Res> implements _$SaveModelCopyWith<$Res> {
  __$SaveModelCopyWithImpl(this._self, this._then);

  final _SaveModel _self;
  final $Res Function(_SaveModel) _then;

  /// Create a copy of SaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userUid = null,
    Object? postUid = null,
    Object? createdAt = null,
  }) {
    return _then(_SaveModel(
      userUid: null == userUid
          ? _self.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
      postUid: null == postUid
          ? _self.postUid
          : postUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
