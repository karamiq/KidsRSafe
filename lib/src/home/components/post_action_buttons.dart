import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:app/core/utils/constants/sizes.dart';
import 'package:go_router/go_router.dart';

class PostActionButtons extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final bool isLiked;
  final bool isSaved;

  const PostActionButtons({
    super.key,
    required this.post,
    this.onLike,
    this.onSave,
    this.onComment,
    this.onShare,
    this.isLiked = false,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    final h = context.height;
    return Container(
      padding: Insets.mediumAll,
      height: h,
      alignment: Alignment(0, .6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile picture action button
          GestureDetector(
            onTap: () {
              context.push('/profiles/${post.user.uid}');
            },
            child: Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(bottom: Insets.small),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: post.user.profilePicture.isNotEmpty
                    ? Image.network(
                        post.user.profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, color: Colors.white),
                      )
                    : const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            label: post.likes.toString(),
            onTap: onLike,
            isActive: isLiked,
          ),
          const SizedBox(height: Insets.small),
          _buildActionButton(
            icon: Icons.comment,
            label: post.comments.toString(),
            onTap: onComment,
          ),
          const SizedBox(height: Insets.small),
          _buildActionButton(
            icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
            label: post.saves.toString(),
            onTap: onSave,
            isActive: isSaved,
          ),
          const SizedBox(height: Insets.small),
          _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onTap: onShare,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    bool isActive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.red : Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: Insets.extraSmall),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
