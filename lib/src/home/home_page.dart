import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/models/user_model.dart';
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
            ref.read(postsProvider.notifier).refreshPosts();
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(postsProvider);
    final currentUser = ref.watch(userProvider);
    final userRole = ref.watch(userProvider)?.role;
    final isKid = userRole == UserRole.kid;

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
                onPressed: () => ref.read(postsProvider.notifier).refreshPosts(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (posts) => PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: posts.length + (ref.read(postsProvider.notifier).hasMore ? 1 : 0),
          onPageChanged: (index) {
            // Load more posts when user is about to reach the end (2 posts before the end)
            if (index >= posts.length - 2 &&
                ref.read(postsProvider.notifier).hasMore &&
                !ref.read(postsProvider.notifier).isLoading) {
              ref.read(postsProvider.notifier).loadMorePosts();
            }

            // Increment views for the current post
            if (index < posts.length) {
              final currentUserId = currentUser?.uid ?? 'anonymous';
              ref.read(postActionsProvider.notifier).incrementViews(posts[index].uid);
            }
          },
          itemBuilder: (context, index) {
            if (index >= posts.length) {
              // Show loading indicator for next page
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

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
        ),
      ),
    );
  }
}
