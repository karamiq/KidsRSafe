import 'package:app/data/models/post_model.dart';
import 'package:app/core/firebase/firestore_paging_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_provider.g.dart';

@riverpod
class Posts extends _$Posts {
  late final FirestorePaginationService<PostModel> _paginationService;

  @override
  Future<List<PostModel>> build() async {
    _initializePaginationService();
    return await _loadInitialPosts();
  }

  void _initializePaginationService() {
    _paginationService = FirestorePaginationService<PostModel>(
      baseQuery: FirebaseFirestore.instance.collection('posts'),
      fromJson: (json, id) => PostModel.fromJson(json),
      pageSize: 5,
    );
  }

  Future<List<PostModel>> _loadInitialPosts() async {
    final posts = await _paginationService.fetchFirstPage();
    return posts;
  }

  Future<void> loadMorePosts() async {
    if (_paginationService.isLoading || !_paginationService.hasMore) return;

    try {
      final currentPosts = state.value ?? [];
      final newPosts = await _paginationService.fetchNextPage();
      final updatedPosts = [...currentPosts, ...newPosts];
      state = AsyncValue.data(updatedPosts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refreshPosts() async {
    try {
      final posts = await _paginationService.refresh();
      state = AsyncValue.data(posts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void addFilter(FirestoreFilter filter) {
    _paginationService.addFilter(filter);
    refreshPosts();
  }

  void clearFilters() {
    _paginationService.clearFilters();
    refreshPosts();
  }

  void addOrderBy(FirestoreOrderBy orderBy) {
    _paginationService.addOrderBy(orderBy);
    refreshPosts();
  }

  void clearOrderBy() {
    _paginationService.clearOrderBy();
    refreshPosts();
  }

  bool get hasMore => _paginationService.hasMore;
  bool get isLoading => _paginationService.isLoading;
}

@riverpod
class PostActions extends _$PostActions {
  @override
  void build() {}

  Future<void> incrementViews(String postId) async {}

  Future<void> likePost(String postId, String userId) async {}

  Future<void> unlikePost(String postId, String userId) async {}

  Future<void> savePost(String postId, String userId) async {}

  Future<void> unsavePost(String postId, String userId) async {}
}
