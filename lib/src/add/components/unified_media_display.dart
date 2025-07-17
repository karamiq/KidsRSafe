import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/src/add/components/unified_media_tile.dart';
import 'package:app/src/add/components/unified_action_buttons.dart';
import 'package:app/src/add/components/thumbnail_strip.dart';
import 'package:app/src/add/components/page_indicator.dart';
import 'package:flutter/material.dart';

class UnifiedMediaDisplay extends HookWidget {
  final List<File> media;
  final PostType mediaType;
  final Function(int)? onRemoveMedia;
  final Function(int)? onPreviewMedia;
  final VoidCallback onSelectNewMedia;
  final VoidCallback onDone;

  const UnifiedMediaDisplay({
    super.key,
    required this.media,
    required this.mediaType,
    this.onRemoveMedia,
    this.onPreviewMedia,
    required this.onSelectNewMedia,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(0);
    final isVideo = mediaType == PostType.video;
    final scrollController = useScrollController();

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: _buildUnifiedMediaDisplay(context, selectedIndex, scrollController),
              ),
              if (!isVideo && media.length > 1) ...[
                Expanded(
                  child: ThumbnailStrip(
                    controller: scrollController,
                    images: media,
                    selectedIndex: selectedIndex.value,
                    onThumbnailSelected: (index) => selectedIndex.value = index,
                  ),
                ),
                PageIndicator(
                  totalPages: media.length,
                  currentPage: selectedIndex.value,
                ),
              ],
              UnifiedActionButtons(
                mediaType: mediaType,
                onSelectNewMedia: onSelectNewMedia,
                onDone: onDone,
                showAddMore: !isVideo,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnifiedMediaDisplay(
      BuildContext context, ValueNotifier<int> selectedIndex, ScrollController scrollController) {
    final isVideo = mediaType == PostType.video;

    // For videos or single images, use UnifiedMediaTile directly
    if (isVideo || media.length == 1) {
      return UnifiedMediaTile(
        media: media.first,
        mediaType: mediaType,
        onRemove: () => onRemoveMedia?.call(0),
        onPreview: () => onPreviewMedia?.call(0),
      );
    }

    // For multiple images, wrap in PageView
    final pageController = usePageController(initialPage: selectedIndex.value);
    useEffect(() {
      if (pageController.hasClients) {
        final currentPage = pageController.page?.round() ?? 0;
        if (currentPage != selectedIndex.value) {
          pageController.jumpToPage(
            selectedIndex.value,
          );
        }
      }
      return null;
    }, [selectedIndex.value]);

    return Container(
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
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (index) {
            selectedIndex.value = index;
          },
          itemCount: media.length,
          itemBuilder: (context, index) {
            return UnifiedMediaTile(
              media: media[index],
              mediaType: mediaType,
              onRemove: () => onRemoveMedia?.call(index),
              onPreview: () => onPreviewMedia?.call(index),
              index: index,
            );
          },
        ),
      ),
    );
  }
}
