import 'package:app/data/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:app/core/utils/constants/sizes.dart';

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
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.5,
      left: 0,
      right: 0,
      child: Container(
        padding: Insets.mediumAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionButton(
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              label: post.likes.toString(),
              onTap: onLike,
              isActive: isLiked,
            ),
            const SizedBox(height: Insets.medium),
            _buildActionButton(
              icon: Icons.comment,
              label: post.comments.toString(),
              onTap: onComment,
            ),
            const SizedBox(height: Insets.medium),
            _buildActionButton(
              icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
              label: post.saves.toString(),
              onTap: onSave,
              isActive: isSaved,
            ),
            const SizedBox(height: Insets.medium),
            _buildActionButton(
              icon: Icons.share,
              label: 'Share',
              onTap: onShare,
            ),
          ],
        ),
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
            width: 48,
            height: 48,
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
