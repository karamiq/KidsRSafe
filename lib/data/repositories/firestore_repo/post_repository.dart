import 'package:app/data/models/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/core/utils/constants/firestore_constants.dart';
import '../../models/post_model.dart';
import 'moderation_repository.dart';
import 'notification_repository.dart';

typedef JsonMap = Map<String, dynamic>;

class PostRepository {
  final FirebaseFirestore firestore;
  PostRepository({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;
  final CollectionReference<JsonMap> _posts =
      FirebaseFirestore.instance.collection(FirestoreCollections.posts);
  final ModerationRepository _moderationRepo = ModerationRepository();
  final NotificationRepository _notificationRepo = NotificationRepository();

  Future<String> submitPostForModeration({
    required String userId,
    required PostType type,
    required List<String> urls,
    required String caption,
    List<String>? categories,
    List<String>? tags,
    String? thumbnailUrl,
    int? duration,
    String? music,
  }) async {
    final docRef = _posts.doc();
    final postId = docRef.id;

    // Add to moderation queue first
    await _moderationRepo.addToQueue(
      postId: postId,
      submittedBy: userId,
    );

    // Create the post with pending status
    final post = PostModel(
      uid: postId,
      title: caption, // Use caption as title for now
      userUid: userId,
      type: type,
      urls: urls,
      caption: caption,
      duration: duration,
      status: PostStatus.pending,
      createdAt: DateTime.now(),
      likes: 0,
      saves: 0,
      views: 0,
      comments: 0,
      moderatorUid: null,
      moderatedAt: null,
    );

    await docRef.set(post.toJson());

    // Notify user
    await _notificationRepo.sendNotification(
      userId: userId,
      title: 'Post Submitted',
      body: 'Your post is submitted for moderation.',
      type: NotificationType.postPending,
    );

    return postId;
  }

  /// Called by moderator to approve/reject post, updates post status and notifies user
  Future<void> moderatePost({
    required String postId,
    required String moderatorId,
    required bool approve,
    String? reason,
  }) async {
    final status = approve ? PostStatus.approved : PostStatus.rejected;

    // Update post status
    await _posts.doc(postId).update({
      'status': status.name,
      'moderatorUid': moderatorId,
      'moderatedAt': FieldValue.serverTimestamp(),
    });

    // Get post to find userId
    final post = await getPost(postId);
    if (post != null) {
      await _notificationRepo.sendNotification(
        userId: post.userUid,
        title: approve ? 'Post Approved' : 'Post Rejected',
        body: approve
            ? 'Your post has been approved and is now visible to others.'
            : 'Your post was rejected by moderators.${reason != null ? ' Reason: $reason' : ''}',
        type: approve ? NotificationType.postApproved : NotificationType.postRejected,
      );
    }
  }

  Future<void> updatePost(String postId, PostModel post) async {
    await _posts.doc(postId).update(post.toJson());
  }

  Future<void> setPostStatus(String postId, PostStatus status, {String? moderatorId, String? reason}) async {
    final updateData = {
      'status': status.name,
      'moderatedAt': FieldValue.serverTimestamp(),
    };

    if (moderatorId != null) {
      updateData['moderatorUid'] = moderatorId;
    }

    await _posts.doc(postId).update(updateData);
  }

  Future<PostModel?> getPost(String postId) async {
    final doc = await _posts.doc(postId).get();
    return doc.exists ? PostModel.fromJson(doc.data()!) : null;
  }

  Future<List<PostModel>> getPostsByUser(String userId, {bool onlyApproved = true}) async {
    var query = _posts.where('userUid', isEqualTo: userId);
    if (onlyApproved) {
      query = query.where('status', isEqualTo: PostStatus.approved.name);
    }
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<PostModel>> getPendingPosts() async {
    final query = await _posts.where('status', isEqualTo: PostStatus.pending.name).get();
    return query.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<PostModel>> getApprovedPosts({int limit = 20}) async {
    final query = await _posts
        .where('status', isEqualTo: PostStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<PostModel>> getApprovedPostsAfter({String? lastDocumentId, int limit = 20}) async {
    var query = _posts
        .where('status', isEqualTo: PostStatus.approved.name)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    // If we have a last document ID, start after it
    if (lastDocumentId != null) {
      final lastDoc = await _posts.doc(lastDocumentId).get();
      if (lastDoc.exists) {
        query = query.startAfterDocument(lastDoc);
      }
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<PostModel>> getPostsByStatus(PostStatus status, {int limit = 20}) async {
    final query = await _posts
        .where('status', isEqualTo: status.name)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return query.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
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
}
