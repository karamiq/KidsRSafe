// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:app/common_lib.dart';
import 'package:app/core/services/clients/_clients.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/providers/firebase_provider.dart';

part 'home_provider.g.dart';

@riverpod
Future<List<PostModel>> getPosts(
  Ref ref, {
  PostModel? startAfterDoc,
  int limit = 10,
}) async {
  var query = ref.read(firestoreProvider).collection('posts').limit(limit);

  if (startAfterDoc != null) {
    final startAfterDocSnapshot =
        await ref.read(firestoreProvider).collection('posts').doc(startAfterDoc.uid).get();
    query = query.startAfterDocument(startAfterDocSnapshot);
  }

  final querySnapshot = await query.get();
  final data = querySnapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();

  return data;
}
