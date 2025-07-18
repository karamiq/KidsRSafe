// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RepoPostModel {
  String get uid;
  String get title;
  String get userUid;
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

  /// Create a copy of RepoPostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RepoPostModelCopyWith<RepoPostModel> get copyWith =>
      _$RepoPostModelCopyWithImpl<RepoPostModel>(
          this as RepoPostModel, _$identity);

  /// Serializes this RepoPostModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RepoPostModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
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
      userUid,
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
    return 'RepoPostModel(uid: $uid, title: $title, userUid: $userUid, type: $type, urls: $urls, caption: $caption, duration: $duration, status: $status, createdAt: $createdAt, likes: $likes, saves: $saves, views: $views, comments: $comments, moderatorUid: $moderatorUid, moderatedAt: $moderatedAt)';
  }
}

/// @nodoc
abstract mixin class $RepoPostModelCopyWith<$Res> {
  factory $RepoPostModelCopyWith(
          RepoPostModel value, $Res Function(RepoPostModel) _then) =
      _$RepoPostModelCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String title,
      String userUid,
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
}

/// @nodoc
class _$RepoPostModelCopyWithImpl<$Res>
    implements $RepoPostModelCopyWith<$Res> {
  _$RepoPostModelCopyWithImpl(this._self, this._then);

  final RepoPostModel _self;
  final $Res Function(RepoPostModel) _then;

  /// Create a copy of RepoPostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? userUid = null,
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
      userUid: null == userUid
          ? _self.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
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
}

/// Adds pattern-matching-related methods to [RepoPostModel].
extension RepoPostModelPatterns on RepoPostModel {
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
    TResult Function(_RepoPostModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RepoPostModel() when $default != null:
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
    TResult Function(_RepoPostModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RepoPostModel():
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
    TResult? Function(_RepoPostModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RepoPostModel() when $default != null:
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
            String userUid,
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
      case _RepoPostModel() when $default != null:
        return $default(
            _that.uid,
            _that.title,
            _that.userUid,
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
            String userUid,
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
      case _RepoPostModel():
        return $default(
            _that.uid,
            _that.title,
            _that.userUid,
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
            String userUid,
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
      case _RepoPostModel() when $default != null:
        return $default(
            _that.uid,
            _that.title,
            _that.userUid,
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
class _RepoPostModel implements RepoPostModel {
  const _RepoPostModel(
      {required this.uid,
      required this.title,
      required this.userUid,
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
  factory _RepoPostModel.fromJson(Map<String, dynamic> json) =>
      _$RepoPostModelFromJson(json);

  @override
  final String uid;
  @override
  final String title;
  @override
  final String userUid;
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

  /// Create a copy of RepoPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RepoPostModelCopyWith<_RepoPostModel> get copyWith =>
      __$RepoPostModelCopyWithImpl<_RepoPostModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RepoPostModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RepoPostModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userUid, userUid) || other.userUid == userUid) &&
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
      userUid,
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
    return 'RepoPostModel(uid: $uid, title: $title, userUid: $userUid, type: $type, urls: $urls, caption: $caption, duration: $duration, status: $status, createdAt: $createdAt, likes: $likes, saves: $saves, views: $views, comments: $comments, moderatorUid: $moderatorUid, moderatedAt: $moderatedAt)';
  }
}

/// @nodoc
abstract mixin class _$RepoPostModelCopyWith<$Res>
    implements $RepoPostModelCopyWith<$Res> {
  factory _$RepoPostModelCopyWith(
          _RepoPostModel value, $Res Function(_RepoPostModel) _then) =
      __$RepoPostModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String title,
      String userUid,
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
}

/// @nodoc
class __$RepoPostModelCopyWithImpl<$Res>
    implements _$RepoPostModelCopyWith<$Res> {
  __$RepoPostModelCopyWithImpl(this._self, this._then);

  final _RepoPostModel _self;
  final $Res Function(_RepoPostModel) _then;

  /// Create a copy of RepoPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? userUid = null,
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
    return _then(_RepoPostModel(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userUid: null == userUid
          ? _self.userUid
          : userUid // ignore: cast_nullable_to_non_nullable
              as String,
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
}

// dart format on
