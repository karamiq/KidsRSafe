import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/src/profile/profile_page.dart';
import 'package:app/src/inbox/chats/chat_detail_page.dart';
import 'package:app/data/models/post_model.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String _query = '';
  final bool _searchUsers = true;
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    final chatsRepository = ref.watch(chatsRepositoryProvider);
    final postRepository = ref.watch(postRepositoryProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search users or posts',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() => _query = value.trim()),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: _query.isEmpty
                  ? userRepository
                      .getKids(onlyApproved: true)
                      .asStream()
                      .map((users) => users.where((u) => u.uid != currentUser?.uid).take(20).toList())
                  : userRepository.searchUsers(_query, currentUser?.uid ?? ''),
              builder: (context, userSnapshot) {
                return StreamBuilder<List<PostModel>>(
                  stream: _query.isEmpty
                      ? postRepository.getApprovedPosts(limit: 20).asStream()
                      : postRepository.searchPosts(_query),
                  builder: (context, postSnapshot) {
                    final users = userSnapshot.data ?? [];
                    final posts = postSnapshot.data ?? [];
                    if (userSnapshot.connectionState == ConnectionState.waiting ||
                        postSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Text('Users', style: Theme.of(context).textTheme.titleMedium),
                        ),
                        if (users.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('No users found.'),
                          )
                        else
                          ...users.map((user) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user.profilePicture),
                                ),
                                title: Text(user.name),
                                subtitle: Text('@${user.username}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProfilePage(userId: user.uid),
                                    ),
                                  );
                                },
                              )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Text('Posts', style: Theme.of(context).textTheme.titleMedium),
                        ),
                        if (posts.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('No posts found.'),
                          )
                        else
                          ...posts.map((post) => ListTile(
                                leading: post.urls.isNotEmpty
                                    ? Image.network(post.urls.first, width: 48, height: 48, fit: BoxFit.cover)
                                    : const Icon(Icons.image, size: 48),
                                title: Text(post.title),
                                subtitle: Text(post.caption),
                                onTap: () {
                                  // TODO: Navigate to post detail page
                                },
                              )),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
