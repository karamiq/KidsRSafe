// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsHash() => r'9314b084a11ce6b7500be5b802ada8bc3a56877e';

/// See also [Posts].
@ProviderFor(Posts)
final postsProvider =
    AutoDisposeAsyncNotifierProvider<Posts, List<PostModel>>.internal(
  Posts.new,
  name: r'postsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Posts = AutoDisposeAsyncNotifier<List<PostModel>>;
String _$postActionsHash() => r'35148d7ee4aa119b31b01a3f403d107b06585f9c';

/// See also [PostActions].
@ProviderFor(PostActions)
final postActionsProvider =
    AutoDisposeNotifierProvider<PostActions, void>.internal(
  PostActions.new,
  name: r'postActionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$postActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostActions = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
