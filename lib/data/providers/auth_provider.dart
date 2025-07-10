import 'dart:io';

import 'package:app/core/services/cloudinary_storage_service.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/repositories/firestore_repo/firebase_request.dart';
import 'package:app/router/app_router.dart';
import '../providers/firebase_provider.dart';
import '../../core/services/clients/_clients.dart';
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
            await ref.read(firebaseRequestProvider.notifier).auth(() => userRepo.getKidById(authUser.uid));

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
  }) =>
      handle(() async {
        final firebaseAuth = ref.read(firebaseAuthProvider);
        final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final authUser = userCredential.user;
        if (authUser == null) throw Exception('Failed to create Firebase Auth user');

        final storageService = CloudinaryUploadService();
        final imageUrl = await storageService.uploadFile(profilePicture);

        final userRepo = ref.read(userRepositoryProvider);
        await ref.read(firebaseRequestProvider.notifier).auth(() => userRepo.createUser(
              uid: authUser.uid,
              email: email,
              displayName: displayName,
              dateOfBirth: dateOfBirth,
              parentEmail: parentEmail,
              profilePicture: imageUrl ?? '',
            ));
      });
}
