import 'dart:io';

import 'package:app/core/services/file_upload_service.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/repositories/firestore_repo/firebase_request.dart';
import '../providers/firebase_provider.dart';
import '../../core/services/clients/_clients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth with AsyncXNotifierMixin<dynamic> {
  @override
  Future<AsyncX<dynamic>> build() => idle();

  @useResult
  RunXCallback<dynamic> login(String email, String password) => handle(() async {
        final firebaseAuth = ref.read(firebaseAuthProvider);
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final authUser = userCredential.user;
        if (authUser == null) throw Exception('Login failed');
        final userRepo = ref.read(userRepositoryProvider);
        final user =
            await ref.read(firebaseRequestProvider.notifier).auth(() => userRepo.getUser(authUser.uid));

        ref.read(userProvider.notifier).update((state) => user!);

        return user;
      });

  @useResult
  RunXCallback<dynamic> register({
    required String email,
    required String password,
    required String displayName,
    required DateTime dateOfBirth,
    required String parentEmail,
    required File profilePicture,
    required String userName,
  }) =>
      handle(() async {
        final firebaseAuth = ref.read(firebaseAuthProvider);
        final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final authUser = userCredential.user;
        if (authUser == null) throw Exception('Failed to create Firebase Auth user');

        final storageService = ref.read(fileUploadServiceProvider);
        final imageUrl = await storageService.uploadFile(profilePicture, path: 'profile_pictures/');

        final userRepo = ref.read(userRepositoryProvider);
        await ref.read(firebaseRequestProvider.notifier).auth(() => userRepo.createUser(
              uid: authUser.uid,
              email: email,
              displayName: displayName,
              dateOfBirth: dateOfBirth,
              parentEmail: parentEmail,
              userName: userName,
              profilePicture: imageUrl ?? '',
            ));
      });

  Future<void> _removeFcmTokenOnLogout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken == null) return;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    await userDoc.update({
      'fcmTokens': FieldValue.arrayRemove([fcmToken])
    });
  }

  @useResult
  RunXCallback<dynamic> logout() => handle(() async {
        await _removeFcmTokenOnLogout();
        final firebaseAuth = ref.read(firebaseAuthProvider);
        await firebaseAuth.signOut();
        ref.read(userProvider.notifier).logout();
      });
}
