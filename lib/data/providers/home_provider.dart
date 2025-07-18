// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:app/common_lib.dart';
import 'package:app/core/services/clients/_clients.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/data/repositories/firestore_repo/posts/models/repo_post_model.dart';

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
  final repoPosts = querySnapshot.docs.map((doc) => RepoPostModel.fromJson(doc.data())).toList();

  // Fetch all users in parallel
  final userDocs = await Future.wait(repoPosts
      .map((repoPost) => ref.read(firestoreProvider).collection('users').doc(repoPost.userUid).get()));
  final users = userDocs.map((doc) => doc.exists ? UserModel.fromJson(doc.data()!) : null).toList();

  final posts = <PostModel>[];
  for (int i = 0; i < repoPosts.length; i++) {
    final user = users[i];
    if (user != null) {
      final repoPost = repoPosts[i];
      posts.add(PostModel(
        uid: repoPost.uid,
        title: repoPost.title,
        user: user,
        type: repoPost.type,
        urls: repoPost.urls,
        caption: repoPost.caption,
        duration: repoPost.duration,
        status: repoPost.status,
        createdAt: repoPost.createdAt,
        likes: repoPost.likes,
        saves: repoPost.saves,
        views: repoPost.views,
        comments: repoPost.comments,
        moderatorUid: repoPost.moderatorUid,
        moderatedAt: repoPost.moderatedAt,
      ));
    }
  }
  return posts;
}
