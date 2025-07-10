import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/like_model.dart';
import '../../models/notification_model.dart';
import 'post_repository.dart';
import 'notification_repository.dart';

typedef JsonMap = Map<String, dynamic>;

class LikeRepository {
  final FirebaseFirestore firestore;
  LikeRepository({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;
  CollectionReference<JsonMap> get _likes => firestore.collection('likes');
  final PostRepository _postRepo = PostRepository();
  final NotificationRepository _notificationRepo = NotificationRepository();

  Future<void> likePost({required String userId, required String postId, required String postOwnerId}) async {
    final likeModel = LikeModel(
      userId: userId,
      postId: postId,
      createdAt: DateTime.now(),
    );
    await _likes.doc('${userId}_$postId').set(likeModel.toJson());

    // Update like count using PostRepository
    await _postRepo.incrementLikes(postId);

    // Notify post owner
    if (userId != postOwnerId) {
      await _notificationRepo.sendNotification(
        userId: postOwnerId,
        title: 'New Like',
        body: 'Someone liked your post.',
        type: NotificationType.like,
      );
    }
  }

  Future<void> unlikePost(
      {required String userId, required String postId, required String postOwnerId}) async {
    await _likes.doc('${userId}_$postId').delete();

    // Update like count using PostRepository
    await _postRepo.decrementLikes(postId);
  }

  Future<int> getLikeCount(String postId) async {
    final query = await _likes.where('postId', isEqualTo: postId).get();
    return query.docs.length;
  }

  Future<bool> isPostLikedByUser(String userId, String postId) async {
    final doc = await _likes.doc('${userId}_$postId').get();
    return doc.exists;
  }

  Future<List<String>> getLikedPostIds(String userId) async {
    final query = await _likes.where('userId', isEqualTo: userId).get();
    return query.docs.map((doc) => doc['postId'] as String).toList();
  }

  Future<List<LikeModel>> getLikesForPost(String postId) async {
    final query = await _likes.where('postId', isEqualTo: postId).get();
    return query.docs.map((doc) => LikeModel.fromJson(doc.data())).toList();
  }

  Future<List<LikeModel>> getLikesByUser(String userId) async {
    final query = await _likes.where('userId', isEqualTo: userId).get();
    return query.docs.map((doc) => LikeModel.fromJson(doc.data())).toList();
  }

  Future<void> removeAllLikesForPost(String postId) async {
    final batch = firestore.batch();
    final likes = await _likes.where('postId', isEqualTo: postId).get();

    for (final doc in likes.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<void> removeAllLikesByUser(String userId) async {
    final batch = firestore.batch();
    final likes = await _likes.where('userId', isEqualTo: userId).get();

    for (final doc in likes.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
