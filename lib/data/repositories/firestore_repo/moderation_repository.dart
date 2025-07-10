import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/moderation_model.dart';

typedef JsonMap = Map<String, dynamic>;

class ModerationRepository {
  final FirebaseFirestore firestore;
  ModerationRepository({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;
  CollectionReference<JsonMap> get _queue => firestore.collection('moderation_queue');

  Future<String> addToQueue({
    required String postId,
    required String submittedBy,
  }) async {
    final docRef = _queue.doc();
    final queueId = docRef.id;

    final moderationItem = ModerationModel(
      uid: queueId,
      postId: postId,
      submittedBy: submittedBy,
      status: 'pending',
      createdAt: DateTime.now(),
      assignedTo: null,
      moderationAction: null,
      moderationReason: null,
      moderatedAt: null,
    );

    await docRef.set(moderationItem.toJson());
    return queueId;
  }

  Future<void> assignToModerator(String queueId, String moderatorId) async {
    await _queue.doc(queueId).update({'assignedTo': moderatorId});
  }

  Future<void> moderateQueueItem(String queueId, ModerationAction action, {String? reason}) async {
    final updateData = {
      'moderationAction': action.name,
      'status': action == ModerationAction.approve ? 'approved' : 'rejected',
      'moderatedAt': FieldValue.serverTimestamp(),
    };

    if (reason != null) {
      updateData['moderationReason'] = reason;
    }

    await _queue.doc(queueId).update(updateData);
  }

  Future<List<ModerationModel>> getPendingQueue() async {
    final query = await _queue.where('status', isEqualTo: 'pending').get();
    return query.docs.map((doc) => ModerationModel.fromJson(doc.data())).toList();
  }

  Future<List<ModerationModel>> getQueueByModerator(String moderatorId) async {
    final query = await _queue.where('assignedTo', isEqualTo: moderatorId).get();
    return query.docs.map((doc) => ModerationModel.fromJson(doc.data())).toList();
  }

  Future<List<ModerationModel>> getQueueByStatus(String status) async {
    final query = await _queue.where('status', isEqualTo: status).get();
    return query.docs.map((doc) => ModerationModel.fromJson(doc.data())).toList();
  }

  Future<ModerationModel?> getModerationItem(String queueId) async {
    final doc = await _queue.doc(queueId).get();
    return doc.exists ? ModerationModel.fromJson(doc.data()!) : null;
  }

  Future<void> flagContent(String postId, String flaggedBy, {String? reason}) async {
    final docRef = _queue.doc();
    final queueId = docRef.id;

    final moderationItem = ModerationModel(
      uid: queueId,
      postId: postId,
      submittedBy: flaggedBy,
      status: 'flagged',
      createdAt: DateTime.now(),
      assignedTo: null,
      moderationAction: null,
      moderationReason: reason,
      moderatedAt: null,
    );

    await docRef.set(moderationItem.toJson());
  }

  Future<void> updateQueueWithPostId(String queueId, String postId) async {
    await _queue.doc(queueId).update({'postId': postId});
  }

  Future<List<ModerationModel>> getModerationHistory(String postId) async {
    final query = await _queue.where('postId', isEqualTo: postId).get();
    return query.docs.map((doc) => ModerationModel.fromJson(doc.data())).toList();
  }

  Future<List<ModerationModel>> getModerationsByUser(String userId) async {
    final query = await _queue.where('submittedBy', isEqualTo: userId).get();
    return query.docs.map((doc) => ModerationModel.fromJson(doc.data())).toList();
  }

  Future<List<ModerationModel>> getModerationsByModerator(String moderatorId) async {
    final query = await _queue.where('assignedTo', isEqualTo: moderatorId).get();
    return query.docs.map((doc) => ModerationModel.fromJson(doc.data())).toList();
  }
}
