import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/src/home/components/video_player_widget.dart';
import 'package:app/src/home/components/image_carousel_widget.dart';
import 'package:app/src/home/components/post_action_buttons.dart';
import 'package:flutter/material.dart';

class PostMediaView extends StatefulWidget {
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
  State<PostMediaView> createState() => _PostMediaViewState();
}

class _PostMediaViewState extends State<PostMediaView> {
  bool _showFullCaption = false;
  static const int _captionMaxLength = 120;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topCenter,
      children: [
        // Media content layer
        _buildMediaContent(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: _buildOverlayContent(context)),
            PostActionButtons(
              post: widget.post,
              onLike: widget.onLike,
              onSave: widget.onSave,
              onComment: widget.onComment,
              onShare: widget.onShare,
              isLiked: widget.isLiked,
              isSaved: widget.isSaved,
            ),

            // Action buttons at the bottom right
          ],
        ),
      ],
    );
  }

  Widget _buildMediaContent() {
    if (widget.post.type == PostType.video) {
      return VideoPlayerWidget(
        videoUrl: widget.post.urls.first,
      );
    } else {
      return ImageCarouselWidget(
        imageUrls: widget.post.urls,
      );
    }
  }

  Widget _buildOverlayContent(BuildContext context) {
    final caption = widget.post.caption;
    final showTruncate = !_showFullCaption && caption.length > _captionMaxLength;
    final displayCaption = showTruncate ? '${caption.substring(0, _captionMaxLength)}...' : caption;
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: Insets.smallAll,
        margin: EdgeInsets.symmetric(vertical: Insets.extraLarge),
        decoration: BoxDecoration(
            //  color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            color: _showFullCaption ? context.colorScheme.onBackground.withOpacity(.7) : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.post.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              displayCaption,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              maxLines: showTruncate ? 3 : null,
              overflow: showTruncate ? TextOverflow.ellipsis : null,
            ),
            GestureDetector(
              onTap: () => setState(() => _showFullCaption = !_showFullCaption),
              child: Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  !_showFullCaption ? 'Read more' : 'Read less',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
