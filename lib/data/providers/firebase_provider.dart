import 'package:app/core/firebase/firebase_messaging_service.dart';
import 'package:app/core/services/clients/_clients.dart';
import 'package:app/data/repositories/firestore_repo/chats/chats_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/firestore_repo/user_repository.dart';
import '../repositories/firestore_repo/posts/post_repository.dart';
import '../../data/repositories/firestore_repo/moderation_repository.dart';
import '../../data/repositories/firestore_repo/notification_repository.dart';
import '../../data/repositories/firestore_repo/like_repository.dart';
import '../../data/repositories/firestore_repo/save_repository.dart';
import '../../data/repositories/firestore_repo/follow_repository.dart';

part 'firebase_provider.g.dart';

@riverpod
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;

@riverpod
UserRepository userRepository(Ref ref) => UserRepository(ref: ref);

@riverpod
PostRepository postRepository(Ref ref) => PostRepository(ref: ref);

@riverpod
ModerationRepository moderationRepository(Ref ref) => ModerationRepository(ref: ref);

@riverpod
NotificationRepository notificationRepository(Ref ref) => NotificationRepository(ref: ref);

@riverpod
LikeRepository likeRepository(Ref ref) => LikeRepository(ref: ref);

@riverpod
SaveRepository saveRepository(Ref ref) => SaveRepository(ref: ref);

@riverpod
FollowRepository followRepository(Ref ref) => FollowRepository(ref: ref);

@riverpod
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@riverpod
ChatsRepository chatsRepository(Ref ref) => ChatsRepository(ref: ref);

@riverpod
FirebaseMessagingService firebaseMessegingService(Ref ref) {
  return FirebaseMessagingService();
}
