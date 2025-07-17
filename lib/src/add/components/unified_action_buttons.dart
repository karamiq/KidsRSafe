import 'package:app/data/models/post_model.dart';
import 'package:flutter/material.dart';

class UnifiedActionButtons extends StatelessWidget {
  final PostType mediaType;
  final VoidCallback onSelectNewMedia;
  final VoidCallback onDone;
  final bool showAddMore;

  const UnifiedActionButtons({
    super.key,
    required this.mediaType,
    required this.onSelectNewMedia,
    required this.onDone,
    this.showAddMore = true,
  });

  @override
  Widget build(BuildContext context) {
    final isVideo = mediaType == PostType.video;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          if (showAddMore) ...[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onSelectNewMedia,
                icon: Icon(isVideo ? Icons.video_library : Icons.add_photo_alternate),
                label: Text(isVideo ? 'Select New Video' : 'Add More'),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: FilledButton.icon(
              onPressed: onDone,
              icon: const Icon(Icons.check),
              label: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
