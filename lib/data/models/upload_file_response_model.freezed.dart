// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_file_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadFileResponseModel {
  String get path;
  String? get url;

  /// Create a copy of UploadFileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadFileResponseModelCopyWith<UploadFileResponseModel> get copyWith =>
      _$UploadFileResponseModelCopyWithImpl<UploadFileResponseModel>(
          this as UploadFileResponseModel, _$identity);

  /// Serializes this UploadFileResponseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadFileResponseModel &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, path, url);

  @override
  String toString() {
    return 'UploadFileResponseModel(path: $path, url: $url)';
  }
}

/// @nodoc
abstract mixin class $UploadFileResponseModelCopyWith<$Res> {
  factory $UploadFileResponseModelCopyWith(UploadFileResponseModel value,
          $Res Function(UploadFileResponseModel) _then) =
      _$UploadFileResponseModelCopyWithImpl;
  @useResult
  $Res call({String path, String? url});
}

/// @nodoc
class _$UploadFileResponseModelCopyWithImpl<$Res>
    implements $UploadFileResponseModelCopyWith<$Res> {
  _$UploadFileResponseModelCopyWithImpl(this._self, this._then);

  final UploadFileResponseModel _self;
  final $Res Function(UploadFileResponseModel) _then;

  /// Create a copy of UploadFileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? url = freezed,
  }) {
    return _then(_self.copyWith(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UploadFileResponseModel].
extension UploadFileResponseModelPatterns on UploadFileResponseModel {
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
    TResult Function(_UploadFileResponseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadFileResponseModel() when $default != null:
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
    TResult Function(_UploadFileResponseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadFileResponseModel():
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
    TResult? Function(_UploadFileResponseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadFileResponseModel() when $default != null:
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
    TResult Function(String path, String? url)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadFileResponseModel() when $default != null:
        return $default(_that.path, _that.url);
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
    TResult Function(String path, String? url) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadFileResponseModel():
        return $default(_that.path, _that.url);
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
    TResult? Function(String path, String? url)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadFileResponseModel() when $default != null:
        return $default(_that.path, _that.url);
      case _:
        return null;
    }
  }
}

/// @nodoc

@jsonSerializableResponse
class _UploadFileResponseModel extends UploadFileResponseModel {
  const _UploadFileResponseModel({required this.path, this.url}) : super._();
  factory _UploadFileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UploadFileResponseModelFromJson(json);

  @override
  final String path;
  @override
  final String? url;

  /// Create a copy of UploadFileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UploadFileResponseModelCopyWith<_UploadFileResponseModel> get copyWith =>
      __$UploadFileResponseModelCopyWithImpl<_UploadFileResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UploadFileResponseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UploadFileResponseModel &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, path, url);

  @override
  String toString() {
    return 'UploadFileResponseModel(path: $path, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$UploadFileResponseModelCopyWith<$Res>
    implements $UploadFileResponseModelCopyWith<$Res> {
  factory _$UploadFileResponseModelCopyWith(_UploadFileResponseModel value,
          $Res Function(_UploadFileResponseModel) _then) =
      __$UploadFileResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({String path, String? url});
}

/// @nodoc
class __$UploadFileResponseModelCopyWithImpl<$Res>
    implements _$UploadFileResponseModelCopyWith<$Res> {
  __$UploadFileResponseModelCopyWithImpl(this._self, this._then);

  final _UploadFileResponseModel _self;
  final $Res Function(_UploadFileResponseModel) _then;

  /// Create a copy of UploadFileResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? path = null,
    Object? url = freezed,
  }) {
    return _then(_UploadFileResponseModel(
      path: null == path
          ? _self.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
