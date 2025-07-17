import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/follow_model.dart';
import '../../models/notification_model.dart';
import 'notification_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../../providers/firebase_provider.dart';

typedef JsonMap = Map<String, dynamic>;

class FollowRepository {
  final Ref ref;
  FollowRepository({required this.ref});
  FirebaseFirestore get firestore => ref.read(firestoreProvider);
  NotificationRepository get _notificationRepo => NotificationRepository(ref: ref);
  CollectionReference<JsonMap> get _follows => firestore.collection('follows');

  Future<void> followUser({required String followerId, required String followingId}) async {
    final followModel = FollowModel(
      followerId: followerId,
      followingId: followingId,
      createdAt: DateTime.now(),
    );
    await _follows.doc('${followerId}_$followingId').set(followModel.toJson());

    // Notify followed user
    if (followerId != followingId) {
      await _notificationRepo.sendNotification(
        userId: followingId,
        title: 'New Follower',
        body: 'Someone followed you.',
        type: NotificationType.post,
      );
    }
  }

  Future<void> unfollowUser({required String followerId, required String followingId}) async {
    await _follows.doc('${followerId}_$followingId').delete();
  }

  Future<List<String>> getFollowers(String userId) async {
    final query = await _follows.where('followingId', isEqualTo: userId).get();
    return query.docs.map((doc) => doc['followerId'] as String).toList();
  }

  Future<List<String>> getFollowing(String userId) async {
    final query = await _follows.where('followerId', isEqualTo: userId).get();
    return query.docs.map((doc) => doc['followingId'] as String).toList();
  }

  Future<bool> isFollowing(String followerId, String followingId) async {
    final doc = await _follows.doc('${followerId}_$followingId').get();
    return doc.exists;
  }

  Future<int> getFollowerCount(String userId) async {
    final query = await _follows.where('followingId', isEqualTo: userId).get();
    return query.docs.length;
  }

  Future<int> getFollowingCount(String userId) async {
    final query = await _follows.where('followerId', isEqualTo: userId).get();
    return query.docs.length;
  }

  Future<List<FollowModel>> getFollowersList(String userId) async {
    final query = await _follows.where('followingId', isEqualTo: userId).get();
    return query.docs.map((doc) => FollowModel.fromJson(doc.data())).toList();
  }

  Future<List<FollowModel>> getFollowingList(String userId) async {
    final query = await _follows.where('followerId', isEqualTo: userId).get();
    return query.docs.map((doc) => FollowModel.fromJson(doc.data())).toList();
  }

  Future<void> removeAllFollowers(String userId) async {
    final batch = firestore.batch();
    final followers = await _follows.where('followingId', isEqualTo: userId).get();

    for (final doc in followers.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<void> removeAllFollowing(String userId) async {
    final batch = firestore.batch();
    final following = await _follows.where('followerId', isEqualTo: userId).get();

    for (final doc in following.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<FollowModel>> getFollowsByUser(String userId) async {
    final query = await _follows.where('followerId', isEqualTo: userId).get();
    return query.docs.map((doc) => FollowModel.fromJson(doc.data())).toList();
  }

  Future<List<FollowModel>> getFollowsOfUser(String userId) async {
    final query = await _follows.where('followingId', isEqualTo: userId).get();
    return query.docs.map((doc) => FollowModel.fromJson(doc.data())).toList();
  }
}
