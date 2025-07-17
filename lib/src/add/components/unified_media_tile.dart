import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UnifiedMediaTile extends HookWidget {
  final File media;
  final PostType mediaType;
  final VoidCallback onRemove;
  final VoidCallback onPreview;
  final int? index;

  const UnifiedMediaTile({
    super.key,
    required this.media,
    required this.mediaType,
    required this.onRemove,
    required this.onPreview,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isBeingRemoved = useState<bool>(false);
    final videoController = useMemoized(
      () => mediaType == PostType.video ? VideoPlayerController.file(media) : null,
      [media, mediaType],
    );
    final isInitialized = useState<bool>(false);

    useEffect(() {
      if (mediaType == PostType.video && videoController != null) {
        videoController.initialize().then((_) {
          isInitialized.value = true;
        });
        return () => videoController.dispose();
      }
      return null;
    }, [videoController, mediaType]);

    return GestureDetector(
      onTap: onPreview,
      child: AnimatedScale(
        scale: isBeingRemoved.value ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 50),
        child: Opacity(
          opacity: isBeingRemoved.value ? 0.3 : 1.0,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Media content
                  if (mediaType == PostType.photo)
                    Image.file(
                      media,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: context.colorScheme.surfaceContainerLowest,
                          child: Icon(
                            Icons.broken_image,
                            color: context.colorScheme.onSurfaceVariant,
                            size: 48,
                          ),
                        );
                      },
                    )
                  else if (mediaType == PostType.video)
                    if (isInitialized.value && videoController != null)
                      AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController),
                      )
                    else
                      Container(
                        color: context.colorScheme.surfaceContainerLowest,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),

                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                          stops: const [0.7, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Remove button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () async {
                        isBeingRemoved.value = !isBeingRemoved.value;
                        await Future.delayed(const Duration(milliseconds: 200));
                        isBeingRemoved.value = !isBeingRemoved.value;
                        onRemove();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.colorScheme.error,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.error.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.trash,
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Preview indicator
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            mediaType == PostType.video ? Icons.play_arrow : Icons.zoom_in,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Tap to preview',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Index indicator for multiple images
                  if (index != null && mediaType == PostType.photo)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${index! + 1}',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
