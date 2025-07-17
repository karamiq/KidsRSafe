import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/comment_model.dart';
import '../../models/notification_model.dart';
import 'post_repository.dart';
import 'notification_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../../providers/firebase_provider.dart';

typedef JsonMap = Map<String, dynamic>;

class CommentRepository {
  final Ref ref;
  CommentRepository({required this.ref});
  FirebaseFirestore get firestore => ref.read(firestoreProvider);
  CollectionReference<JsonMap> get _comments => firestore.collection('comments');
  PostRepository get _postRepo => PostRepository(ref: ref);
  NotificationRepository get _notificationRepo => NotificationRepository(ref: ref);

  Future<String> addComment({
    required String userId,
    required String postId,
    required String content,
    String? parentCommentId,
  }) async {
    final docRef = _comments.doc();
    final commentId = docRef.id;

    final comment = CommentModel(
      uid: commentId,
      userId: userId,
      postId: postId,
      content: content,
      parentCommentId: parentCommentId,
      createdAt: DateTime.now(),
      likes: 0,
      replies: 0,
    );

    await docRef.set(comment.toJson());

    // Update comment count using PostRepository
    await _postRepo.incrementComments(postId);

    // Get post to find post owner
    final post = await _postRepo.getPost(postId);
    if (post != null && userId != post.userUid) {
      await _notificationRepo.sendNotification(
        userId: post.userUid,
        title: 'New Comment',
        body: 'Someone commented on your post.',
        type: NotificationType.comment,
      );
    }

    return commentId;
  }

  Future<void> deleteComment(String commentId, String postId) async {
    await _comments.doc(commentId).delete();

    // Update comment count using PostRepository
    await _postRepo.decrementComments(postId);
  }

  Future<void> updateComment(String commentId, String content) async {
    await _comments.doc(commentId).update({
      'content': content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<CommentModel>> getCommentsForPost(String postId, {int limit = 20}) async {
    final query = await _comments
        .where('postId', isEqualTo: postId)
        .where('parentCommentId', isEqualTo: null)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs.map((doc) => CommentModel.fromJson(doc.data())).toList();
  }

  Future<List<CommentModel>> getRepliesForComment(String commentId, {int limit = 10}) async {
    final query = await _comments
        .where('parentCommentId', isEqualTo: commentId)
        .orderBy('createdAt', descending: false)
        .limit(limit)
        .get();
    return query.docs.map((doc) => CommentModel.fromJson(doc.data())).toList();
  }

  Future<List<CommentModel>> getCommentsByUser(String userId, {int limit = 20}) async {
    final query = await _comments
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs.map((doc) => CommentModel.fromJson(doc.data())).toList();
  }

  Future<CommentModel?> getComment(String commentId) async {
    final doc = await _comments.doc(commentId).get();
    return doc.exists ? CommentModel.fromJson(doc.data()!) : null;
  }

  Future<int> getCommentCount(String postId) async {
    final query = await _comments.where('postId', isEqualTo: postId).get();
    return query.docs.length;
  }

  Future<void> likeComment(String commentId) async {
    await _comments.doc(commentId).update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> unlikeComment(String commentId) async {
    await _comments.doc(commentId).update({
      'likes': FieldValue.increment(-1),
    });
  }

  Future<void> incrementReplies(String commentId) async {
    await _comments.doc(commentId).update({
      'replies': FieldValue.increment(1),
    });
  }

  Future<void> decrementReplies(String commentId) async {
    await _comments.doc(commentId).update({
      'replies': FieldValue.increment(-1),
    });
  }

  Future<void> removeAllCommentsForPost(String postId) async {
    final batch = firestore.batch();
    final comments = await _comments.where('postId', isEqualTo: postId).get();

    for (final doc in comments.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<void> removeAllCommentsByUser(String userId) async {
    final batch = firestore.batch();
    final comments = await _comments.where('userId', isEqualTo: userId).get();

    for (final doc in comments.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
