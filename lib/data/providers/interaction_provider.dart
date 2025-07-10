import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/repositories/firestore_repo/like_repository.dart';
import 'package:app/data/repositories/firestore_repo/save_repository.dart';
import 'package:app/data/repositories/firestore_repo/comment_repository.dart';
import 'package:flutter/foundation.dart';

class InteractionState {
  final Map<String, bool> likedPosts;
  final Map<String, bool> savedPosts;
  final Map<String, int> commentCounts;
  final bool isLoading;

  const InteractionState({
    this.likedPosts = const {},
    this.savedPosts = const {},
    this.commentCounts = const {},
    this.isLoading = false,
  });

  InteractionState copyWith({
    Map<String, bool>? likedPosts,
    Map<String, bool>? savedPosts,
    Map<String, int>? commentCounts,
    bool? isLoading,
  }) {
    return InteractionState(
      likedPosts: likedPosts ?? this.likedPosts,
      savedPosts: savedPosts ?? this.savedPosts,
      commentCounts: commentCounts ?? this.commentCounts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class InteractionNotifier extends StateNotifier<InteractionState> {
  final LikeRepository _likeRepository;
  final SaveRepository _saveRepository;
  final CommentRepository _commentRepository;

  InteractionNotifier()
      : _likeRepository = LikeRepository(),
        _saveRepository = SaveRepository(),
        _commentRepository = CommentRepository(),
        super(const InteractionState());

  Future<void> initializeUserInteractions(String userId, List<String> postIds) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      // Get all liked and saved posts for the user
      final likedPostIds = await _likeRepository.getLikedPostIds(userId);
      final savedPostIds = await _saveRepository.getSavedPostIds(userId);

      // Create maps for quick lookup
      final likedPosts = <String, bool>{};
      final savedPosts = <String, bool>{};

      for (final postId in postIds) {
        likedPosts[postId] = likedPostIds.contains(postId);
        savedPosts[postId] = savedPostIds.contains(postId);
      }

      state = state.copyWith(
        likedPosts: likedPosts,
        savedPosts: savedPosts,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('Error initializing user interactions: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> toggleLike(String postId, String userId, String postOwnerId) async {
    try {
      final isCurrentlyLiked = state.likedPosts[postId] ?? false;
      final newLikedPosts = Map<String, bool>.from(state.likedPosts);

      if (isCurrentlyLiked) {
        // Unlike
        await _likeRepository.unlikePost(
          userId: userId,
          postId: postId,
          postOwnerId: postOwnerId,
        );
        newLikedPosts[postId] = false;
      } else {
        // Like
        await _likeRepository.likePost(
          userId: userId,
          postId: postId,
          postOwnerId: postOwnerId,
        );
        newLikedPosts[postId] = true;
      }

      state = state.copyWith(likedPosts: newLikedPosts);
    } catch (e) {
      debugPrint('Error toggling like: $e');
    }
  }

  Future<void> toggleSave(String postId, String userId, String postOwnerId) async {
    try {
      final isCurrentlySaved = state.savedPosts[postId] ?? false;
      final newSavedPosts = Map<String, bool>.from(state.savedPosts);

      if (isCurrentlySaved) {
        // Unsave
        await _saveRepository.unsavePost(
          userId: userId,
          postId: postId,
          postOwnerId: postOwnerId,
        );
        newSavedPosts[postId] = false;
      } else {
        // Save
        await _saveRepository.savePost(
          userId: userId,
          postId: postId,
          postOwnerId: postOwnerId,
        );
        newSavedPosts[postId] = true;
      }

      state = state.copyWith(savedPosts: newSavedPosts);
    } catch (e) {
      debugPrint('Error toggling save: $e');
    }
  }

  Future<void> addComment(String postId, String userId, String content) async {
    try {
      await _commentRepository.addComment(
        userId: userId,
        postId: postId,
        content: content,
      );

      // Update comment count
      final newCommentCounts = Map<String, int>.from(state.commentCounts);
      newCommentCounts[postId] = (newCommentCounts[postId] ?? 0) + 1;

      state = state.copyWith(commentCounts: newCommentCounts);
    } catch (e) {
      debugPrint('Error adding comment: $e');
    }
  }

  bool isPostLiked(String postId) {
    return state.likedPosts[postId] ?? false;
  }

  bool isPostSaved(String postId) {
    return state.savedPosts[postId] ?? false;
  }

  int getCommentCount(String postId) {
    return state.commentCounts[postId] ?? 0;
  }

  void updateCommentCount(String postId, int count) {
    final newCommentCounts = Map<String, int>.from(state.commentCounts);
    newCommentCounts[postId] = count;
    state = state.copyWith(commentCounts: newCommentCounts);
  }

  void clearInteractions() {
    state = const InteractionState();
  }
}

final interactionProvider = StateNotifierProvider<InteractionNotifier, InteractionState>((ref) {
  return InteractionNotifier();
});
