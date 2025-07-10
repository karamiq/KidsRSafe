import 'package:app/core/services/clients/_clients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/firestore_repo/user_repository.dart';
import '../../data/repositories/firestore_repo/post_repository.dart';
import '../../data/repositories/firestore_repo/moderation_repository.dart';
import '../../data/repositories/firestore_repo/notification_repository.dart';
import '../../data/repositories/firestore_repo/like_repository.dart';
import '../../data/repositories/firestore_repo/save_repository.dart';
import '../../data/repositories/firestore_repo/follow_repository.dart';

part 'firebase_provider.g.dart';

@riverpod
FirebaseFirestore firestore(Ref ref) => FirebaseFirestore.instance;

@riverpod
UserRepository userRepository(Ref ref) => UserRepository(firestore: ref.watch(firestoreProvider), ref: ref);

@riverpod
PostRepository postRepository(Ref ref) => PostRepository(firestore: ref.watch(firestoreProvider));

@riverpod
ModerationRepository moderationRepository(Ref ref) =>
    ModerationRepository(firestore: ref.watch(firestoreProvider));

@riverpod
NotificationRepository notificationRepository(Ref ref) =>
    NotificationRepository(firestore: ref.watch(firestoreProvider));

@riverpod
LikeRepository likeRepository(Ref ref) => LikeRepository(firestore: ref.watch(firestoreProvider));

@riverpod
SaveRepository saveRepository(Ref ref) => SaveRepository(firestore: ref.watch(firestoreProvider));

@riverpod
FollowRepository followRepository(Ref ref) => FollowRepository(firestore: ref.watch(firestoreProvider));

@riverpod
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;
