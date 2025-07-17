import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/save_model.dart';
import '../../models/notification_model.dart';
import 'post_repository.dart';
import 'notification_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../../providers/firebase_provider.dart';

typedef JsonMap = Map<String, dynamic>;

class SaveRepository {
  final Ref ref;
  SaveRepository({required this.ref});
  FirebaseFirestore get firestore => ref.read(firestoreProvider);
  CollectionReference<JsonMap> get _saves => firestore.collection('saves');
  PostRepository get _postRepo => PostRepository(ref: ref);
  NotificationRepository get _notificationRepo => NotificationRepository(ref: ref);

  Future<void> savePost({required String userId, required String postId, required String postOwnerId}) async {
    final saveModel = SaveModel(
      userUid: userId,
      postUid: postId,
      createdAt: DateTime.now(),
    );
    await _saves.doc('${userId}_$postId').set(saveModel.toJson());

    // Update save count using PostRepository
    await _postRepo.incrementSaves(postId);

    // Notify post owner
    if (userId != postOwnerId) {
      await _notificationRepo.sendNotification(
        userId: postOwnerId,
        title: 'Post Saved',
        body: 'Someone saved your post.',
        type: NotificationType.post,
      );
    }
  }

  Future<void> unsavePost(
      {required String userId, required String postId, required String postOwnerId}) async {
    await _saves.doc('${userId}_$postId').delete();

    // Update save count using PostRepository
    await _postRepo.decrementSaves(postId);
  }

  Future<int> getSaveCount(String postId) async {
    final query = await _saves.where('postUid', isEqualTo: postId).get();
    return query.docs.length;
  }

  Future<List<String>> getSavedPostIds(String userId) async {
    final userQuery = await _saves.where('userUid', isEqualTo: userId).get();
    return userQuery.docs.map((doc) => doc['postUid'] as String).toList();
  }

  Future<bool> isPostSavedByUser(String userId, String postId) async {
    final doc = await _saves.doc('${userId}_$postId').get();
    return doc.exists;
  }

  Future<List<SaveModel>> getSavesForPost(String postId) async {
    final query = await _saves.where('postUid', isEqualTo: postId).get();
    return query.docs.map((doc) => SaveModel.fromJson(doc.data())).toList();
  }

  Future<List<SaveModel>> getSavesByUser(String userId) async {
    final query = await _saves.where('userUid', isEqualTo: userId).get();
    return query.docs.map((doc) => SaveModel.fromJson(doc.data())).toList();
  }

  Future<void> removeAllSavesForPost(String postId) async {
    final batch = firestore.batch();
    final saves = await _saves.where('postUid', isEqualTo: postId).get();

    for (final doc in saves.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<void> removeAllSavesByUser(String userId) async {
    final batch = firestore.batch();
    final saves = await _saves.where('userUid', isEqualTo: userId).get();

    for (final doc in saves.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
