import 'package:app/common_lib.dart';
import 'package:app/data/models/comment_model.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/data/models/user_model.dart';
import 'package:app/data/repositories/firestore_repo/comment_repository.dart';
import 'package:app/data/repositories/firestore_repo/user_repository.dart';
import 'package:app/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CommentsSection extends ConsumerStatefulWidget {
  final PostModel post;
  final String currentUserId;
  final VoidCallback? onCommentAdded;

  const CommentsSection({
    super.key,
    required this.post,
    required this.currentUserId,
    this.onCommentAdded,
  });

  @override
  ConsumerState<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends ConsumerState<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();
  late final CommentRepository _commentRepository;
  late final UserRepository _userRepository;

  List<CommentModel> _comments = [];
  List<UserModel?> _commentUsers = [];
  bool _isLoading = false;
  bool _isSubmitting = false;
  String? _replyToCommentId;
  String? _replyToUsername;

  @override
  void initState() {
    super.initState();
    _commentRepository = CommentRepository();
    _userRepository = UserRepository(ref: ref as Ref);
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final comments = await _commentRepository.getCommentsForPost(widget.post.uid);
      final users = await Future.wait(comments.map((comment) => _userRepository.getUser(comment.userId)));

      setState(() {
        _comments = comments;
        _commentUsers = users;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading comments: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final commentId = await _commentRepository.addComment(
        userId: widget.currentUserId,
        postId: widget.post.uid,
        content: _commentController.text.trim(),
        parentCommentId: _replyToCommentId,
      );

      // Refresh comments
      await _loadComments();

      // Clear input
      _commentController.clear();
      _replyToCommentId = null;
      _replyToUsername = null;

      // Notify parent
      widget.onCommentAdded?.call();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment added successfully!')),
        );
      }
    } catch (e) {
      debugPrint('Error submitting comment: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding comment: $e')),
        );
      }
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _replyToComment(CommentModel comment, String username) {
    setState(() {
      _replyToCommentId = comment.uid;
      _replyToUsername = username;
    });
    _commentController.text = '@$username ';
    _commentController.selection = TextSelection.fromPosition(
      TextPosition(offset: _commentController.text.length),
    );
  }

  void _cancelReply() {
    setState(() {
      _replyToCommentId = null;
      _replyToUsername = null;
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: Insets.mediumAll,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Comments List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _comments.isEmpty
                    ? const Center(
                        child: Text(
                          'No comments yet. Be the first to comment!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: Insets.mediumAll,
                        itemCount: _comments.length,
                        itemBuilder: (context, index) {
                          final comment = _comments[index];
                          final user = _commentUsers[index];

                          return _buildCommentTile(comment, user);
                        },
                      ),
          ),

          // Reply indicator
          if (_replyToUsername != null)
            Container(
              padding: Insets.smallAll,
              color: Colors.grey[100],
              child: Row(
                children: [
                  Text(
                    'Replying to $_replyToUsername',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _cancelReply,
                    icon: const Icon(Icons.close, size: 16),
                  ),
                ],
              ),
            ),

          // Comment Input
          Container(
            padding: Insets.mediumAll,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText:
                          _replyToUsername != null ? 'Reply to $_replyToUsername...' : 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _submitComment(),
                  ),
                ),
                const SizedBox(width: Insets.small),
                _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        onPressed: _submitComment,
                        icon: const Icon(Icons.send),
                        color: Colors.blue,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentTile(CommentModel comment, UserModel? user) {
    final username = user?.name ?? 'Unknown User';
    final isCurrentUser = comment.userId == widget.currentUserId;

    return Container(
      margin: const EdgeInsets.only(bottom: Insets.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          CircleAvatar(
            radius: 16,
            backgroundImage: user?.profilePicture != null ? NetworkImage(user!.profilePicture) : null,
            child: user?.profilePicture == null ? Text(username[0].toUpperCase()) : null,
          ),
          const SizedBox(width: Insets.small),

          // Comment Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: Insets.extraSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'You',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      _formatTimeAgo(comment.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: Insets.medium),
                    GestureDetector(
                      onTap: () => _replyToComment(comment, username),
                      child: const Text(
                        'Reply',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (comment.replies > 0) ...[
                      const SizedBox(width: Insets.medium),
                      Text(
                        '${comment.replies} replies',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Like Button
          Column(
            children: [
              IconButton(
                onPressed: () {
                  // TODO: Implement comment liking
                },
                icon: Icon(
                  comment.likes > 0 ? Icons.favorite : Icons.favorite_border,
                  size: 16,
                  color: comment.likes > 0 ? Colors.red : Colors.grey,
                ),
              ),
              if (comment.likes > 0)
                Text(
                  comment.likes.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
