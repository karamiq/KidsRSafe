import 'package:app/common_lib.dart';
import 'package:app/data/models/post_model.dart';
import 'package:app/src/add/unified_media_selecting_page.dart';

import 'package:flutter/material.dart';

class ImagesSelectingPage extends HookWidget {
  const ImagesSelectingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UnifiedMediaSelectingPage(
      mediaType: PostType.photo,
      title: 'Select Images',
      subtitle: 'Choose one or multiple images from your gallery to get started',
      bottomText: 'You can select multiple images at once',
      maxImages: 16,
    );
  }
}
