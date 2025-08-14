import 'package:app/data/models/post_model.dart';
import 'package:app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:app/core/utils/constants/sizes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostContentOverlay extends ConsumerWidget {
  final PostModel post;

  const PostContentOverlay({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.09,
      left: Insets.small,
      right: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Compact user info
          _buildCompactUserInfo(context, post.user),
          const SizedBox(height: 6),

          // Compact caption
          _buildCompactCaption(context),

          // Compact hashtags
          if (post.caption.contains('#')) _buildCompactHashtags(context),
        ],
      ),
    );
  }

  Widget _buildCompactUserInfo(BuildContext context, UserModel? user) {
    return Row(
      children: [
        // Compact avatar
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.purple.withOpacity(0.8), Colors.blue.withOpacity(0.8)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: user?.profilePicture != null && user!.profilePicture.isNotEmpty
                ? Image.network(
                    user.profilePicture,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(),
                  )
                : _buildDefaultAvatar(),
          ),
        ),
        const SizedBox(width: 8),

        // Compact user info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    user?.name ?? 'Unknown User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (user?.role == UserRole.admin || user?.role == UserRole.moderator)
                    _buildCompactVerificationBadge(),
                ],
              ),
              Text(
                '@${user?.username ?? 'user'}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactVerificationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.white, size: 8),
          SizedBox(width: 2),
          Text(
            '✓',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCaption(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 0.5),
      ),
      child: Text(
        post.caption,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.3,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCompactHashtags(BuildContext context) {
    final hashtags = post.caption.split(' ').where((word) => word.startsWith('#')).toList();

    if (hashtags.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Wrap(
        spacing: 4,
        runSpacing: 2,
        children: hashtags.take(3).map((hashtag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.withOpacity(0.8), Colors.blue.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              hashtag,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[400]!, Colors.grey[600]!],
        ),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
