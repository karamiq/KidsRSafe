import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:app/core/services/clients/_clients.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as p;

part 'file_upload_service.g.dart';

@riverpod
FileUplodService fileUploadService(Ref ref) => FileUplodService();

class FileUplodService {
  Future<String?> uploadFile(File file, {required String path}) async {
    if (!await file.exists()) {
      return null;
    }

    final fileSize = await file.length();
    if (fileSize > 100 * 1024 * 1024) {
      return null;
    }

    // Check if user is authenticated with Firebase Auth
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    try {
      final fileName = p.basename(file.path);
      final storageRef = FirebaseStorage.instance.ref().child('$path/$fileName');

      final uploadTask = storageRef.putFile(file);

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      if (e.toString().contains('unauthorized') || e.toString().contains('permission')) {}
      return null;
    }
  }

  // Optional: keep _getAccessToken if other files still use it, or safely remove
  Future<String?> _getAccessToken() async {
    // Firebase doesn't require manual token generation here
    return null;
  }
}
