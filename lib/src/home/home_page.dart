import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/providers/video_provider.dart';
import 'package:app/data/providers/user_provider.dart';
import 'package:app/data/providers/interaction_provider.dart';
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
  void initState() {
    super.initState();
    // Load initial posts when the page is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postProvider.notifier).loadInitialPosts();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showCommentDialog(
      BuildContext context, PostModel post, PostNotifier postNotifier, String currentUserId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CommentsSection(
          post: post,
          currentUserId: currentUserId,
          onCommentAdded: () {
            // Refresh the post to update comment count
            postNotifier.refresh();
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
    final posts = ref.watch(postProvider);
    final postNotifier = ref.read(postProvider.notifier);
    final currentUser = ref.watch(userProvider);
    final interactionState = ref.watch(interactionProvider);
    final interactionNotifier = ref.read(interactionProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Test the repositories
          if (currentUser != null && posts.isNotEmpty) {
            final post = posts.first;
            await interactionNotifier.toggleLike(post.uid, currentUser.uid, post.userUid);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Testing like functionality!')),
            );
          }
        },
        child: const Icon(Icons.favorite),
      ),
      backgroundColor: Colors.black,
      body: posts.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: posts.length + (postNotifier.hasMore ? 1 : 0),
              onPageChanged: (index) {
                // Load more posts when user is about to reach the end (2 posts before the end)
                if (index >= posts.length - 2 && postNotifier.hasMore && !postNotifier.isLoading) {
                  postNotifier.loadMorePosts();
                }

                // Increment views for the current post
                if (index < posts.length) {
                  postNotifier.incrementViews(posts[index].uid);
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

                // Initialize interactions for this post if not already done
                if (posts.isNotEmpty && currentUser != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final postIds = posts.map((p) => p.uid).toList();
                    interactionNotifier.initializeUserInteractions(currentUser.uid, postIds);
                  });
                }

                final isLiked = interactionState.likedPosts[post.uid] ?? false;
                final isSaved = interactionState.savedPosts[post.uid] ?? false;

                return PostMediaView(
                  post: post,
                  onLike: () => interactionNotifier.toggleLike(post.uid, currentUserId, post.userUid),
                  onSave: () => interactionNotifier.toggleSave(post.uid, currentUserId, post.userUid),
                  onComment: () => _showCommentDialog(context, post, postNotifier, currentUserId),
                  onShare: () => _showShareDialog(context, post),
                  isLiked: isLiked,
                  isSaved: isSaved,
                );
              },
            ),
    );
  }
}

final List<PostModel> mockPosts = [
  PostModel(
    title: 'Test title',
    uid: '1',
    userUid: '1',
    type: PostType.video,
    caption: 'Test caption',
    status: PostStatus.approved,
    createdAt: DateTime.now(),
    likes: 0,
    saves: 0,
    views: 0,
    urls: [
      'https://res.cloudinary.com/dzadvjpcd/video/upload/v1751702097/%D8%B4%D9%88%D9%83%D8%AA_%D9%8A%D8%AE%D9%84%D8%B5%D9%88%D9%86_%D8%B9%D8%A7%D8%AF_%D8%B3%D8%A7%D8%AF%D8%B3_%D9%85%D9%8A%D9%85%D8%B2_%D8%A7%D9%84%D8%B9%D8%B1%D8%A7%D9%82_y64yfp.mp4',
    ],
    comments: 0,
    moderatorUid: null,
    moderatedAt: null,
  ),
  PostModel(
    title: 'Test title',
    uid: '2',
    userUid: '2',
    type: PostType.video,
    caption: 'Test caption',
    status: PostStatus.approved,
    createdAt: DateTime.now(),
    likes: 0,
    saves: 0,
    views: 0,
    urls: ['https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'],
    comments: 0,
    moderatorUid: null,
    moderatedAt: null,
  ),
  PostModel(
    title: 'Test title',
    uid: '3',
    userUid: '3',
    type: PostType.video,
    caption: 'Test caption',
    status: PostStatus.approved,
    createdAt: DateTime.now(),
    likes: 0,
    saves: 0,
    views: 0,
    urls: ['https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'],
    comments: 0,
    moderatorUid: null,
    moderatedAt: null,
  ),
  PostModel(
    title: 'Test title',
    uid: '4',
    userUid: '4',
    type: PostType.video,
    caption: 'Test caption',
    status: PostStatus.approved,
    createdAt: DateTime.now(),
    likes: 0,
    saves: 0,
    views: 0,
    urls: ['https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'],
    comments: 0,
    moderatorUid: null,
    moderatedAt: null,
  ),
  PostModel(
    title: 'Test title',
    uid: '5',
    userUid: '5',
    type: PostType.photo,
    caption: 'Test caption',
    status: PostStatus.approved,
    createdAt: DateTime.now(),
    likes: 0,
    saves: 0,
    views: 0,
    urls: [
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
      "https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg"
    ],
    comments: 0,
    moderatorUid: null,
    moderatedAt: null,
  ),
];
