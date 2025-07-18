// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPostsHash() => r'b75926f27910011b88b3a1d184a5110617c02967';

/// See also [getPosts].
@ProviderFor(getPosts)
final getPostsProvider = AutoDisposeFutureProvider<List<PostModel>>.internal(
  getPosts,
  name: r'getPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPostsRef = AutoDisposeFutureProviderRef<List<PostModel>>;
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
