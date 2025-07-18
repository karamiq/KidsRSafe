import 'dart:io';

import 'package:app/core/services/file_upload_service.dart';
import 'package:app/data/models/notification_model.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/repositories/firestore_repo/posts/models/repo_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/core/utils/constants/firestore_constants.dart';
import '../moderation_repository.dart';
import '../notification_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../../../providers/firebase_provider.dart';

typedef JsonMap = Map<String, dynamic>;

class PostRepository {
  final Ref ref;
  PostRepository({required this.ref});
  FirebaseFirestore get firestore => ref.read(firestoreProvider);
  CollectionReference<JsonMap> get _posts => firestore.collection(FirestoreCollections.posts);
  ModerationRepository get _moderationRepo => ModerationRepository(ref: ref);
  NotificationRepository get _notificationRepo => NotificationRepository(ref: ref);
  UserRole get publisherRole => ref.read(userProvider)!.role;

  Future<String> submitPostForModeration({
    required String title,
    required String userId,
    required PostType type,
    required List<File> files,
    required String caption,
    int? duration,
    String? music,
  }) async {
    try {
      final docRef = _posts.doc();
      final postId = docRef.id;

      // Add to moderation queue first
      await _moderationRepo.addToQueue(
        postId: postId,
        submittedBy: userId,
      );

      // Upload files to Cloudinary
      final cloudinary = ref.read(fileUploadServiceProvider);
      final urls = <String>[];
      for (var file in files) {
        final url = await cloudinary.uploadFile(file, path: 'posts/$postId');
        if (url != null) {
          urls.add(url);
        }
      }

      if (urls.isEmpty) {
        throw Exception('No files were uploaded successfully');
      }

      final repoPost = RepoPostModel(
        uid: postId,
        title: title,
        userUid: userId,
        type: type,
        urls: urls,
        caption: caption,
        duration: duration,
        status: publisherRole != UserRole.kid ? PostStatus.approved : PostStatus.pending,
        createdAt: DateTime.now(),
        likes: 0,
        saves: 0,
        views: 0,
        comments: 0,
        moderatorUid: null,
        moderatedAt: null,
      );

      await docRef.set(repoPost.toJson());

      // Notify user (don't let this block the main operation)
      try {
        await _notificationRepo.sendNotification(
          userId: userId,
          title: 'Post Submitted',
          body: 'Your post is submitted for moderation.',
          type: NotificationType.postPending,
        );
      } catch (notificationError) {
        // print('Notification failed but continuing: $notificationError');
      }

      return postId;
    } catch (e) {
      // print('Error in submitPostForModeration: $e');
      rethrow;
    }
  }

  Future<void> updatePost(String postId, PostModel post) async {
    // Store as RepoPostModel
    final repoPost = RepoPostModel(
      uid: post.uid,
      title: post.title,
      userUid: post.user.uid,
      type: post.type,
      urls: post.urls,
      caption: post.caption,
      duration: post.duration,
      status: post.status,
      createdAt: post.createdAt,
      likes: post.likes,
      saves: post.saves,
      views: post.views,
      comments: post.comments,
      moderatorUid: post.moderatorUid,
      moderatedAt: post.moderatedAt,
    );
    await _posts.doc(postId).update(repoPost.toJson());
  }

  Future<PostModel?> getPost(String postId) async {
    final doc = await _posts.doc(postId).get();
    if (!doc.exists) return null;
    final repoPost = RepoPostModel.fromJson(doc.data()!);
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(repoPost.userUid).get();
    final user = userDoc.exists ? UserModel.fromJson(userDoc.data()!) : null;
    if (user == null) return null;
    return PostModel(
      uid: repoPost.uid,
      title: repoPost.title,
      user: user,
      type: repoPost.type,
      urls: repoPost.urls,
      caption: repoPost.caption,
      duration: repoPost.duration,
      status: repoPost.status,
      createdAt: repoPost.createdAt,
      likes: repoPost.likes,
      saves: repoPost.saves,
      views: repoPost.views,
      comments: repoPost.comments,
      moderatorUid: repoPost.moderatorUid,
      moderatedAt: repoPost.moderatedAt,
    );
  }

  Future<List<PostModel>> getPostsByUser(String userId, {bool onlyApproved = true}) async {
    var query = _posts.where('userUid', isEqualTo: userId);
    if (onlyApproved) {
      query = query.where('status', isEqualTo: PostStatus.approved.name);
    }
    final snapshot = await query.get();
    final repoPosts = snapshot.docs.map((doc) => RepoPostModel.fromJson(doc.data())).toList();
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final user = userDoc.exists ? UserModel.fromJson(userDoc.data()!) : null;
    if (user == null) return [];
    return repoPosts
        .map((repoPost) => PostModel(
              uid: repoPost.uid,
              title: repoPost.title,
              user: user,
              type: repoPost.type,
              urls: repoPost.urls,
              caption: repoPost.caption,
              duration: repoPost.duration,
              status: repoPost.status,
              createdAt: repoPost.createdAt,
              likes: repoPost.likes,
              saves: repoPost.saves,
              views: repoPost.views,
              comments: repoPost.comments,
              moderatorUid: repoPost.moderatorUid,
              moderatedAt: repoPost.moderatedAt,
            ))
        .toList();
  }

  Future<List<PostModel>> getPendingPosts() async {
    final query = await _posts.where('status', isEqualTo: PostStatus.pending.name).get();
    return _repoPostsToPostModels(query.docs);
  }

  Future<List<PostModel>> getApprovedPosts({int limit = 20}) async {
    final query = await _posts
        .where('status', isEqualTo: PostStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return _repoPostsToPostModels(query.docs);
  }

  Future<List<PostModel>> getApprovedPostsAfter({String? lastDocumentId, int limit = 20}) async {
    var query = _posts
        .where('status', isEqualTo: PostStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit);
    if (lastDocumentId != null) {
      final lastDoc = await _posts.doc(lastDocumentId).get();
      if (lastDoc.exists) {
        query = query.startAfterDocument(lastDoc);
      }
    }
    final snapshot = await query.get();
    return _repoPostsToPostModels(snapshot.docs);
  }

  Future<List<PostModel>> getPostsByStatus(PostStatus status, {int limit = 20}) async {
    final query = await _posts
        .where('status', isEqualTo: status.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return _repoPostsToPostModels(query.docs);
  }

  Future<void> incrementViews(String postId) async {
    await _posts.doc(postId).update({
      'views': FieldValue.increment(1),
    });
  }

  Future<void> incrementLikes(String postId) async {
    await _posts.doc(postId).update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> decrementLikes(String postId) async {
    await _posts.doc(postId).update({
      'likes': FieldValue.increment(-1),
    });
  }

  Future<void> incrementSaves(String postId) async {
    await _posts.doc(postId).update({
      'saves': FieldValue.increment(1),
    });
  }

  Future<void> decrementSaves(String postId) async {
    await _posts.doc(postId).update({
      'saves': FieldValue.increment(-1),
    });
  }

  Future<void> incrementComments(String postId) async {
    await _posts.doc(postId).update({
      'comments': FieldValue.increment(1),
    });
  }

  Future<void> decrementComments(String postId) async {
    await _posts.doc(postId).update({
      'comments': FieldValue.increment(-1),
    });
  }

  /// Search approved posts by title or caption (prefix search)
  Stream<List<PostModel>> searchPosts(String query) {
    final titleQuery = _posts
        .where('status', isEqualTo: PostStatus.approved.name)
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff');
    final captionQuery = _posts
        .where('status', isEqualTo: PostStatus.approved.name)
        .where('caption', isGreaterThanOrEqualTo: query)
        .where('caption', isLessThanOrEqualTo: '$query\uf8ff');

    final titleStream = titleQuery.snapshots().map((snapshot) => _repoPostsToPostModels(snapshot.docs));
    final captionStream = captionQuery.snapshots().map((snapshot) => _repoPostsToPostModels(snapshot.docs));

    return titleStream.asyncMap((titleResults) async {
      final captionResults = await captionStream.first;
      // Assume both are List<PostModel> as expected
      final all = <PostModel>{
        ...(titleResults as List<PostModel>),
        ...(captionResults as List<PostModel>),
      };
      return all.toList();
    });
  }

  Future<List<PostModel>> _repoPostsToPostModels(List<QueryDocumentSnapshot<JsonMap>> docs) async {
    final repoPosts = docs.map((doc) => RepoPostModel.fromJson(doc.data())).toList();
    // Fetch all users in parallel
    final userDocs = await Future.wait(repoPosts
        .map((repoPost) => FirebaseFirestore.instance.collection('users').doc(repoPost.userUid).get()));
    final users = userDocs.map((doc) => doc.exists ? UserModel.fromJson(doc.data()!) : null).toList();
    final posts = <PostModel>[];
    for (int i = 0; i < repoPosts.length; i++) {
      final user = users[i];
      if (user != null) {
        final repoPost = repoPosts[i];
        posts.add(PostModel(
          uid: repoPost.uid,
          title: repoPost.title,
          user: user,
          type: repoPost.type,
          urls: repoPost.urls,
          caption: repoPost.caption,
          duration: repoPost.duration,
          status: repoPost.status,
          createdAt: repoPost.createdAt,
          likes: repoPost.likes,
          saves: repoPost.saves,
          views: repoPost.views,
          comments: repoPost.comments,
          moderatorUid: repoPost.moderatorUid,
          moderatedAt: repoPost.moderatedAt,
        ));
      }
    }
    return posts;
  }
}
