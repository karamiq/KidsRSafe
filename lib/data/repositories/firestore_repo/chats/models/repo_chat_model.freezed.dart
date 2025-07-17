// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepoChatModel {
  String get uid;
  List<String> get participants;
  String get lastMessage;
  DateTime? get lastMessageTime;

  /// Create a copy of RepoChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RepoChatModelCopyWith<RepoChatModel> get copyWith =>
      _$RepoChatModelCopyWithImpl<RepoChatModel>(
          this as RepoChatModel, _$identity);

  /// Serializes this RepoChatModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RepoChatModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality()
                .equals(other.participants, participants) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      const DeepCollectionEquality().hash(participants),
      lastMessage,
      lastMessageTime);

  @override
  String toString() {
    return 'RepoChatModel(uid: $uid, participants: $participants, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }
}

/// @nodoc
abstract mixin class $RepoChatModelCopyWith<$Res> {
  factory $RepoChatModelCopyWith(
          RepoChatModel value, $Res Function(RepoChatModel) _then) =
      _$RepoChatModelCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      List<String> participants,
      String lastMessage,
      DateTime? lastMessageTime});
}

/// @nodoc
class _$RepoChatModelCopyWithImpl<$Res>
    implements $RepoChatModelCopyWith<$Res> {
  _$RepoChatModelCopyWithImpl(this._self, this._then);

  final RepoChatModel _self;
  final $Res Function(RepoChatModel) _then;

  /// Create a copy of RepoChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? participants = null,
    Object? lastMessage = null,
    Object? lastMessageTime = freezed,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _self.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: freezed == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RepoChatModel].
extension RepoChatModelPatterns on RepoChatModel {
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
    TResult Function(_RepoChatModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RepoChatModel() when $default != null:
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
    TResult Function(_RepoChatModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RepoChatModel():
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
    TResult? Function(_RepoChatModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RepoChatModel() when $default != null:
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
    TResult Function(String uid, List<String> participants, String lastMessage,
            DateTime? lastMessageTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RepoChatModel() when $default != null:
        return $default(_that.uid, _that.participants, _that.lastMessage,
            _that.lastMessageTime);
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
    TResult Function(String uid, List<String> participants, String lastMessage,
            DateTime? lastMessageTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RepoChatModel():
        return $default(_that.uid, _that.participants, _that.lastMessage,
            _that.lastMessageTime);
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
    TResult? Function(String uid, List<String> participants, String lastMessage,
            DateTime? lastMessageTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RepoChatModel() when $default != null:
        return $default(_that.uid, _that.participants, _that.lastMessage,
            _that.lastMessageTime);
      case _:
        return null;
    }
  }
}

/// @nodoc

@jsonSerializable
class _RepoChatModel implements RepoChatModel {
  const _RepoChatModel(
      {required this.uid,
      required final List<String> participants,
      required this.lastMessage,
      required this.lastMessageTime})
      : _participants = participants;
  factory _RepoChatModel.fromJson(Map<String, dynamic> json) =>
      _$RepoChatModelFromJson(json);

  @override
  final String uid;
  final List<String> _participants;
  @override
  List<String> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  final String lastMessage;
  @override
  final DateTime? lastMessageTime;

  /// Create a copy of RepoChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RepoChatModelCopyWith<_RepoChatModel> get copyWith =>
      __$RepoChatModelCopyWithImpl<_RepoChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RepoChatModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RepoChatModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      const DeepCollectionEquality().hash(_participants),
      lastMessage,
      lastMessageTime);

  @override
  String toString() {
    return 'RepoChatModel(uid: $uid, participants: $participants, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }
}

/// @nodoc
abstract mixin class _$RepoChatModelCopyWith<$Res>
    implements $RepoChatModelCopyWith<$Res> {
  factory _$RepoChatModelCopyWith(
          _RepoChatModel value, $Res Function(_RepoChatModel) _then) =
      __$RepoChatModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      List<String> participants,
      String lastMessage,
      DateTime? lastMessageTime});
}

/// @nodoc
class __$RepoChatModelCopyWithImpl<$Res>
    implements _$RepoChatModelCopyWith<$Res> {
  __$RepoChatModelCopyWithImpl(this._self, this._then);

  final _RepoChatModel _self;
  final $Res Function(_RepoChatModel) _then;

  /// Create a copy of RepoChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? participants = null,
    Object? lastMessage = null,
    Object? lastMessageTime = freezed,
  }) {
    return _then(_RepoChatModel(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      participants: null == participants
          ? _self._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: freezed == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
