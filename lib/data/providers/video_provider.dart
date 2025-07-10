import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/models/notification_model.dart';
import 'package:app/data/repositories/firestore_repo/post_repository.dart';
import 'package:app/data/repositories/firestore_repo/like_repository.dart';
import 'package:app/data/repositories/firestore_repo/save_repository.dart';
import 'package:app/data/repositories/firestore_repo/comment_repository.dart';
import 'package:app/data/repositories/firestore_repo/notification_repository.dart';
import 'package:flutter/foundation.dart';

class PostNotifier extends StateNotifier<List<PostModel>> {
  final PostRepository _postRepository;
  final LikeRepository _likeRepository;
  final SaveRepository _saveRepository;
  final CommentRepository _commentRepository;
  final NotificationRepository _notificationRepository;

  bool _isLoading = false;
  bool _hasMore = true;
  String? _lastDocumentId;
  static const int _pageSize = 2;

  PostNotifier()
      : _postRepository = PostRepository(),
        _likeRepository = LikeRepository(),
        _saveRepository = SaveRepository(),
        _commentRepository = CommentRepository(),
        _notificationRepository = NotificationRepository(),
        super([]);

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadInitialPosts() async {
    if (_isLoading) return;

    _isLoading = true;
    state = [];
    _hasMore = true;
    _lastDocumentId = null;

    try {
      final posts = await _postRepository.getApprovedPosts(limit: _pageSize);
      state = posts;
      _hasMore = posts.length == _pageSize;
      if (posts.isNotEmpty) {
        _lastDocumentId = posts.last.uid;
      }
    } catch (e) {
      debugPrint('Error loading initial posts: $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMorePosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;

    try {
      // Get posts after the last document ID for proper pagination
      final posts = await _postRepository.getApprovedPostsAfter(
        lastDocumentId: _lastDocumentId,
        limit: _pageSize,
      );

      if (posts.isNotEmpty) {
        state = [...state, ...posts];
        _hasMore = posts.length == _pageSize;
        _lastDocumentId = posts.last.uid;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      debugPrint('Error loading more posts: $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> likePost(String postId, String currentUserId) async {
    try {
      final postIndex = state.indexWhere((post) => post.uid == postId);
      if (postIndex == -1) return;

      final post = state[postIndex];
      final isLiked = await _likeRepository.isPostLikedByUser(currentUserId, postId);

      if (isLiked) {
        // Unlike
        await _likeRepository.unlikePost(
          userId: currentUserId,
          postId: postId,
          postOwnerId: post.userUid,
        );

        // Update local state
        state = [
          ...state.sublist(0, postIndex),
          post.copyWith(likes: post.likes - 1),
          ...state.sublist(postIndex + 1),
        ];
      } else {
        // Like
        await _likeRepository.likePost(
          userId: currentUserId,
          postId: postId,
          postOwnerId: post.userUid,
        );

        // Update local state
        state = [
          ...state.sublist(0, postIndex),
          post.copyWith(likes: post.likes + 1),
          ...state.sublist(postIndex + 1),
        ];
      }
    } catch (e) {
      debugPrint('Error liking/unliking post: $e');
    }
  }

  Future<void> savePost(String postId, String currentUserId) async {
    try {
      final postIndex = state.indexWhere((post) => post.uid == postId);
      if (postIndex == -1) return;

      final post = state[postIndex];
      final isSaved = await _saveRepository.isPostSavedByUser(currentUserId, postId);

      if (isSaved) {
        // Unsave
        await _saveRepository.unsavePost(
          userId: currentUserId,
          postId: postId,
          postOwnerId: post.userUid,
        );

        // Update local state
        state = [
          ...state.sublist(0, postIndex),
          post.copyWith(saves: post.saves - 1),
          ...state.sublist(postIndex + 1),
        ];
      } else {
        // Save
        await _saveRepository.savePost(
          userId: currentUserId,
          postId: postId,
          postOwnerId: post.userUid,
        );

        // Update local state
        state = [
          ...state.sublist(0, postIndex),
          post.copyWith(saves: post.saves + 1),
          ...state.sublist(postIndex + 1),
        ];
      }
    } catch (e) {
      debugPrint('Error saving/unsaving post: $e');
    }
  }

  Future<void> incrementViews(String postId) async {
    try {
      final postIndex = state.indexWhere((post) => post.uid == postId);
      if (postIndex == -1) return;

      final post = state[postIndex];
      await _postRepository.incrementViews(postId);

      // Update local state
      state = [
        ...state.sublist(0, postIndex),
        post.copyWith(views: post.views + 1),
        ...state.sublist(postIndex + 1),
      ];
    } catch (e) {
      debugPrint('Error incrementing views: $e');
    }
  }

  Future<void> addComment(String postId, String currentUserId, {String content = 'Great post!'}) async {
    try {
      final postIndex = state.indexWhere((post) => post.uid == postId);
      if (postIndex == -1) return;

      final post = state[postIndex];

      // Add comment using comment repository
      await _commentRepository.addComment(
        userId: currentUserId,
        postId: postId,
        content: content,
      );

      // Update local state
      state = [
        ...state.sublist(0, postIndex),
        post.copyWith(comments: post.comments + 1),
        ...state.sublist(postIndex + 1),
      ];
    } catch (e) {
      debugPrint('Error adding comment: $e');
    }
  }

  void refresh() {
    loadInitialPosts();
  }
}

final postProvider = StateNotifierProvider<PostNotifier, List<PostModel>>((ref) {
  return PostNotifier();
});
