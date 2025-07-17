import 'package:app/data/models/post_model.dart';
import 'package:app/src/home/components/video_player_widget.dart';
import 'package:app/src/home/components/image_carousel_widget.dart';
import 'package:app/src/home/components/post_content_overlay.dart';
import 'package:app/src/home/components/post_action_buttons.dart';
import 'package:flutter/material.dart';

class PostMediaView extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final bool isLiked;
  final bool isSaved;

  const PostMediaView({
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
    return Stack(
      fit: StackFit.expand,
      children: [
        // Media content layer
        _buildMediaContent(),

        // Content overlay layer (title and caption)
        PostContentOverlay(post: post),

        // Action buttons layer
        PostActionButtons(
          post: post,
          onLike: onLike,
          onSave: onSave,
          onComment: onComment,
          onShare: onShare,
          isLiked: isLiked,
          isSaved: isSaved,
        ),
      ],
    );
  }

  Widget _buildMediaContent() {
    if (post.type == PostType.video) {
      return VideoPlayerWidget(
        videoUrl: post.urls.first,
      );
    } else {
      return ImageCarouselWidget(
        imageUrls: post.urls,
      );
    }
  }
}
