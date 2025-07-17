import 'package:app/core/utils/extensions.dart';
import 'package:app/data/models/post_model.dart';
import 'package:flutter/material.dart';

class UnifiedEmptyState extends StatelessWidget {
  final PostType mediaType;
  final VoidCallback onPickMedia;
  final String? subtitle;
  final String? bottomText;

  const UnifiedEmptyState({
    super.key,
    required this.mediaType,
    required this.onPickMedia,
    this.subtitle,
    this.bottomText,
  });

  @override
  Widget build(BuildContext context) {
    final isVideo = mediaType == PostType.video;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colorScheme.primaryContainer.withOpacity(0.3),
                    context.colorScheme.primaryContainer.withOpacity(0.1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primaryContainer.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                isVideo ? Icons.video_library_rounded : Icons.photo_library_rounded,
                size: 70,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              isVideo ? 'Select Your Video' : 'Select Your Images',
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle ??
                  (isVideo
                      ? 'Choose a video from your gallery to get started'
                      : 'Choose one or multiple images from your gallery to get started'),
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant.withOpacity(0.8),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.icon(
                onPressed: onPickMedia,
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                icon: Icon(
                  isVideo ? Icons.video_library_rounded : Icons.photo_library_rounded,
                  size: 24,
                ),
                label: Text(
                  isVideo ? 'Select Video' : 'Select Images',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (bottomText != null) ...[
              const SizedBox(height: 16),
              Text(
                bottomText!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
