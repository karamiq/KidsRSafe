import 'package:app/data/models/post_model.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/repositories/firestore_repo/posts/models/repo_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'post_provider.g.dart';

@riverpod
Future<List<PostModel>> getPosts(Ref ref) async {
  final querySnapshot = await FirebaseFirestore.instance.collection('posts').get();
  final repoPosts = querySnapshot.docs.map((doc) => RepoPostModel.fromJson(doc.data())).toList();

  // Fetch all users in parallel
  final userDocs = await Future.wait(repoPosts
      .map((repoPost) => FirebaseFirestore.instance.collection('users').doc(repoPost.userUid).get()));
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

@riverpod
class PostActions extends _$PostActions {
  @override
  void build() {}

  Future<void> incrementViews(String postId) async {}

  Future<void> likePost(String postId, String userId) async {}

  Future<void> unlikePost(String postId, String userId) async {}

  Future<void> savePost(String postId, String userId) async {}

  Future<void> unsavePost(String postId, String userId) async {}
}
