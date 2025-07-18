import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/providers/post_provider.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/src/home/components/post_media_view.dart';
import 'package:app/src/home/components/comments_section.dart';
import 'package:flutter/material.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageController _pageController = PageController();
  bool _scrolledToPost = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showCommentDialog(BuildContext context, PostModel post, String currentUserId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CommentsSection(
          post: post,
          currentUserId: currentUserId,
          onCommentAdded: () {
            ref.refresh(getPostsProvider);
          },
        );
      },
    );
  }

  void _showShareDialog(BuildContext context, PostModel post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Share Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link copied to clipboard!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share via...'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share functionality coming soon!')),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(getPostsProvider);
    final currentUser = ref.watch(userProvider);
    final goRouterState = GoRouterState.of(context);
    final postId = goRouterState.uri.queryParameters['postId'];

    return Scaffold(
      backgroundColor: Colors.black,
      body: postsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(getPostsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (posts) {
          // If postId is provided, scroll to that post
          if (!_scrolledToPost && postId != null && posts.isNotEmpty) {
            final index = posts.indexWhere((p) => p.uid == postId);
            if (index != -1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _pageController.jumpToPage(index);
              });
              _scrolledToPost = true;
            }
          }
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: posts.length,
            onPageChanged: (index) {
              // Increment views for the current post
              if (index < posts.length) {
                // Optionally: ref.read(postActionsProvider.notifier).incrementViews(posts[index].uid);
              }
            },
            itemBuilder: (context, index) {
              final post = posts[index];
              final currentUserId = currentUser?.uid ?? 'anonymous';

              return PostMediaView(
                post: post,
                onLike: () {
                  // Handle like functionality
                },
                onComment: () => _showCommentDialog(context, post, currentUserId),
                onShare: () => _showShareDialog(context, post),
                isLiked: false,
                isSaved: false,
              );
            },
          );
        },
      ),
    );
  }
}
