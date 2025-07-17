import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/src/add/unified_media_selecting_page.dart';
import 'package:flutter/material.dart';

class VideoSelectingPage extends HookWidget {
  const VideoSelectingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UnifiedMediaSelectingPage(
      mediaType: PostType.video,
      title: 'Select Video',
      subtitle: 'Choose a video from your gallery to get started',
      bottomText: 'Maximum duration: 10 minutes',
      maxVideoDuration: const Duration(minutes: 10),
    );
  }
}
