import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/core/utils/constants/firestore_constants.dart';
import '../../models/notification_model.dart';
import 'package:riverpod/riverpod.dart';
import '../../providers/firebase_provider.dart';

typedef JsonMap = Map<String, dynamic>;

class NotificationRepository {
  final Ref ref;
  NotificationRepository({required this.ref});
  FirebaseFirestore get firestore => ref.read(firestoreProvider);
  CollectionReference<JsonMap> get _notifications => firestore.collection(FirestoreCollections.notifications);

  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    NotificationType? type,
  }) async {
    final docRef = _notifications.doc();
    final notificationId = docRef.id;

    final notification = NotificationModel(
      uid: notificationId,
      userUid: userId,
      title: title,
      body: body,
      type: type ?? NotificationType.post,
      createdAt: DateTime.now(),
    );

    await docRef.set(notification.toJson());
  }

  Future<List<NotificationModel>> getUserNotifications(String userId, {int limit = 20}) async {
    final query = await _notifications
        .where('userUid', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs.map((doc) => NotificationModel.fromJson(doc.data())).toList();
  }

  Future<List<NotificationModel>> getNotificationsByType(String userId, NotificationType type,
      {int limit = 20}) async {
    final query = await _notifications
        .where('userUid', isEqualTo: userId)
        .where('type', isEqualTo: type.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs.map((doc) => NotificationModel.fromJson(doc.data())).toList();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _notifications.doc(notificationId).delete();
  }

  Future<void> deleteAllNotifications(String userId) async {
    final batch = firestore.batch();
    final userNotifications = await _notifications.where('userUid', isEqualTo: userId).get();

    for (final doc in userNotifications.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<int> getNotificationCount(String userId) async {
    final query = await _notifications.where('userUid', isEqualTo: userId).get();
    return query.docs.length;
  }
}
