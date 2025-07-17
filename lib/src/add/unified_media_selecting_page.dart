import 'dart:io';
import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/src/add/components/unified_empty_state.dart';
import 'package:app/src/add/components/unified_media_display.dart';
import 'package:app/src/add/components/image_preview.dart';
import 'package:app/src/add/components/video_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UnifiedMediaSelectingPage extends HookWidget {
  final PostType mediaType;
  final String title;
  final String? subtitle;
  final String? bottomText;
  final int? maxImages;
  final Duration? maxVideoDuration;

  const UnifiedMediaSelectingPage({
    super.key,
    required this.mediaType,
    required this.title,
    this.subtitle,
    this.bottomText,
    this.maxImages,
    this.maxVideoDuration,
  });

  @override
  Widget build(BuildContext context) {
    const int kMaxImageCount = 16;

    final selectedMedia = useState<List<File>>([]);
    final picker = useMemoized(() => ImagePicker(), []);

    Future<void> pickMedia() async {
      try {
        if (mediaType == PostType.photo) {
          final remainingSlots = kMaxImageCount - selectedMedia.value.length;
          if (remainingSlots <= 0) {
            Utils.showErrorSnackBar('Only $kMaxImageCount images are allowed.');
            return;
          }
          final List<XFile> images = await picker.pickMultiImage(
            limit: remainingSlots,
            maxWidth: 1024,
            maxHeight: 1024,
            imageQuality: 85,
          );
          final List<File> temp = List.of(images).map((image) => File(image.path)).toList();
          if (images.isNotEmpty) {
            // Only add up to kMaxImageCount images in total
            final newList = [...selectedMedia.value, ...temp];
            selectedMedia.value =
                newList.length > kMaxImageCount ? newList.sublist(0, kMaxImageCount) : newList;
            HapticFeedback.lightImpact();
          }
        } else {
          final XFile? video = await picker.pickVideo(
            source: ImageSource.gallery,
            maxDuration: maxVideoDuration ?? const Duration(minutes: 10),
          );
          if (video != null) {
            selectedMedia.value = [File(video.path)];
            HapticFeedback.lightImpact();
          }
        }
      } catch (e) {}
    }

    void removeMedia(int index) {
      final newList = List<File>.from(selectedMedia.value);
      newList.removeAt(index);
      selectedMedia.value = newList;
      HapticFeedback.selectionClick();
    }

    void clearAllMedia() {
      selectedMedia.value = [];
      HapticFeedback.heavyImpact();
    }

    void previewMedia(int index) {
      if (selectedMedia.value.isEmpty) return;

      if (mediaType == PostType.photo) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImagePreviewPage(
              images: selectedMedia.value,
              initialIndex: index,
            ),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPreviewPage(
              video: selectedMedia.value[index],
            ),
          ),
        );
      }
    }

    void onDone() {
      if (selectedMedia.value.isNotEmpty) {
        context.push(
          RoutesDocument.postSelectedMedia,
          extra: {
            'media': selectedMedia.value,
            'mediaType': mediaType,
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: context.colorScheme.surface,
        foregroundColor: context.colorScheme.onSurface,
        elevation: 0,
      ),
      body: selectedMedia.value.isEmpty
          ? UnifiedEmptyState(
              mediaType: mediaType,
              onPickMedia: pickMedia,
              subtitle: subtitle,
              bottomText: bottomText ?? 'You can select up to $kMaxImageCount images.',
            )
          : SafeArea(
              child: UnifiedMediaDisplay(
                media: selectedMedia.value,
                mediaType: mediaType,
                onRemoveMedia: removeMedia,
                onPreviewMedia: previewMedia,
                onSelectNewMedia: pickMedia,
                onDone: onDone,
              ),
            ),
    );
  }
}
