import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/providers/firebase_provider.dart';
import 'package:app/src/home/components/video_player_widget.dart';
import 'dart:async';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepository = ref.watch(userRepositoryProvider);
    final postRepository = ref.watch(postRepositoryProvider);
    final currentUser = ref.watch(userProvider);
    final searchController = useTextEditingController();
    final debouncedQuery = useState('');
    final tabController = useTabController(initialLength: 2);
    Timer? debounce;

    useEffect(() {
      void listener() {
        if (debounce?.isActive ?? false) debounce!.cancel();
        debounce = Timer(const Duration(milliseconds: 350), () {
          debouncedQuery.value = searchController.text.trim();
        });
      }

      searchController.addListener(listener);
      return () {
        searchController.removeListener(listener);
        debounce?.cancel();
      };
    }, [searchController]);

    Future<List<UserModel>> fetchUsers() async {
      final results = await userRepository
          .searchUsers(
            debouncedQuery.value.toLowerCase(),
            currentUser?.uid ?? '',
          )
          .first;
      return results;
    }

    Future<List<PostModel>> fetchPosts({bool search = false}) async {
      if (!search) {
        // Trending/recent posts
        return await postRepository.getApprovedPosts(limit: 10);
      } else {
        final posts = await postRepository.getApprovedPosts(limit: 100);
        return posts
            .where((post) =>
                post.title.toLowerCase().contains(debouncedQuery.value.toLowerCase()) ||
                post.caption.toLowerCase().contains(debouncedQuery.value.toLowerCase()))
            .take(20)
            .toList();
      }
    }

    final isSearching = debouncedQuery.value.isNotEmpty;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search users or posts',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                ),
              ),
            ),
            if (!isSearching)
              // Only show posts when not searching
              Expanded(
                child: FutureBuilder<List<PostModel>>(
                  future: fetchPosts(search: false),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final posts = snapshot.data ?? [];
                    if (posts.isEmpty) {
                      return const Center(child: Text('No trending posts.'));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text('Trending Posts', style: Theme.of(context).textTheme.titleMedium),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.85,
                            ),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    // Navigate to HomePage and scroll to this post
                                    context.go('/home?postId=${post.uid}');
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: post.type == PostType.video
                                            ? Stack(
                                                children: [
                                                  VideoPlayerWidget(
                                                    videoUrl: post.urls.first,
                                                    onTap: () {},
                                                  ),
                                                  const Align(
                                                    alignment: Alignment.center,
                                                    child: Icon(Icons.play_circle_fill,
                                                        size: 48, color: Colors.white70),
                                                  ),
                                                ],
                                              )
                                            : post.urls.isNotEmpty
                                                ? Image.network(
                                                    post.urls.first,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    errorBuilder: (context, error, stackTrace) =>
                                                        const Icon(Icons.broken_image),
                                                  )
                                                : const Icon(Icons.broken_image),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          post.title,
                                          style: const TextStyle(
                                              color: Colors.black, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            else
              // Show tabs for posts and users when searching
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      tabs: const [
                        Tab(text: 'Posts'),
                        Tab(text: 'Users'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          // Posts Tab
                          FutureBuilder<List<PostModel>>(
                            future: fetchPosts(search: true),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              final posts = snapshot.data ?? [];
                              if (posts.isEmpty) {
                                return const Center(child: Text('No posts match your search.'));
                              }
                              return GridView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.85,
                                ),
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  final post = posts[index];
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    clipBehavior: Clip.antiAlias,
                                    child: InkWell(
                                      onTap: () {
                                        context.go('/home?postId=${post.uid}');
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: post.type == PostType.video
                                                ? Stack(
                                                    children: [
                                                      VideoPlayerWidget(
                                                        videoUrl: post.urls.first,
                                                        onTap: () {},
                                                      ),
                                                      const Align(
                                                        alignment: Alignment.center,
                                                        child: Icon(Icons.play_circle_fill,
                                                            size: 48, color: Colors.white70),
                                                      ),
                                                    ],
                                                  )
                                                : post.urls.isNotEmpty
                                                    ? Image.network(
                                                        post.urls.first,
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        errorBuilder: (context, error, stackTrace) =>
                                                            const Icon(Icons.broken_image),
                                                      )
                                                    : const Icon(Icons.broken_image),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              post.title,
                                              style: const TextStyle(
                                                  color: Colors.black, fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          // Users Tab
                          FutureBuilder<List<UserModel>>(
                            future: fetchUsers(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              final users = snapshot.data ?? [];
                              if (users.isEmpty) {
                                return const Center(child: Text('No users match your search.'));
                              }
                              return ListView.separated(
                                itemCount: users.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(indent: 72, endIndent: 16, height: 0),
                                itemBuilder: (context, index) {
                                  final user = users[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(user.profilePicture),
                                      radius: 28,
                                    ),
                                    title: Text(user.name, style: Theme.of(context).textTheme.titleMedium),
                                    subtitle: Text('@${user.username}'),
                                    onTap: () {
                                      context.push('/profiles/${user.uid}');
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
