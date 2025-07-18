// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPostsHash() => r'8c8d467f0fd0c128f7d9fdb6926dd15597edf971';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getPosts].
@ProviderFor(getPosts)
const getPostsProvider = GetPostsFamily();

/// See also [getPosts].
class GetPostsFamily extends Family<AsyncValue<List<PostModel>>> {
  /// See also [getPosts].
  const GetPostsFamily();

  /// See also [getPosts].
  GetPostsProvider call({
    PostModel? startAfterDoc,
    int limit = 10,
  }) {
    return GetPostsProvider(
      startAfterDoc: startAfterDoc,
      limit: limit,
    );
  }

  @override
  GetPostsProvider getProviderOverride(
    covariant GetPostsProvider provider,
  ) {
    return call(
      startAfterDoc: provider.startAfterDoc,
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPostsProvider';
}

/// See also [getPosts].
class GetPostsProvider extends AutoDisposeFutureProvider<List<PostModel>> {
  /// See also [getPosts].
  GetPostsProvider({
    PostModel? startAfterDoc,
    int limit = 10,
  }) : this._internal(
          (ref) => getPosts(
            ref as GetPostsRef,
            startAfterDoc: startAfterDoc,
            limit: limit,
          ),
          from: getPostsProvider,
          name: r'getPostsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPostsHash,
          dependencies: GetPostsFamily._dependencies,
          allTransitiveDependencies: GetPostsFamily._allTransitiveDependencies,
          startAfterDoc: startAfterDoc,
          limit: limit,
        );

  GetPostsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.startAfterDoc,
    required this.limit,
  }) : super.internal();

  final PostModel? startAfterDoc;
  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<PostModel>> Function(GetPostsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPostsProvider._internal(
        (ref) => create(ref as GetPostsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        startAfterDoc: startAfterDoc,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PostModel>> createElement() {
    return _GetPostsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPostsProvider &&
        other.startAfterDoc == startAfterDoc &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startAfterDoc.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPostsRef on AutoDisposeFutureProviderRef<List<PostModel>> {
  /// The parameter `startAfterDoc` of this provider.
  PostModel? get startAfterDoc;

  /// The parameter `limit` of this provider.
  int get limit;
}

class _GetPostsProviderElement
    extends AutoDisposeFutureProviderElement<List<PostModel>> with GetPostsRef {
  _GetPostsProviderElement(super.provider);

  @override
  PostModel? get startAfterDoc => (origin as GetPostsProvider).startAfterDoc;
  @override
  int get limit => (origin as GetPostsProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
