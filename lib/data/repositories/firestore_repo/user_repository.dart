import 'package:app/common_lib.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/core/utils/constants/firestore_constants.dart';
import 'follow_repository.dart';
import 'post_repository.dart';
import 'save_repository.dart';
import 'like_repository.dart';

typedef JsonMap = Map<String, dynamic>;

class UserRepository {
  final Ref ref;
  final FirebaseFirestore firestore;
  UserRepository({FirebaseFirestore? firestore, required this.ref})
      : firestore = firestore ?? FirebaseFirestore.instance;
  final CollectionReference<JsonMap> _users =
      FirebaseFirestore.instance.collection(FirestoreCollections.users);

  Future<void> createUser({
    required String uid,
    required String email,
    required String displayName,
    required DateTime dateOfBirth,
    required String profilePicture,
    String? parentEmail,
  }) async {
    final docRef = _users.doc(uid);

    // Get assigned moderator first
    final assignedModerator = await _assignToAvailableModerator();

    final userModel = UserModel(
      uid: uid,
      email: email,
      name: displayName,
      role: UserRole.kid,
      dateOfBirth: dateOfBirth,
      createdAt: DateTime.now(),
      status: UserStatus.pending,
      assignedModerator: assignedModerator,
      parentEmail: parentEmail,
      profilePicture: profilePicture,
    );

    await docRef.set(userModel.toJson());
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  Future<String?> _assignToAvailableModerator() async {
    final moderators = await getModerators();
    if (moderators.isEmpty) return null;

    // Find moderator with fewest pending users
    String? selectedModeratorId;
    int minPending = 999999;

    for (final moderator in moderators) {
      final pendingUsers = await _users
          .where('assignedModerator', isEqualTo: moderator.uid)
          .where('status', isEqualTo: UserStatus.pending.name)
          .get();

      if (pendingUsers.size < minPending) {
        minPending = pendingUsers.size;
        selectedModeratorId = moderator.uid;
      }
    }

    return selectedModeratorId;
  }

  Future<void> assignUserToModerator(String userId, String moderatorId) async {
    await _users.doc(userId).update({
      'assignedModerator': moderatorId,
    });
  }

  Future<List<UserModel>> getUsersAssignedToModerator(String moderatorId) async {
    final query = await _users.where('assignedModerator', isEqualTo: moderatorId).get();
    return query.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<List<UserModel>> getPendingUsersForModerator(String moderatorId) async {
    final query = await _users
        .where('assignedModerator', isEqualTo: moderatorId)
        .where('status', isEqualTo: UserStatus.pending.name)
        .get();
    return query.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.exists ? UserModel.fromJson(doc.data()!) : null;
  }

  Future<void> updateUser(String uid, UserModel user) async {
    await _users.doc(uid).update(user.toJson());
  }

  Future<void> updateUserStatus(String uid, UserStatus status) async {
    await _users.doc(uid).update({
      'status': status.name,
    });
  }

  Future<void> approveParentalConsent(String uid) async {
    await _users.doc(uid).update({'parentalApproved': true});
  }

  Future<void> updateRole(String uid, UserRole role) async {
    await _users.doc(uid).update({'role': role.name});
  }

  Future<void> banUser(String uid) async {
    await _users.doc(uid).update({'status': UserStatus.banned.name});
  }

  Future<List<UserModel>> getModerators() async {
    final query = await _users.where('role', isEqualTo: UserRole.moderator.name).get();
    return query.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<List<UserModel>> getKids({bool onlyApproved = true}) async {
    var query = _users.where('role', isEqualTo: UserRole.kid.name);
    if (onlyApproved) {
      query = query.where('status', isEqualTo: UserStatus.approved.name);
    }
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<UserModel?> getKidById(String id) async {
    final doc = await _users.doc(id).get();
    if (!doc.exists) return null;
    final user = UserModel.fromJson(doc.data()!);
    return user.role == UserRole.kid ? user : null;
  }

  /// Get user info with followers, following, and posts
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final user = await getUser(uid);
    if (user == null) return null;

    final followRepo = FollowRepository();
    final postRepo = PostRepository();
    final saveRepo = SaveRepository();
    final likeRepo = LikeRepository();

    final followers = await followRepo.getFollowers(uid);
    final following = await followRepo.getFollowing(uid);
    final posts = await postRepo.getPostsByUser(uid, onlyApproved: true);
    final savedPostIds = await saveRepo.getSavedPostIds(uid);
    final likedPostIds = await likeRepo.getLikedPostIds(uid);

    return {
      'user': user,
      'followers': followers,
      'following': following,
      'posts': posts,
      'savedPosts': savedPostIds,
      'likedPosts': likedPostIds,
    };
  }

  /// Approve a user by a moderator
  Future<void> approveByModerator(String uid) async {
    await updateUserStatus(uid, UserStatus.approved);
  }

  /// Reject a user by a moderator
  Future<void> rejectByModerator(String uid) async {
    await updateUserStatus(uid, UserStatus.rejected);
  }

  /// Check if a user is approved by a moderator
  Future<bool> isModeratorApproved(String uid) async {
    final user = await getUser(uid);
    return user?.status == UserStatus.approved;
  }

  /// Get users by status
  Future<List<UserModel>> getUsersByStatus(UserStatus status) async {
    final query = await _users.where('status', isEqualTo: status.name).get();
    return query.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}
