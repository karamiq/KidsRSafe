// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostModel {
  String get uid;
  String get title;
  UserModel get user;
  PostType get type;
  List<String> get urls;
  String get caption;
  int? get duration;
  PostStatus get status;
  DateTime get createdAt;
  int get likes;
  int get saves;
  int get views;
  int get comments;
  String? get moderatorUid;
  DateTime? get moderatedAt;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostModelCopyWith<PostModel> get copyWith =>
      _$PostModelCopyWithImpl<PostModel>(this as PostModel, _$identity);

  /// Serializes this PostModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.urls, urls) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.saves, saves) || other.saves == saves) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.moderatorUid, moderatorUid) ||
                other.moderatorUid == moderatorUid) &&
            (identical(other.moderatedAt, moderatedAt) ||
                other.moderatedAt == moderatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      title,
      user,
      type,
      const DeepCollectionEquality().hash(urls),
      caption,
      duration,
      status,
      createdAt,
      likes,
      saves,
      views,
      comments,
      moderatorUid,
      moderatedAt);

  @override
  String toString() {
    return 'PostModel(uid: $uid, title: $title, user: $user, type: $type, urls: $urls, caption: $caption, duration: $duration, status: $status, createdAt: $createdAt, likes: $likes, saves: $saves, views: $views, comments: $comments, moderatorUid: $moderatorUid, moderatedAt: $moderatedAt)';
  }
}

/// @nodoc
abstract mixin class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) _then) =
      _$PostModelCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String title,
      UserModel user,
      PostType type,
      List<String> urls,
      String caption,
      int? duration,
      PostStatus status,
      DateTime createdAt,
      int likes,
      int saves,
      int views,
      int comments,
      String? moderatorUid,
      DateTime? moderatedAt});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res> implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._self, this._then);

  final PostModel _self;
  final $Res Function(PostModel) _then;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? user = null,
    Object? type = null,
    Object? urls = null,
    Object? caption = null,
    Object? duration = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? likes = null,
    Object? saves = null,
    Object? views = null,
    Object? comments = null,
    Object? moderatorUid = freezed,
    Object? moderatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as PostType,
      urls: null == urls
          ? _self.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      caption: null == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _self.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      saves: null == saves
          ? _self.saves
          : saves // ignore: cast_nullable_to_non_nullable
              as int,
      views: null == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _self.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
      moderatorUid: freezed == moderatorUid
          ? _self.moderatorUid
          : moderatorUid // ignore: cast_nullable_to_non_nullable
              as String?,
      moderatedAt: freezed == moderatedAt
          ? _self.moderatedAt
          : moderatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PostModel].
extension PostModelPatterns on PostModel {
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
    TResult Function(_PostModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
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
    TResult Function(_PostModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel():
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
    TResult? Function(_PostModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
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
            String title,
            UserModel user,
            PostType type,
            List<String> urls,
            String caption,
            int? duration,
            PostStatus status,
            DateTime createdAt,
            int likes,
            int saves,
            int views,
            int comments,
            String? moderatorUid,
            DateTime? moderatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
        return $default(
            _that.uid,
            _that.title,
            _that.user,
            _that.type,
            _that.urls,
            _that.caption,
            _that.duration,
            _that.status,
            _that.createdAt,
            _that.likes,
            _that.saves,
            _that.views,
            _that.comments,
            _that.moderatorUid,
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
            String title,
            UserModel user,
            PostType type,
            List<String> urls,
            String caption,
            int? duration,
            PostStatus status,
            DateTime createdAt,
            int likes,
            int saves,
            int views,
            int comments,
            String? moderatorUid,
            DateTime? moderatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel():
        return $default(
            _that.uid,
            _that.title,
            _that.user,
            _that.type,
            _that.urls,
            _that.caption,
            _that.duration,
            _that.status,
            _that.createdAt,
            _that.likes,
            _that.saves,
            _that.views,
            _that.comments,
            _that.moderatorUid,
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
            String title,
            UserModel user,
            PostType type,
            List<String> urls,
            String caption,
            int? duration,
            PostStatus status,
            DateTime createdAt,
            int likes,
            int saves,
            int views,
            int comments,
            String? moderatorUid,
            DateTime? moderatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostModel() when $default != null:
        return $default(
            _that.uid,
            _that.title,
            _that.user,
            _that.type,
            _that.urls,
            _that.caption,
            _that.duration,
            _that.status,
            _that.createdAt,
            _that.likes,
            _that.saves,
            _that.views,
            _that.comments,
            _that.moderatorUid,
            _that.moderatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@jsonSerializable
class _PostModel implements PostModel {
  const _PostModel(
      {required this.uid,
      required this.title,
      required this.user,
      required this.type,
      required final List<String> urls,
      required this.caption,
      this.duration,
      required this.status,
      required this.createdAt,
      required this.likes,
      required this.saves,
      required this.views,
      required this.comments,
      this.moderatorUid,
      this.moderatedAt})
      : _urls = urls;
  factory _PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  @override
  final String uid;
  @override
  final String title;
  @override
  final UserModel user;
  @override
  final PostType type;
  final List<String> _urls;
  @override
  List<String> get urls {
    if (_urls is EqualUnmodifiableListView) return _urls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urls);
  }

  @override
  final String caption;
  @override
  final int? duration;
  @override
  final PostStatus status;
  @override
  final DateTime createdAt;
  @override
  final int likes;
  @override
  final int saves;
  @override
  final int views;
  @override
  final int comments;
  @override
  final String? moderatorUid;
  @override
  final DateTime? moderatedAt;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostModelCopyWith<_PostModel> get copyWith =>
      __$PostModelCopyWithImpl<_PostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._urls, _urls) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.saves, saves) || other.saves == saves) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.moderatorUid, moderatorUid) ||
                other.moderatorUid == moderatorUid) &&
            (identical(other.moderatedAt, moderatedAt) ||
                other.moderatedAt == moderatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      title,
      user,
      type,
      const DeepCollectionEquality().hash(_urls),
      caption,
      duration,
      status,
      createdAt,
      likes,
      saves,
      views,
      comments,
      moderatorUid,
      moderatedAt);

  @override
  String toString() {
    return 'PostModel(uid: $uid, title: $title, user: $user, type: $type, urls: $urls, caption: $caption, duration: $duration, status: $status, createdAt: $createdAt, likes: $likes, saves: $saves, views: $views, comments: $comments, moderatorUid: $moderatorUid, moderatedAt: $moderatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PostModelCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$PostModelCopyWith(
          _PostModel value, $Res Function(_PostModel) _then) =
      __$PostModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String title,
      UserModel user,
      PostType type,
      List<String> urls,
      String caption,
      int? duration,
      PostStatus status,
      DateTime createdAt,
      int likes,
      int saves,
      int views,
      int comments,
      String? moderatorUid,
      DateTime? moderatedAt});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$PostModelCopyWithImpl<$Res> implements _$PostModelCopyWith<$Res> {
  __$PostModelCopyWithImpl(this._self, this._then);

  final _PostModel _self;
  final $Res Function(_PostModel) _then;

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? user = null,
    Object? type = null,
    Object? urls = null,
    Object? caption = null,
    Object? duration = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? likes = null,
    Object? saves = null,
    Object? views = null,
    Object? comments = null,
    Object? moderatorUid = freezed,
    Object? moderatedAt = freezed,
  }) {
    return _then(_PostModel(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as PostType,
      urls: null == urls
          ? _self._urls
          : urls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      caption: null == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likes: null == likes
          ? _self.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      saves: null == saves
          ? _self.saves
          : saves // ignore: cast_nullable_to_non_nullable
              as int,
      views: null == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _self.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
      moderatorUid: freezed == moderatorUid
          ? _self.moderatorUid
          : moderatorUid // ignore: cast_nullable_to_non_nullable
              as String?,
      moderatedAt: freezed == moderatedAt
          ? _self.moderatedAt
          : moderatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of PostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

// dart format on
