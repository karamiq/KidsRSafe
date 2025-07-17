// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatModel {
  String get uid;
  UserModel get oppositeUser;
  String get lastMessage;
  DateTime get lastMessageTime;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatModelCopyWith<ChatModel> get copyWith =>
      _$ChatModelCopyWithImpl<ChatModel>(this as ChatModel, _$identity);

  /// Serializes this ChatModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.oppositeUser, oppositeUser) ||
                other.oppositeUser == oppositeUser) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, oppositeUser, lastMessage, lastMessageTime);

  @override
  String toString() {
    return 'ChatModel(uid: $uid, oppositeUser: $oppositeUser, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }
}

/// @nodoc
abstract mixin class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) _then) =
      _$ChatModelCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      UserModel oppositeUser,
      String lastMessage,
      DateTime lastMessageTime});

  $UserModelCopyWith<$Res> get oppositeUser;
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res> implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._self, this._then);

  final ChatModel _self;
  final $Res Function(ChatModel) _then;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? oppositeUser = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      oppositeUser: null == oppositeUser
          ? _self.oppositeUser
          : oppositeUser // ignore: cast_nullable_to_non_nullable
              as UserModel,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get oppositeUser {
    return $UserModelCopyWith<$Res>(_self.oppositeUser, (value) {
      return _then(_self.copyWith(oppositeUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ChatModel].
extension ChatModelPatterns on ChatModel {
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
    TResult Function(_ChatModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatModel() when $default != null:
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
    TResult Function(_ChatModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatModel():
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
    TResult? Function(_ChatModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatModel() when $default != null:
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
    TResult Function(String uid, UserModel oppositeUser, String lastMessage,
            DateTime lastMessageTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatModel() when $default != null:
        return $default(_that.uid, _that.oppositeUser, _that.lastMessage,
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
    TResult Function(String uid, UserModel oppositeUser, String lastMessage,
            DateTime lastMessageTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatModel():
        return $default(_that.uid, _that.oppositeUser, _that.lastMessage,
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
    TResult? Function(String uid, UserModel oppositeUser, String lastMessage,
            DateTime lastMessageTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatModel() when $default != null:
        return $default(_that.uid, _that.oppositeUser, _that.lastMessage,
            _that.lastMessageTime);
      case _:
        return null;
    }
  }
}

/// @nodoc

@jsonSerializable
class _ChatModel implements ChatModel {
  const _ChatModel(
      {required this.uid,
      required this.oppositeUser,
      required this.lastMessage,
      required this.lastMessageTime});
  factory _ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  @override
  final String uid;
  @override
  final UserModel oppositeUser;
  @override
  final String lastMessage;
  @override
  final DateTime lastMessageTime;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatModelCopyWith<_ChatModel> get copyWith =>
      __$ChatModelCopyWithImpl<_ChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.oppositeUser, oppositeUser) ||
                other.oppositeUser == oppositeUser) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, oppositeUser, lastMessage, lastMessageTime);

  @override
  String toString() {
    return 'ChatModel(uid: $uid, oppositeUser: $oppositeUser, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }
}

/// @nodoc
abstract mixin class _$ChatModelCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$ChatModelCopyWith(
          _ChatModel value, $Res Function(_ChatModel) _then) =
      __$ChatModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      UserModel oppositeUser,
      String lastMessage,
      DateTime lastMessageTime});

  @override
  $UserModelCopyWith<$Res> get oppositeUser;
}

/// @nodoc
class __$ChatModelCopyWithImpl<$Res> implements _$ChatModelCopyWith<$Res> {
  __$ChatModelCopyWithImpl(this._self, this._then);

  final _ChatModel _self;
  final $Res Function(_ChatModel) _then;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? oppositeUser = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
  }) {
    return _then(_ChatModel(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      oppositeUser: null == oppositeUser
          ? _self.oppositeUser
          : oppositeUser // ignore: cast_nullable_to_non_nullable
              as UserModel,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get oppositeUser {
    return $UserModelCopyWith<$Res>(_self.oppositeUser, (value) {
      return _then(_self.copyWith(oppositeUser: value));
    });
  }
}

// dart format on
